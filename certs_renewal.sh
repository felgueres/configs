#!/bin/bash

docker compose -f dockercompose.yml down

sudo systemctl start nginx

sudo certbot --nginx -d streetcleaningparking.com -d pablofelgueres.com

sudo systemctl stop nginx
tmux new-session -d -s "server_session" "docker compose -f dockercompose.yml up --remove-orphans"
