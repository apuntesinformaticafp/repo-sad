#!/usr/bin/env bash
# Ejemplo formativo: cifrado, hash y firma con archivos ficticios.

set -euo pipefail
umask 077

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(git -C "$script_dir" rev-parse --show-toplevel)"
lab_root="$repo_root/ud02/lab"
mkdir -p -- "$lab_root"
lab_dir="$(mktemp -d "$lab_root/proteccion-documento.XXXXXX")"

for command in openssl cp sed; do
    if ! command -v "$command" >/dev/null 2>&1; then
        printf 'Falta el comando requerido: %s\n' "$command" >&2
        exit 1
    fi
done

printf 'Contrato ficticio AulaFP\nVersión de prueba: 1\n' > "$lab_dir/contrato.txt"
cp -- "$lab_dir/contrato.txt" "$lab_dir/contrato_modificado.txt"
sed -i 's/Versión de prueba: 1/Versión de prueba: 2/' \
    "$lab_dir/contrato_modificado.txt"

printf '%s\n' 'Cifra el contrato; introduce una contraseña de laboratorio, no reutilizada.'
openssl enc -aes-256-cbc -pbkdf2 -iter 200000 -salt \
    -in "$lab_dir/contrato.txt" -out "$lab_dir/contrato.txt.enc"
openssl enc -d -aes-256-cbc -pbkdf2 -iter 200000 \
    -in "$lab_dir/contrato.txt.enc" -out "$lab_dir/contrato_recuperado.txt"

printf '\n%s\n' 'Resúmenes SHA-256 (original y recuperado deben coincidir):'
openssl dgst -sha256 "$lab_dir/contrato.txt" "$lab_dir/contrato_recuperado.txt"
printf '\n%s\n' 'Resumen de la copia modificada (debe ser distinto):'
openssl dgst -sha256 "$lab_dir/contrato_modificado.txt"

openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 \
    -out "$lab_dir/clave_privada.pem"
openssl pkey -in "$lab_dir/clave_privada.pem" -pubout \
    -out "$lab_dir/clave_publica.pem"
openssl dgst -sha256 -sign "$lab_dir/clave_privada.pem" \
    -out "$lab_dir/firma.bin" "$lab_dir/contrato.txt"

printf '\n%s\n' 'Verificación del contrato original (debe ser correcta):'
openssl dgst -sha256 -verify "$lab_dir/clave_publica.pem" \
    -signature "$lab_dir/firma.bin" "$lab_dir/contrato.txt"

printf '\n%s\n' 'Verificación de la copia modificada (debe fallar):'
if openssl dgst -sha256 -verify "$lab_dir/clave_publica.pem" \
    -signature "$lab_dir/firma.bin" "$lab_dir/contrato_modificado.txt"; then
    printf '%s\n' 'ERROR: la firma se aceptó sobre el contenido modificado.' >&2
    exit 1
else
    printf '%s\n' 'Resultado esperado: la firma no corresponde a la copia modificada.'
fi

printf '\nArchivos de prueba guardados en: %s\n' "$lab_dir"
printf '%s\n' 'Son desechables; no publiques ni reutilices la clave privada.'
