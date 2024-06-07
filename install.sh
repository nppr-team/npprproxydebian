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

# Создаем скрипт-оболочку для выполнения основного скрипта в интерактивном режиме
cat <<EOF > $TMP_DIR/run_script.sh
#!/bin/bash

# Запускаем основной скрипт
bash "$SCRIPT_FILE"

# Удаляем временные файлы после выполнения
rm -rf "$TMP_DIR"
EOF

# Делаем скрипт-оболочку исполняемым
chmod +x $TMP_DIR/run_script.sh

# Запуск скрипта-оболочки
$TMP_DIR/run_script.sh
