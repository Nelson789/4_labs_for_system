# Лабораторная работа 7. Лабиринт в ROS

Необходимо нарисовать первые 3 буквы имени и 3 буквы фамилии, соединив их контуры в форме лабиринта. 
Этот рисунок далее использовать для создания карта лабиринта в stageros и пустить в нем робота, который будет двигаться вдоль стены.
Рекомендуется использовать .world файл для создания карты по сделанному изображению.
Выбор цветов произволен. Форма и конструкция робота определяются произвольно и в соответствии с выбранным подходом к решению задачи.
Также понадобится catkin, предназначенный для создания произвольных пакетоа. Это пригодится при задании поведения робота.

Информация в помощь: 

http://wiki.ros.org/stage/Tutorials/SimulatingOneRobot 

https://u.cs.biu.ac.il/~yehoshr1/89-685/ 

https://player-stage-manual.readthedocs.io/en/stable/WORLDFILES/

## Запуск программы

Перед запуском необходимо установить требуемые пакеты в соответствии с представленными выше туториалами, и в stage_ros/world добавить файлы haonan.pgm и haonan.world
Затем нужно выполнить roscore и во втором терминале:
```
rosrun stage_ros stageros $(rospack find stage_ros)/world/haonan.world
cd <base_dir>/lab7
python robot_move.py
```


## Демонстрация работы скрипта

Нажмите на Gif ниже, чтобы открыть видео в плеере

[![Video Demo](https://github.com/Nelson789/4_labs_for_system/blob/master/lab7/lab7.gif?raw=true)](https://yadi.sk/i/bA82osoXmuapfQ)

## Результаты работы

![01](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab7/Screenshot%20from%202020-06-22%2003-48-39.png)

![02](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab7/Screenshot%20from%202020-06-22%2003-49-47.png)

![03](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab7/Screenshot%20from%202020-06-22%2004-01-26.png)

![04](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab7/Screenshot%20from%202020-06-22%2005-27-24.png)

![05](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab7/Screenshot%20from%202020-06-22%2005-28-01.png)

![06](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab7/Screenshot%20from%202020-06-22%2005-33-57.png)

![07](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab7/Screenshot%20from%202020-06-22%2005-34-33.png)
