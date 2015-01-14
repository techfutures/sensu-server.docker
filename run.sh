#!/bin/sh

if [ -z "$CLIENT_ADDRESS" ]; then
  echo "\$CLIENT_ADDRESS must be provided" 
  exit 1
fi

if [ -z "$RABBITMQ_PASS" ]; then
  echo "\$RABBITMQ_PASS must be provided" 
  exit 1
fi

if [ -z "$RABBITMQ_HOST" ]; then
  RABBITMQ_HOST="$CLIENT_ADDRESS"
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
    "vhost": "/sensu",
    "user": "sensu",
    "password": "$RABBITMQ_PASS"
  },
  {
    "api": {
      "host": "0.0.0.0",
      "port": 4567,
      "user": "$SENSU_USER",
      "password": "$SENSU_PASS"
    }
  }
}
EOF

echo "Running sensu config:"
cat /etc/sensu/config.json

exec /usr/bin/supervisord
