#!/bin/bash

# Обновление и установка curl и expect, если они не установлены
apt update && apt install -y curl expect

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

# Создаем expect скрипт для выполнения вашего скрипта в интерактивном режиме
cat <<EOF > $TMP_DIR/run_expect.sh
#!/usr/bin/expect -f

set timeout -1
spawn bash "$SCRIPT_FILE"

# Ожидание ввода и отправка ответов
expect {
    "Подсеть (например, 48):" { send -- "64\r"; exp_continue }
    "Логин и пароль:" { exp_continue }
    "1) Указать" { send -- "1\r"; exp_continue }
    "Введите логин:" { send -- "mylogin\r"; exp_continue }
    "Введите пароль:" { send -- "mypassword\r"; exp_continue }
    "Введите номер (1, 2 или 3):" { send -- "1\r"; exp_continue }
    "Тип прокси (по умолчанию socks5):" { exp_continue }
    "1) Socks5" { send -- "1\r"; exp_continue }
    "Интервал ротации (в минутах, 0 для отключения, по умолчанию 0):" { send -- "0\r"; exp_continue }
    "Количество прокси:" { send -- "100\r"; exp_continue }
    "Режим работы:" { exp_continue }
    "1) Универсальные (ipv4/ipv6)" { send -- "1\r"; exp_continue }
}

# Завершение выполнения
expect eof
EOF

# Делаем expect скрипт исполняемым
chmod +x $TMP_DIR/run_expect.sh

# Запуск expect скрипта
$TMP_DIR/run_expect.sh

# Удаляем временные файлы (после выполнения скрипта)
rm -rf "$TMP_DIR"
