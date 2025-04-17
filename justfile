set dotenv-load

# --- Sync --- #
REMOTE := 'root@192.168.8.30'
REMOTE_DIR := '/root/homelab'
LOCAL := '/Users/aaron/Dev/homelab'

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

# stop a specific service
stop service:
    podman-compose stop {{service}}
