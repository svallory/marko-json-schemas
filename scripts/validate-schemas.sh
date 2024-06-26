#!/bin/sh

# This method relies on $0 and a simple case check
SCRIPT_DIR=$(
  cd "$(dirname "$0")"
  pwd
)

cd "$SCRIPT_DIR/.."
echo "Working directory: $(pwd)"

# BASE_URI="file://$(pwd)/src/"
BASE_URI="http://localhost:4321/contributes/marko-js/schemas"

echo "Base URI: $BASE_URI"

echo "\n"
echo "🟠 Validating the schemas"
echo "------------------------------------------------------------"
check-jsonschema --verbose \
  --check-metaschema http://localhost:4321/contributes/marko-js/schemas/marko ./schemas/**/*.json ./src/**/*.yaml

echo "\n"
echo "🟡 Validating marko-tag.json examples"
echo "------------------------------------------------------------"
check-jsonschema --verbose \
  --base-uri "$BASE_URI" \
  --schemafile ./src/marko-tag.yaml \
  ./tests/local/marko-tag/*.json

echo "\n"
echo "🟢 Validating marko.json examples"
echo "------------------------------------------------------------"
check-jsonschema --verbose \
  --base-uri "$BASE_URI" \
  --schemafile ./src/marko.yaml \
  ./tests/local/marko/*.json
