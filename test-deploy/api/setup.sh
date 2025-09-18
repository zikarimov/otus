#!/bin/bash

echo "🔍 Проверка Node.js..."
if ! command -v node &> /dev/null; then
    echo "❌ Node.js не установлен. Устанавливаем..."
    sudo apt update
    sudo apt install nodejs npm -y
fi

echo "📦 Версия Node.js: $(node --version)"
echo "📦 Версия npm: $(npm --version)"

echo "🔧 Установка зависимостей..."
npm install

echo "🚀 Запуск сервера..."
npm start
