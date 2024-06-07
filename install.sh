#!/bin/bash

# Обновление и установка необходимых пакетов
apt update && apt install -y curl screen

# URL вашего скрипта
SCRIPT_URL="http://94.103.85.26/npprproxyfull.sh"

# Папка для временного хранения скрипта
TMP_DIR=$(mktemp -d)

# Файл для временного хранения скрипта
SCRIPT_FILE="$TMP_DIR/npprproxyfull.sh"

# Скачиваем скрипт
curl -o "$SCRIPT_FILE" "$SCRIPT_URL"

# Делаем скрипт исполняемым
chmod +x "$SCRIPT_FILE"

# Запускаем скрипт в интерактивном режиме через screen
screen -dmS npprproxy bash -c "$SCRIPT_FILE; exec bash"

# Удаляем временные файлы (после выполнения скрипта)
rm -rf "$TMP_DIR"

echo "Скрипт запущен в интерактивной сессии screen. Подключиться к сессии можно командой 'screen -r npprproxy'."
