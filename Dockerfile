# Используем базовый образ nginx версии 1.21.1
FROM nginx:1.21.1

# Копируем наш index.html в директорию с дефолтной страницей Nginx
COPY index.html /usr/share/nginx/html/index.html