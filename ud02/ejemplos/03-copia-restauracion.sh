#!/usr/bin/env bash
# Ejemplo formativo: copia y restauración de datos ficticios en Linux.

set -euo pipefail
umask 077

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(git -C "$script_dir" rev-parse --show-toplevel)"
lab_root="$repo_root/ud02/lab"
mkdir -p -- "$lab_root"
lab_dir="$(mktemp -d "$lab_root/copia-restauracion.XXXXXX")"

for command in openssl tar stat cmp; do
    if ! command -v "$command" >/dev/null 2>&1; then
        printf 'Falta el comando requerido: %s\n' "$command" >&2
        exit 1
    fi
done

mkdir -- "$lab_dir/datos" "$lab_dir/recuperados"
printf 'Contrato ficticio AulaFP\nCliente: ejemplo no real\n' \
    > "$lab_dir/datos/contrato.txt"
printf 'Nómina ficticia AulaFP\nPersona: ejemplo no real\n' \
    > "$lab_dir/datos/nomina.txt"
chmod 600 "$lab_dir/datos/contrato.txt" "$lab_dir/datos/nomina.txt"

printf '%s\n' 'Hashes originales:'
openssl dgst -sha256 "$lab_dir/datos/contrato.txt" "$lab_dir/datos/nomina.txt"

tar -czf "$lab_dir/respaldo.tar.gz" -C "$lab_dir/datos" .
printf '\n%s\n' 'Contenido del archivo de respaldo:'
tar -tzf "$lab_dir/respaldo.tar.gz"
tar -xzf "$lab_dir/respaldo.tar.gz" -C "$lab_dir/recuperados"

printf '\n%s\n' 'Hashes restaurados (deben coincidir con los originales):'
openssl dgst -sha256 \
    "$lab_dir/recuperados/contrato.txt" "$lab_dir/recuperados/nomina.txt"

for filename in contrato.txt nomina.txt; do
    if ! cmp -s "$lab_dir/datos/$filename" "$lab_dir/recuperados/$filename"; then
        printf 'ERROR: el contenido restaurado de %s no coincide.\n' "$filename" >&2
        exit 1
    fi
    if [ "$(stat -c '%a' "$lab_dir/datos/$filename")" != \
         "$(stat -c '%a' "$lab_dir/recuperados/$filename")" ]; then
        printf 'ERROR: los permisos restaurados de %s no coinciden.\n' "$filename" >&2
        exit 1
    fi
done

printf '\n%s\n' 'OK: contenido y permisos restaurados coinciden.'
printf 'Archivos de prueba guardados en: %s\n' "$lab_dir"
