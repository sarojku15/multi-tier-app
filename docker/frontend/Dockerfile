FROM nginx:latest
COPY . /usr/share/nginx/html
EXPOSE 80

# Create a minimal nginx.conf
RUN cat <<EOT > /etc/nginx/conf.d/default.conf
server {
    listen 80;
    server_name localhost;
    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
EOT