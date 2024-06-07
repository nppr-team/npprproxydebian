#!/bin/bash

# Обновление и установка curl, если он не установлен
apt update && apt install -y curl

# URL вашего скрипта
SCRIPT_URL="http://94.103.85.26/npprproxyfull.sh"

# Скачиваем и сразу выполняем скрипт
curl -fsSL "$SCRIPT_URL" | bash
