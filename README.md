Домашнее задание к занятию 4 «Оркестрация группой Docker контейнеров на примере Docker Compose»- Михалёв Сергей

## Задача 1

Сценарий выполнения задачи:
- Установите docker и docker compose plugin на свою linux рабочую станцию или ВМ.
- Если dockerhub недоступен создайте файл /etc/docker/daemon.json с содержимым: ```{"registry-mirrors": ["https://mirror.gcr.io", "https://daocloud.io", "https://c.163.com/", "https://registry.docker-cn.com"]}```
- Зарегистрируйтесь и создайте публичный репозиторий  с именем "custom-nginx" на https://hub.docker.com (ТОЛЬКО ЕСЛИ У ВАС ЕСТЬ ДОСТУП);
- скачайте образ nginx:1.21.1;
- Создайте Dockerfile и реализуйте в нем замену дефолтной индекс-страницы(/usr/share/nginx/html/index.html), на файл index.html с содержимым:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I will be DevOps Engineer!</h1>
</body>
</html>
```
- Соберите и отправьте созданный образ в свой dockerhub-репозитории c tag 1.0.0 (ТОЛЬКО ЕСЛИ ЕСТЬ ДОСТУП). 
- Предоставьте ответ в виде ссылки на https://hub.docker.com/<username_repo>/custom-nginx/general .
---
**Решение**

[Ссылка](https://hub.docker.com/repository/docker/sergemmikh/custom-nginx/general) на репозиторий.

-----

## Задача 2
1. Запустите ваш образ custom-nginx:1.0.0 командой docker run в соответвии с требованиями:
- имя контейнера "ФИО-custom-nginx-t2"
- контейнер работает в фоне
- контейнер опубликован на порту хост системы 127.0.0.1:8080
2. Переименуйте контейнер в "custom-nginx-t2"
3. Выполните команду ```date +"%d-%m-%Y %T.%N %Z" ; sleep 0.150 ; docker ps ; ss -tlpn | grep 127.0.0.1:8080  ; docker logs custom-nginx-t2 -n1 ; docker exec -it custom-nginx-t2 base64 /usr/share/nginx/html/index.html```
4. Убедитесь с помощью curl или веб браузера, что индекс-страница доступна.

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.
---

**Решение**
1. Для запуска контейнера с заданными характеристиками использовал команду ```docker run -d --name SMMikh-custom-nginx-t2 -p 127.0.0.1:8080:80 sergemmikh/custom-nginx:1.0.0```
   * <img src="images/Task_1_1.png" alt="Task_2_1.png" width="700" height="auto">
2. Переименовал контейнер: ```docker rename SMMikh-custom-nginx-t2 custom-nginx-t2```
   * <img src="images/Task_2_2.png" alt="Task_2_2.png" width="700" height="auto">
3. Вывод команды ```date +"%d-%m-%Y %T.%N %Z" ; sleep 0.150 ; docker ps ; ss -tlpn | grep 127.0.0.1:8080  ; docker logs custom-nginx-t2 -n1 ; docker exec -it custom-nginx-t2 base64 /usr/share/nginx/html/index.html```
   * <img src="images/Task_2_3.png" alt="Task_2_3.png" width="700" height="auto">
4. Проверка доступнсти страницы: ```curl http://127.0.0.1:8080```
   * <img src="images/Task_2_4.png" alt="Task_2_4.png" width="700" height="auto">
-----
## Задача 3
1. Воспользуйтесь docker help или google, чтобы узнать как подключиться к стандартному потоку ввода/вывода/ошибок контейнера "custom-nginx-t2".
2. Подключитесь к контейнеру и нажмите комбинацию Ctrl-C.
3. Выполните ```docker ps -a``` и объясните своими словами почему контейнер остановился.
4. Перезапустите контейнер
5. Зайдите в интерактивный терминал контейнера "custom-nginx-t2" с оболочкой bash.
6. Установите любимый текстовый редактор(vim, nano итд) с помощью apt-get.
7. Отредактируйте файл "/etc/nginx/conf.d/default.conf", заменив порт "listen 80" на "listen 81".
8. Запомните(!) и выполните команду ```nginx -s reload```, а затем внутри контейнера ```curl http://127.0.0.1:80 ; curl http://127.0.0.1:81```.
9. Выйдите из контейнера, набрав в консоли  ```exit``` или Ctrl-D.
10. Проверьте вывод команд: ```ss -tlpn | grep 127.0.0.1:8080``` , ```docker port custom-nginx-t2```, ```curl http://127.0.0.1:8080```. Кратко объясните суть возникшей проблемы.
11. * Это дополнительное, необязательное задание. Попробуйте самостоятельно исправить конфигурацию контейнера, используя доступные источники в интернете. Не изменяйте конфигурацию nginx и не удаляйте контейнер. Останавливать контейнер можно. [пример источника](https://www.baeldung.com/linux/assign-port-docker-container)
12. Удалите запущенный контейнер "custom-nginx-t2", не останавливая его.(воспользуйтесь --help или google)

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод.
---
**Решение**
1. Для подключения к стандартному потоку ввода-вывода требется выполнить команду ```docker attach```
При нажатии комбинации Ctrl-C контейнер остановится так как это отправляет сигнал прерывания (SIGINT) в основной процесс контейнера (в данном случае это процесс NGINX). Основной процесс контейнера завершает свою работу при получении сигнала SIGINT, что приводит к остановке контейнера.
   * <img src="images/Task_3_2.png" alt="Task_3_2.png" width="450" height="auto">
2. Перезапустил контейнер: ```docker start custom-nginx-t2```
3. Зашёл в оболочку bsh контейнера custom-nginx-t2: ```docker exec -it custom-nginx-t2 bash```. Но установить nano не удалось
   * <img src="images/Task_3_3.png" alt="Task_3_3.png" width="450" height="auto">
   Воспользовался услугами VSCode
   * <img src="images/Task_3_4.png" alt="Task_3_4.png" width="500" height="auto">
4. После перезапуска сервиса страница index.html стала доступна только по порту 81
   * <img src="images/Task_3_5.png" alt="Task_3_5.png" width="500" height="auto">
5. Порт 8080 custom-nginx-t2 так и остался открытым, но он связан с портом 80 внутри контейнера, а так как nginx перестал прослушивать порт 80, то ждать ответа по 8080 не приходится
   * <img src="images/Task_3_6.png" alt="Task_3_6.png" width="500" height="auto">
6. Для удаления контейнера без его остановки можно воспользовтаься флагом -f: ```docker rm -f custom-nginx-t2```
   * <img src="images/Task_3_7.png" alt="Task_3_7.png" width="500" height="auto">
-----

## Задача 4


- Запустите первый контейнер из образа ***centos*** c любым тегом в фоновом режиме, подключив папку  текущий рабочий каталог ```$(pwd)``` на хостовой машине в ```/data``` контейнера, используя ключ -v.
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив текущий рабочий каталог ```$(pwd)``` в ```/data``` контейнера. 
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```.
- Добавьте ещё один файл в текущий каталог ```$(pwd)``` на хостовой машине.
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.
---

**Решение**
1. Контейнер из образа ***centos*** c любым тегом в фоновом режиме, подключив папку  текущий рабочий каталог ```$(pwd)``` на хостовой машине в ```/data``` контейнера
   ```docker run -d --name centos-container -v "$(pwd):/data" centos:latest tail -f /dev/null```
   * <img src="images/Task_4_1.png" alt="Task_4_1.png" width="700" height="auto">
2. Контейнер из образа ***debian*** в фоновом режиме, подключив текущий рабочий каталог ```$(pwd)``` в ```/data``` контейнера
   ```docker run -d --name debian-container -v "$(pwd):/data" debian:latest tail -f /dev/null```
   * <img src="images/Task_4_2.png" alt="Task_4_2.png" width="700" height="auto">
3. Подключился к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```:
   ```docker exec -it centos-container bash -c "echo 'Hello from CentOS' > /data/centos-file.txt"```
4. Добавил файл в текущий каталог ```$(pwd)``` на хостовой машине ```echo 'Hello from Host' > $(pwd)/host-file.txt```
5. Листинг и содержание файлов в ```/data``` Второго контейнера.
   ```docker exec -it debian-container bash -c "ls -l /data && cat /data/centos-file.txt && cat /data/host-file.txt"```
   * <img src="images/Task_4_3.png" alt="Task_4_3.png" width="700" height="auto">

-----

## Задача 5

1. Создайте отдельную директорию(например /tmp/netology/docker/task5) и 2 файла внутри него.
"compose.yaml" с содержимым:
```
version: "3"
services:
  portainer:
    image: portainer/portainer-ce:latest
    network_mode: host
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```
"docker-compose.yaml" с содержимым:
```
version: "3"
services:
  registry:
    image: registry:2
    network_mode: host
    ports:
    - "5000:5000"
```

И выполните команду "docker compose up -d". Какой из файлов был запущен и почему? (подсказка: https://docs.docker.com/compose/compose-application-model/#the-compose-file )

2. Отредактируйте файл compose.yaml так, чтобы были запущенны оба файла. (подсказка: https://docs.docker.com/compose/compose-file/14-include/)

3. Выполните в консоли вашей хостовой ОС необходимые команды чтобы залить образ custom-nginx как custom-nginx:latest в запущенное вами, локальное registry. Дополнительная документация: https://distribution.github.io/distribution/about/deploying/
4. Откройте страницу "https://127.0.0.1:9000" и произведите начальную настройку portainer.(логин и пароль адмнистратора)
5. Откройте страницу "http://127.0.0.1:9000/#!/home", выберите ваше local  окружение. Перейдите на вкладку "stacks" и в "web editor" задеплойте следующий компоуз:

```
version: '3'

services:
  nginx:
    image: 127.0.0.1:5000/custom-nginx
    ports:
      - "9090:80"
```
6. Перейдите на страницу "http://127.0.0.1:9000/#!/2/docker/containers", выберите контейнер с nginx и нажмите на кнопку "inspect". В представлении <> Tree разверните поле "Config" и сделайте скриншот от поля "AppArmorProfile" до "Driver".

7. Удалите любой из манифестов компоуза(например compose.yaml).  Выполните команду "docker compose up -d". Прочитайте warning, объясните суть предупреждения и выполните предложенное действие. Погасите compose-проект ОДНОЙ(обязательно!!) командой.

В качестве ответа приложите скриншоты консоли, где видно все введенные команды и их вывод, файл compose.yaml , скриншот portainer c задеплоенным компоузом.

---
**Решение**
1. Docker Compose автоматически выбрал compose.yaml, хотя у вас также есть docker-compose.yaml, так как оба файла являются допустимыми конфигурационными файлами, но порядок их проверки зависит от внутренней логики Docker Compose, показанной в [статье](https://docs.docker.com/compose/compose-application-model/#the-compose-file). В этом случае он выбрал compose.yaml.
   * <img src="images/Task_5_1.png" alt="Task_5_1.png" width="700" height="auto">
2. Для включения docker-compose.yaml в проект я воспользовался опцией:
```include:  - docker-compose.yaml```
   * <img src="images/Task_5_2.png" alt="Task_5_2.png" width="700" height="auto">
3. В соответствии с рекомендациями задания задеплоил компоуз *compose-custom-nginx*
   * <img src="images/Task_5_3.png" alt="Task_5_3.png" width="400" height="auto">
4. Cкриншот от поля "AppArmorProfile" до "Driver" d "inspect" d представлении <> Tree
   * <img src="images/Task_5_4.png" alt="Task_5_4.png" width="400" height="auto">
5. Удалаять *compose.yaml* я не стал, достаточно было просто переименовать в *compose_.yaml* что бы получить искомое предупреждение
   ```WARN[0000] Found orphan containers ([task5-portainer-1]) for this project. If you removed or renamed this service in your compose file, you can run this command with the --remove-orphans flag to clean it up.```
   что можно в вольном переводе жвучит как "найдены сиротские контейнеры". 
   * <img src="images/Task_5_5.png" alt="Task_5_5.png" width="700" height="auto">
6. Выполнил предложенный запуск с флагом *--remove-orphans*. В результате оталось единственное предупреждение, касабщееся отсуттсвия необходимости использования версии компоуза в его текущей реализации.
   * <img src="images/Task_5_6.png" alt="Task_5_6.png" width="700" height="auto">
7. Команды ```docker compose down``` достаточно что бы погасить запущенный компоуз.
   * <img src="images/Task_5_7.png" alt="Task_5_7.png" width="700" height="auto">
   
   
