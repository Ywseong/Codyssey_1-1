FROM nginx
LABEL org.opencontainers.image.title="My Nginx Web Server"
LABEL org.opencontainers.image.description="A simple Nginx web server."
LABEL org.opencontainers.image.authors="Wooseong Yeo"
COPY ./web /usr/share/nginx/html/
