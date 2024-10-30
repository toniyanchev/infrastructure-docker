#!/bin/bash
cd "$(dirname "$0")"

source ../.env

# This overrides the root .env file
source .env

vol_dir=$VOLUMES_DIR/ton4o-rabbitmq-data/$RABBITMQ_HOST
echo "using volumes dir: $vol_dir"
ls -d $vol_dir >/dev/null || mkdir -p $vol_dir

docker run -d \
    --name ton4o-rabbitmq \
    -h $RABBITMQ_HOST \
    -p 5672:5672 \
    -p 15672:15672 \
    -v $vol_dir:/var/lib/rabbitmq/mnesia/rabbit@$RABBITMQ_HOST \
    -e RABBITMQ_DEFAULT_USER=$USER \
    -e RABBITMQ_DEFAULT_PASS=$PASS \
    rabbitmq:4.0-management
