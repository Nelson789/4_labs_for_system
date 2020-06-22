# Лабораторная работа 6: ROS Turtlesim 

С помощью пакета Turtlesim нарисовать черепашкой табельный номер в ИСУ - 227906.

При разработке использованы инструкции по ссылкам:
http://wiki.ros.org/turtlesim/Tutorials/Moving%20in%20a%20Straight%20Line
http://wiki.ros.org/turtlesim/Tutorials/Rotating%20Left%20and%20Right

В соответствии с данными инструкциями был написан код Python в файлах rotate.py и move.py, которые были добавлены в ~/ros_catkin_ws/src/turtlesim_cleaner 

Затем был создан bash-скрипт print227906, который поочередно подает команды для отрисовки последовательно каждой цифры номера с определенной начальной точкой заданной как x0, y0. Скрипт должен быть запущен в отдельной вкладке терминала после запуска roscore и выполнения команды:

```
rosrun turtlesim turtlesim_node
```

## Запуск программы:
```
cd <base_dir>/lab6  # перейти в директорию с файлами работы
roscore # в первом терминале запускаем ros
rosrun turtlesim turtlesim_node # во втором терминале запускаем turtlesim
./print227906 # запускаем скрипт, чтобы начертить номер ИСУ
```

Результат представлен на изображении ниже

![Результат отрисовки](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab6/Screenshot%20from%202020-06-20%2009-02-35.png)
