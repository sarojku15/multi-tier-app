FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY . /usr/share/nginx/html
EXPOSE 80
EOT

# Create a minimal nginx.conf
cat <<EOT > frontend/nginx.conf
server {
    listen 80;
    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}