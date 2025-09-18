# =============================================================================
# AUTO LOAD .env FILES
# =============================================================================

# Функция для загрузки .env файла из текущей директории
load_env() {
    if [ -f .env ]; then
        echo "🔧 Loading .env file..."
        set -a  # автоматически экспортировать все переменные
        source .env
        set +a
        echo "✅ Environment variables loaded"
    fi
}

# Автоматически загружать .env при входе в директорию (опционально)
auto_load_env() {
    if [ -f .env ] && [ ! "$PWD" = "$OLDPWD" ]; then
        load_env
    fi
}

# Алиас для ручной загрузки
alias loadenv='load_env'
