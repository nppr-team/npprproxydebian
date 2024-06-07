#!/bin/bash

# Обновление и установка curl, если он не установлен
apt update && apt install -y curl

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

# Запускаем скрипт в интерактивном режиме
bash -i "$SCRIPT_FILE"

# Удаляем временные файлы (после выполнения скрипта)
rm -rf "$TMP_DIR"
