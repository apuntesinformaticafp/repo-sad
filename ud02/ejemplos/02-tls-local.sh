#!/usr/bin/env bash
# Ejemplo formativo: certificado y conexión TLS únicamente en localhost.

set -euo pipefail
umask 077

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(git -C "$script_dir" rev-parse --show-toplevel)"
lab_root="$repo_root/ud02/lab"
mkdir -p -- "$lab_root"
lab_dir="$(mktemp -d "$lab_root/tls-local.XXXXXX")"
port=18443
server_pid=''

cleanup() {
    if [ -n "$server_pid" ]; then
        kill "$server_pid" 2>/dev/null || true
        wait "$server_pid" 2>/dev/null || true
    fi
}
trap cleanup EXIT

for command in openssl ss grep sleep; do
    if ! command -v "$command" >/dev/null 2>&1; then
        printf 'Falta el comando requerido: %s\n' "$command" >&2
        exit 1
    fi
done

if ss -H -ltn "sport = :$port" | grep -q .; then
    printf 'El puerto local %s ya está ocupado; no se inicia el servidor.\n' "$port" >&2
    exit 1
fi

openssl req -new -x509 -newkey rsa:2048 -noenc \
    -keyout "$lab_dir/servidor.key" -out "$lab_dir/servidor.crt" -days 7 \
    -subj '/CN=local.test' \
    -addext 'subjectAltName=DNS:local.test' \
    -addext 'basicConstraints=critical,CA:FALSE' \
    -addext 'extendedKeyUsage=serverAuth'

printf '\n%s\n' 'Campos del certificado de laboratorio:'
openssl x509 -in "$lab_dir/servidor.crt" -noout \
    -subject -issuer -dates -ext subjectAltName

printf '\n%s\n' 'Validación directa con la referencia local y nombre correcto (debe funcionar):'
openssl verify -CAfile "$lab_dir/servidor.crt" -purpose sslserver \
    -verify_hostname local.test "$lab_dir/servidor.crt"

printf '\n%s\n' 'Validación con otro nombre (debe fallar):'
if openssl verify -CAfile "$lab_dir/servidor.crt" -purpose sslserver \
    -verify_hostname otro.test "$lab_dir/servidor.crt"; then
    printf '%s\n' 'ERROR: se aceptó un nombre que no aparece en el certificado.' >&2
    exit 1
else
    printf '%s\n' 'Resultado esperado: el nombre no coincide.'
fi

printf '\n%s\n' 'Inicia el servicio de prueba solo en 127.0.0.1.'
openssl s_server -accept "127.0.0.1:$port" \
    -cert "$lab_dir/servidor.crt" -key "$lab_dir/servidor.key" -www \
    > "$lab_dir/servidor.log" 2>&1 &
server_pid=$!

listening=0
for ((attempt = 0; attempt < 50; attempt++)); do
    if ss -H -ltn "sport = :$port" | grep -q .; then
        listening=1
        break
    fi
    sleep 0.1
done
if [ "$listening" -ne 1 ]; then
    printf '%s\n' 'No se pudo iniciar la escucha TLS local:' >&2
    cat "$lab_dir/servidor.log" >&2
    exit 1
fi

printf '\n%s\n' 'Conexión al nombre correcto (debe verificar):'
openssl s_client -connect "127.0.0.1:$port" -servername local.test \
    -CAfile "$lab_dir/servidor.crt" -verify_hostname local.test \
    -verify_return_error -brief < /dev/null

printf '\n%s\n' 'Conexión con otro nombre (debe fallar la validación):'
if openssl s_client -connect "127.0.0.1:$port" -servername local.test \
    -CAfile "$lab_dir/servidor.crt" -verify_hostname otro.test \
    -verify_return_error -brief < /dev/null; then
    printf '%s\n' 'ERROR: se aceptó inesperadamente el nombre incorrecto.' >&2
    exit 1
else
    printf '%s\n' 'Resultado esperado: la identidad no coincide.'
fi

printf '\n%s\n' 'Conexión sin indicar la CA local (debe fallar la confianza):'
if openssl s_client -connect "127.0.0.1:$port" -servername local.test \
    -verify_hostname local.test -verify_return_error -brief < /dev/null; then
    printf '%s\n' 'ERROR: se aceptó inesperadamente la CA no reconocida.' >&2
    exit 1
else
    printf '%s\n' 'Resultado esperado: el emisor no se reconoce.'
fi

printf '\nCertificado y registro local guardados en: %s\n' "$lab_dir"
printf '%s\n' 'El servidor se detendrá al salir; el certificado no se instala en el sistema.'
