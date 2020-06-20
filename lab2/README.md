**Лабораторная работа 2. Bash-скрипты. Git**

Необходимо написать bash-скрипт, загружающий проект с репозитория GitHub с последующей его сборкой и расположением файлов в системные папки. Задание 9 (если считать от единицы): https://github.com/ros/ros / http://wiki.ros.org/

Скрипт представлен в файле install_ros.sh
Возможна установка как с использованием пакетного менеджера в Ubuntu, либо сборка из исходных файлов. Рассмотрим процесс подробнее ниже.

Создаем ключ SSH для подключения к репозиторию на GitHub и присваиваем его текущему пользователю
```bash
# создаем новый ключ
yes ~/.ssh/id_rsa | ssh-keygen -q -t rsa -b 4096 -C "874803539@qq.com" -N '' > /dev/null
# добавляем ключи к пользователю
ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
# выводим публичный ключ
cat ~/.ssh/id_rsa.pub
```

Теперь необходимо перейти **в аккаунт на Github (можно создать новый аккаунт или использовать существующий)** и добавить выведенный в терминал публичный SSH-ключ в настройки аккаунта (Settings -> SSH and GPG keys), указав также необходимый заголовок.
Проверить возможность доступа можно командой:

![Добавление SSH-ключа в настройках GitHub](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Add%20SSH%20key%20-%20GitHub%20Settings.png)

```bash
# проверяем подключение к GitHub
ssh -vT git@github.com
```

![Проверка доступа к аккаунту GitHub по SSH](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2012-59-14.png)

В соответствии с этим, при необходимости работы от root-пользователя, ему также потребуется добавить созданный SSH-ключ для доступа к аккаунту GitHub. 
Теперь создадим в Ubuntu папку и подключим удаленный репозиторий, который был заранее создан на GitHub и куда будут добавлены результаты работы. Репозиторий будет клонирован с аккаунта GitHub. Затем в него будут добавлены файлы по лабораторным при помощи `git commit` и `git push`.

![Добавление репозитория GitHub](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2013-01-19.png)

Можно выполнить ряд команд для обновления и вывода информации о дистрибутиве и пакетах.

```bash
# обновим дистрибутив, зависимости и пакеты
sudo apt-get -y update && apt-get -y dist-upgrade
# выведем информацию о системе и версиях ПО
cat /etc/os-release
arch
# смотрим информацию о версиях ПО
python -V
pip -V
git --version
```

![вывод информации](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2004-46-41.png)

-------

## Установка через пакетный менеджер apt

Добавим репозиторий с нужными нам пакетами ros

```bash
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
```

Добавим ключ для доступа

```bash
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
```

Обновим зависимости

```bash
sudo apt-get update
```

**Установка ROS**
Ввиду того, что мы используем Ubuntu 18.4 bionic возможно установить пакет melodic:

```bash
# installs ROS package, build and communication libraries
sudo apt install ros-melodic-ros-base
# installs ROS Base, rqt, rviz and robot-generic libraries
sudo apt install ros-melodic-desktop
# installs everything of ROS Desktop option plus 2D/3D simulators and 2D/3D perception (if you want to simulate using Gazebo)
sudo apt install ros-melodic-desktop-full
```

![Установка ROS Melodic Base](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2004-26-37.png)

**Конфигурируем окружение**
ROS была установлена в `/opt/ros/<distro>` (в данном случае в `/opt/ros/melodic`). Для более удобного выполнения команд из терминала, необходимо добавить в оболочку путь к директории ROS:

```bash
source /opt/ros/melodic/setup.bash
```

Но, чтобы этого не пришлось делать каждый раз после перезапуска, добавим соответствующий ярлык в файл `/home/<user>/.bashrc` следующим образом: 

```bash
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
```

**Проверяем установку**
Сделаем команды ROS доступными выполнив source из .bashrc:

```bash
source ~/.bashrc
```

Запускаем roscore:

```bash
roscore
```

![Запуск roscore](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2012-55-16.png)

Откроем новый терминал и выполним команду:

```bash
rosnode list
```

В результате получим `/rosout` - теперь мы имеем установленный ROS. 

-------------

Для установки ROS из исходных файлов потребуется catkin, что представляет собой набор макросов cmake и кода на python для сборки компонентов ROS. 
Процесс установки подробно описан по ссылке:
http://wiki.ros.org/melodic/Installation/Source

Установим необходимые пакеты:

```bash
sudo apt-get install python-rosdep python-rosinstall-generator python-vcstool python-rosinstall build-essential
```

Инициализируем rosdep

```bash
sudo rosdep init
rosdep update
```

**Соберем пакеты ядра ROS (core ROS packages)**

Создадим рабочее постранство catkin workspace

```bash
mkdir ~/ros_catkin_ws
cd ~/ros_catkin_ws
```

Для получения и сборки ядра используем vcstool, что представляет собой утилиту для создания рабочего пространства с использованием различных систем контроля версий:

```bash
rosinstall_generator desktop --rosdistro melodic --deps --tar > melodic-desktop.rosinstall
mkdir src
sudo apt-get install python3-vcstool
vcs import src < melodic-desktop.rosinstall
```

Для получения всех зависимых пакетов используем:

```bash
rosdep install --from-paths src --ignore-src --rosdistro melodic -y
```

Данная команда просмотрит пакеты в директории src и рекурсивно установит все необходимые для них зависимости.

Теперь мы можем используя catkin провести сборку пакетов:

```bash
./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
```

Пакеты были установлены в директорию ~/ros_catkin_ws/install_isolated
Был создан файл `setup.bash`. 
 
Проверим установку запустив ROS:

```bash
roscore
```

------------------------------------------------------

**Обновление рабочей среды**

Для начала переместим текущие файлы в папку .old

```bash
mv -i melodic-desktop-full.rosinstall melodic-desktop-full.rosinstall.old
```

Получим обновленные пакеты

```bash
rosinstall_generator desktop_full --rosdistro melodic --deps --tar > melodic-desktop-full.rosinstall
```

Сравним с предыдущими:

```bash
diff -u melodic-desktop-full.rosinstall melodic-desktop-full.rosinstall.old
```

И если изменения будут нас устраивать, то обновим:

```bash
 vcs import src < melodic-desktop-full.rosinstall
```

Далее пересобираем рабочее окружение:

```bash
 ./src/catkin/bin/catkin_make_isolated --install
```

И снова добавляем source:

```bash
source ~/ros_catkin_ws/install_isolated/setup.bash
```

----------------

Стандартная установка программы в Ubuntu в большинстве случаев приводит к установке её в директорию /usr, но сама программа находится не в одной папке, а разделена на части:
/usr/bin - исполняемые файлы программ
/usr/sbin - исполняемые файлы программ, которые запускаются с правами администратора
/usr/lib - библиотеки программы
/usr/share - остальные файлы программы

Однако некоторые разработчики предпочитают установку в директорию /opt не разделяя файлы.

--------

В итоге по указанным выше командам собираем bash-скрипт и отправляем его в данный репозиторий, незабывая указать глобальные параметры для Git.
Создаем скрипт в редакторе Nano ввиду его небольших размеров
![Script in nano](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2013-03-07.png)
Добавим глобальные параметры для Git
![Глобальные параметры Git](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2013-05-17.png)
Смотрим логи после добавления репозитория
![Log Git](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2013-02-34.png)

Делаем коммит и пуш в удаленный репозиторий для добавления созданного скрипта
![Git push](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2013-06-17.png)
Смотрим логи
![Git Log2](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2013-06-30.png)
Создадим отдельную папку lab2 под созданный скрипт и перенесем его в данную папку, а затем выполним коммит и пуш для добавления изменений в удаленный репозиторий
![Git push2](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2013-12-18.png)
Смотрим итоговые логи
![Git Log3](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2013-12-29.png)

----------
## Проверяем работу скрипта
Удаляем ROS из нашего дистрибутива Ubuntu и пробуем его установить лишь с использованием ранее созданного скрипта

![Install ROS using Script](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2012-54-54.png)

![Install2 ROS using Script](https://raw.githubusercontent.com/Nelson789/4_labs_for_system/master/lab2/Screenshot%20from%202020-06-19%2012-55-07.png)
