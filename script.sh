#!/bin/bash

# set -euo pipefail

# export VAL="hello"
# export CURRENT_DIR=$(pwd) # Выполнит команду и запишет ее значение в переменную
# 
# echo $VAL world
# if [[ $NAME =~ ^[A-Z] ]]; then # Можно использовать регулярки
# 	echo success
# fi

# Можно перенаправлять потоки

# Есть циклы
for i in $(seq 1 10); do
	echo $i
	sleep 1
done

trap cleanup SIGINT SIGTERM #Переопределили обработчик сигналов

# case $1 in
# 	start) echo "Starting...";;
# 	stop)  echo "Stopping...";;
# 	*) 	   echo "Unknown command"; exit 1;;
# esac
# 
cleanup() {
	echo "\nExiting..."
	exit 0
}
