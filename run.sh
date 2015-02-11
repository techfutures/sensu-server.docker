#!/bin/sh

if [ -z "$RABBITMQ_PORT_15672_TCP_ADDR" ]; then
  echo "\$RABBITMQ_PORT_15672_TCP_ADDR must be provided" 
  exit 1
fi

if [ -z "$REDIS_PORT_6379_TCP_ADDR" ]; then
  echo "\$REDIS_PORT_6379_TCP_ADDR must be provided" 
  exit 1
fi

cat << EOF > /etc/sensu/config.json
{
  "rabbitmq": {
    "ssl": {
      "cert_chain_file": "/ssl/cert.pem",
      "private_key_file": "/ssl/key.pem"
    },
    "host": "$RABBITMQ_PORT_15672_TCP_ADDR",
    "port": $RABBITMQ_PORT_15672_TCP_PORT,
    "vhost": "$RABBITMQ_VHOST",
    "user": "$RABBITMQ_USER",
    "password": "$RABBITMQ_PASS"
  },
  "redis": {
    "host": "$REDIS_PORT_6379_TCP_ADDR",
    "port": $REDIS_PORT_6379_TCP_PORT
  }
}
EOF

echo "Running sensu config:"
cat /etc/sensu/config.json

exec /opt/sensu/bin/sensu-server -vc /etc/sensu/config.json -d /conf.d
