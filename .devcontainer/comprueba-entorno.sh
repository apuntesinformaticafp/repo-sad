#!/usr/bin/env bash
# Comprobar el entorno de laboratorio para las prácticas de SAD.
# Codespaces la ejecuta automáticamente al crear el Codespace.
# En tu copia local puedes lanzarla así:  bash .devcontainer/comprueba-entorno.sh

set -u

echo "== SAD · comprobación del entorno de laboratorio =="
falta=0

comprueba() {
    cmd="$1"
    pkg="$2"
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "OK      $cmd"
    else
        echo "FALTA   $cmd  (prueba: sudo apt-get install -y $pkg)"
        falta=1
    fi
}

comprueba git git
comprueba openssl openssl
comprueba tar tar
comprueba ss iproute2
comprueba sha256sum coreutils
comprueba sed sed
comprueba grep grep

echo
if [ "$falta" -eq 0 ]; then
    echo "== Pruebas locales de OpenSSL, tar y ss =="
    umask 077
    temporal="$(mktemp -d)"
    trap 'rm -rf -- "$temporal"' EXIT

    if openssl req -new -x509 -newkey rsa:2048 -noenc \
        -keyout "$temporal/lab.key" -out "$temporal/lab.crt" -days 1 \
        -subj '/CN=local.test' \
        -addext 'subjectAltName=DNS:local.test' \
        -addext 'basicConstraints=critical,CA:FALSE' \
        -addext 'extendedKeyUsage=serverAuth' >/dev/null 2>&1 \
        && openssl verify -CAfile "$temporal/lab.crt" -purpose sslserver \
            -verify_hostname local.test "$temporal/lab.crt" >/dev/null 2>&1; then
        echo "OK      OpenSSL: certificado de laboratorio y nombre correcto"
    else
        echo "FALLO   OpenSSL: no se pudo crear o verificar el certificado de prueba"
        falta=1
    fi

    if [ -f "$temporal/lab.crt" ]; then
        if openssl verify -CAfile "$temporal/lab.crt" -purpose sslserver \
            -verify_hostname otro.test "$temporal/lab.crt" >/dev/null 2>&1; then
            echo "FALLO   OpenSSL: se aceptó inesperadamente otro nombre"
            falta=1
        else
            echo "OK      OpenSSL: se rechaza el nombre que no coincide"
        fi
    fi

    mkdir "$temporal/datos" "$temporal/restaurados"
    printf 'Contenido ficticio de prueba.\n' > "$temporal/datos/nota.txt"
    chmod 600 "$temporal/datos/nota.txt"
    if tar -czf "$temporal/respaldo.tar.gz" -C "$temporal/datos" . \
        && tar -tzf "$temporal/respaldo.tar.gz" >/dev/null \
        && tar -xzf "$temporal/respaldo.tar.gz" -C "$temporal/restaurados" \
        && cmp -s "$temporal/datos/nota.txt" "$temporal/restaurados/nota.txt" \
        && [ "$(stat -c '%a' "$temporal/datos/nota.txt")" = \
             "$(stat -c '%a' "$temporal/restaurados/nota.txt")" ]; then
        echo "OK      tar: respaldo, restauración, contenido y permisos"
    else
        echo "FALLO   tar: la prueba de restauración no se completó correctamente"
        falta=1
    fi

    if ss -tuln >/dev/null; then
        echo "OK      ss: inventario de escuchas"
    else
        echo "FALLO   ss: no se pudo consultar el inventario de escuchas"
        falta=1
    fi

    if [ "$falta" -eq 0 ]; then
        echo "Entorno listo para las prácticas de SAD."
        echo "Las pruebas usaron archivos temporales y no contactaron servicios externos."
        echo "Recuerda: datos ficticios, claves desechables y sin publicar claves privadas."
    fi
else
    echo "Completa lo que falta antes de empezar la práctica 2."
fi
exit "$falta"
