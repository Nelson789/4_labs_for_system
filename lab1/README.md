# Лабораторная работа 1. Bash-скрипты

Необходимо написать bash-скрипт, который собирает информацию о содержимом папки и создает таблицу с данными о содержащихся файлах. 
Папка может содержать файлы любого размера и формата, включая изображения, видео и аудио. 
Таблица должна содержать минимально:

* Название файла (может содержать пробелы и специальные символы);
* Расширение файла;
* Размер файла;
* Дату последнего изменения файла (в читаемом формате);
* Длительность (для аудио и видео).

Дополнительно также можно указать:
* Формат (для изображений);
* Права доступа;
* Типы данных файла.

Формат таблицы с данными должен быть формата .csv. Дополнительно можно преобразовать ее в формат таблицы Excel.
В рамках выполнения работы допускается создание дополнительных рабочих файлов с учетом, что они не исказят данные таблицы.
Проверка работоспособности кода может осуществляться на других файлах.

## Информация в помощь 
* https://help.ubuntu.com/ 
* https://techlog360.com/basic-ubuntu-commands-terminal-shortcuts-linux-beginner/ 
* https://www.guru99.com/excel-vs-csv.html

## Запуск скрипта
Для запуска можно использовать стандартную команду:
```bash
# перейти в директорию с файлами лабораторной работы
cd <lab1_dir>
# запустить скрипт
./files_info.sh
```

## Демонстрация работы скрипта

Нажмите на Gif ниже, чтобы открыть видео в плеере

[![Video Demo](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab1/lab1.gif)](https://yadi.sk/i/ITrcNE-gQyGUmg)

## Скриншоты

![01](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab1/Screenshot%20from%202020-06-23%2011-09-52.png)
![02](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab1/Screenshot%20from%202020-06-23%2011-10-18.png)
![03](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab1/Screenshot%20from%202020-06-23%2011-10-51.png)
![04](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab1/Screenshot%20from%202020-06-23%2011-10-58.png)
![05](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab1/Screenshot%20from%202020-06-23%2011-11-01.png)
