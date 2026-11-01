#!/bin/bash

[ -z "$1" ] && { echo "Использование: $0 <каталог>" >&2; exit 1; }
[ ! -d "$1" ] && { echo "Ошибка: '$1' — не каталог" >&2; exit 1; }

NOW=$(date +%Y%m%d_%H%M%S)
OUT="/tmp/backup_$NOW.tar.gz"
PART="$OUT.part"

trap 'rm -f "$PART"; exit 1' SIGINT

if tar -czf "$PART" "$1" 2>/dev/null; then
    mv "$PART" "$OUT"
    echo "Готово: $OUT"
else
    echo "Ошибка архивации" >&2
    rm -f "$PART"
    exit 1
fi
