#!/bin/sh
set -eu

# Check required tools
if ! command -v jq >/dev/null 2>&1; then
  echo "❌ 'jq' is required but not found. Install it with 'brew install jq' or your package manager."
  exit 1
fi

get_product_json() {
  link_file=$(readlink "$(which "$1")")
  link_dir=$(dirname "$link_file")
  app_dir=$(dirname "$link_dir")

  echo "${app_dir}/product.json"
}

if [ -z "${1-}" ]; then
  echo "⚠️ No target product chosen, eg, \`cursor\`, \`windsurf\` or etc"
  exit 1
fi

VSCODE_PRODUCT_JSON=$(get_product_json "code")
TARGET_PRODUCT_JSON=$(get_product_json "$1")

if [ ! -f "$VSCODE_PRODUCT_JSON" ]; then
  echo "❌ VS Code product.json not found at: $VSCODE_PRODUCT_JSON"
  exit 1
fi

if [ ! -f "$TARGET_PRODUCT_JSON" ]; then
  echo "❌ $1 product.json not found at: $TARGET_PRODUCT_JSON"
  exit 1
fi

# Extract galleries
VSCODE_GALLERY=$(jq -c '.extensionsGallery' "$VSCODE_PRODUCT_JSON")
TARGET_GALLERY=$(jq -c '.extensionsGallery' "$TARGET_PRODUCT_JSON")

# Check if already patched
if [ "$VSCODE_GALLERY" = "$TARGET_GALLERY" ]; then
  echo "✅ '$1' is already using the official VS Code Marketplace. No patch needed."
  exit 0
fi

# Backup original Cursor product.json
cp "$TARGET_PRODUCT_JSON" "$TARGET_PRODUCT_JSON.bak"
echo "📦 Backup created: $TARGET_PRODUCT_JSON.bak"

jq --argjson gallery "$VSCODE_GALLERY" '.extensionsGallery = $gallery' "$TARGET_PRODUCT_JSON" >"${TARGET_PRODUCT_JSON}.patched"
mv "${TARGET_PRODUCT_JSON}.patched" "$TARGET_PRODUCT_JSON"

echo "✅ Patched \`$1\` to use VS Code Marketplace. Restart \`$1\` to apply changes."
