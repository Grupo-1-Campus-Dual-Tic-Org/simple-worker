# go build -o app .

#!/bin/bash

# Directorio de salida
OUTPUT_DIR="dist"

# Crear el directorio de salida si no existe
mkdir -p "$OUTPUT_DIR"

# Versiones de Go
GOOS_ARCH=(
  "linux amd64"
  "linux arm64"
  "windows amd64"
)

# Compilar para cada combinación de sistema operativo y arquitectura
for os_arch in "${GOOS_ARCH[@]}"; do
  os=$(echo "$os_arch" | awk '{print $1}')
  arch=$(echo "$os_arch" | awk '{print $2}')

  # Nombre del ejecutable
  if [[ "$os" == "windows" ]]; then
    executable_name="bluengo-worker-$os-$arch.exe"
  else
    executable_name="bluengo-worker-$os-$arch"
  fi

  # Establecer variables de entorno
  GOOS="$os"
  GOARCH="$arch"

  # Comando de compilación
  echo "Compilando para $GOOS $GOARCH..."
  go build -ldflags="-s -w" -o "$OUTPUT_DIR/$executable_name" ./app-bluengo-worker

  echo "Compilación para $GOOS $GOARCH completada."
done

echo "Compilaciones completadas. Los ejecutables están en el directorio $OUTPUT_DIR."