#!/bin/sh

if [ -z "$RABBITMQ_HOST" ]; then
  echo "\$RABBITMQ_HOST must be provided" 
  exit 1
fi

cat << EOF > /etc/sensu/config.json
{
  "rabbitmq": {
    "ssl": {
      "cert_chain_file": "/ssl/cert.pem",
      "private_key_file": "/ssl/key.pem"
    },
    "host": "$RABBITMQ_HOST",
    "port": $RABBITMQ_PORT,
    "vhost": "$RABBITMQ_VHOST",
    "user": "$RABBITMQ_USER",
    "password": "$RABBITMQ_PASS"
  },
  "api": {
    "host": "0.0.0.0",
    "port": 4567,
    "user": "$API_USER",
    "password": "$API_PASS"
  }
}
EOF

echo "Running sensu config:"
cat /etc/sensu/config.json

exec /usr/bin/supervisord
