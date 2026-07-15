#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="assets/maps"
TARGET_FILE="$TARGET_DIR/peru_departments.geojson"
SOURCE_URL="https://raw.githubusercontent.com/juaneladio/peru-geojson/refs/heads/master/peru_departamental_simple.geojson"

mkdir -p "$TARGET_DIR"

echo "Descargando GeoJSON departamental del Perú..."
curl -L --fail --silent --show-error \
  "$SOURCE_URL" \
  -o "$TARGET_FILE"

echo "Validando JSON..."
python3 -m json.tool "$TARGET_FILE" >/dev/null

echo "Verificando estructura GeoJSON..."
python3 - <<'PY'
import json
from pathlib import Path

path = Path("assets/maps/peru_departments.geojson")
data = json.loads(path.read_text(encoding="utf-8"))

assert data.get("type") == "FeatureCollection", "No es un FeatureCollection."
features = data.get("features", [])
assert features, "El archivo no contiene features."

names = []
for feature in features:
    props = feature.get("properties", {})
    name = props.get("NOMBDEP")
    if name:
        names.append(name)

assert names, "No se encontró la propiedad NOMBDEP."
print(f"GeoJSON válido: {len(features)} departamentos.")
print("Ejemplos:", ", ".join(names[:5]))
PY

echo
echo "Listo: $TARGET_FILE"
echo "Ahora ejecuta:"
echo "  flutter clean"
echo "  flutter pub get"
echo "  flutter analyze"
echo "  flutter run -d chrome"
