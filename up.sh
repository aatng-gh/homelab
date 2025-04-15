podman network create --driver=bridge --disable-dns coredns
podman-compose up -d

podman build -t caddy:2.9.1 caddy/
