set dotenv-load

# --- Sync --- #
REMOTE := 'root@bm-zero'
REMOTE_DIR := '/root/homelab'
LOCAL := "$HOME/Dev/homelab"

# pull from remote to local
pull:
    rsync -avz {{REMOTE}}:{{REMOTE_DIR}}/ {{LOCAL}}/

# push from local to remote
push:
    rsync -avz {{LOCAL}}/ {{REMOTE}}:{{REMOTE_DIR}}/

# --- Compose --- #
# view status of services
ps:
    podman-compose ps

# start all services in the background
up:
    podman-compose up -d

# stop and remove all services, containers, and networks
down:
    podman-compose down

# restart all services
restart:
    podman-compose restart

# show logs for a specific service
logs service:
    podman-compose logs -f {{service}}

# start a specific service
start service:
    podman-compose up -d {{service}}

# stop a specific service
stop service:
    podman-compose stop {{service}}

# --- Images --- #
GITHUB_USER := 'aatng-gh'
REPO := 'homelab'

ghcr_login:
    echo 'logging into GHCR...'
    podman login ghcr.io -u {{GITHUB_USER}} -p $GITHUB_TOKEN

CADDY_REGISTRY := 'ghcr.io/aatng-gh/{{REPO}}/caddy'

# build Caddy image with tag
caddy_build tag:
    echo 'building Caddy image...'
    podman build -t {{CADDY_REGISTRY}}:{{tag}} -f caddy/Containerfile .

# push Caddy image with tag
caddy_push tag:
    echo "pushing Caddy image to GHCR..."
    podman push {{CADDY_REGISTRY}}:{{tag}}

# build + push
caddy_publish tag:
    just caddy_build {{tag}}
    podman tag {{CADDY_REGISTRY}}:{{tag}} {{CADDY_REGISTRY}}:latest
    just caddy_push {{tag}}
    just caddy_push latest
