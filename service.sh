#!/bin/bash

PID_FILE="/tmp/myservice.pid"

# Возвращает true, если процесс существует, и false, если нет
is_running() {
    if [ -f "$PID_FILE" ]; then
        local pid
        pid=$(cat "$PID_FILE")
        # Проверяем существование процесса
        if kill -0 "$pid" 2>/dev/null; then
            return 0
        fi
    fi
    return 1
}

start() {
    if is_running; then
        local pid
        pid=$(cat "$PID_FILE")
        echo "Уже запущен (PID $pid)"
    else
        # Запуск имитации сервиса в фоне
        sleep 3600 &
        local pid=$!
        echo "$pid" > "$PID_FILE"
        echo "Запущен (PID $pid)"
    fi
}

stop() {
    if [ ! -f "$PID_FILE" ]; then # Если файла нет
        echo "Сервис не запущен (PID-файл отсутствует)"
    else
        local pid
        pid=$(cat "$PID_FILE")
        
        if kill -0 "$pid" 2>/dev/null; then # Команда kill -0 проверяет, существует ли процесс
            kill "$pid"
            rm -f "$PID_FILE"
            echo "Остановлен (PID $pid)"
        else
            echo "Процесс PID $pid не найден, но PID-файл существовал. Удаляем устаревший файл."
            rm -f "$PID_FILE"
        fi
    fi
}

status() {
    if is_running; then
        local pid
        pid=$(cat "$PID_FILE")
        echo "Работает (PID $pid)"
    else
        echo "Не работает"
    fi
}

# Команда help
help() {
    echo "Использование: ./service.sh {start|stop|status|help}"
    echo "  start  - запустить сервис"
    echo "  stop   - остановить сервис"
    echo "  status - проверить статус сервиса"
    echo "  help   - показать эту справку"
}

# Логика выбора команд
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    help|"")
        help
        ;;
    *)
        echo "Ошибка: Неизвестная команда '$1'" >&2
        echo "Используйте ./service.sh help для вывода справки." >&2
        exit 1
        ;;
esac
