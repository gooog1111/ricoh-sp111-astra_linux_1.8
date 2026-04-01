#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FILTER_SRC="${SCRIPT_DIR}/pstoricohddst-gdi"
PPD_DIR="/usr/share/ppd/ricoh-sp111"
FILTER_DST="/usr/lib/cups/filter/pstoricohddst-gdi"

if [[ "${EUID}" -ne 0 ]]; then
    echo "Запустите скрипт с правами root: sudo ./install.sh" >&2
    exit 1
fi

if [[ ! -f "${FILTER_SRC}" ]]; then
    echo "Не найден файл фильтра: ${FILTER_SRC}" >&2
    exit 1
fi

echo "Проверяю исходные файлы..."
for file in \
    "${SCRIPT_DIR}/RICOH_Aficio_SP_100.ppd" \
    "${SCRIPT_DIR}/RICOH_Aficio_SP_111.ppd" \
    "${SCRIPT_DIR}/RICOH_Aficio_SP_204.ppd"; do
    [[ -f "${file}" ]] || { echo "Не найден файл: ${file}" >&2; exit 1; }
done

echo "Устанавливаю фильтр CUPS..."
install -m 755 -o root -g root "${FILTER_SRC}" "${FILTER_DST}"

echo "Копирую PPD..."
mkdir -p "${PPD_DIR}"
install -m 644 -o root -g root \
    "${SCRIPT_DIR}/RICOH_Aficio_SP_100.ppd" \
    "${SCRIPT_DIR}/RICOH_Aficio_SP_111.ppd" \
    "${SCRIPT_DIR}/RICOH_Aficio_SP_204.ppd" \
    "${PPD_DIR}/"

echo "Перезапускаю CUPS..."
if command -v systemctl >/dev/null 2>&1; then
    systemctl restart cups
else
    service cups restart
fi

cat <<'EOF'
Установка завершена.

Дальше:
1. Откройте http://localhost:631/
2. Добавьте принтер
3. При выборе драйвера укажите нужный PPD из /usr/share/ppd/ricoh-sp111/
EOF
