# Requirements:
  - ssl dir with cert.pem and key.pem
  - RABBIMTQ_HOST and REDIS_HOST env
  
```sh
  docker run \
    -v /ssl:/ssl \
    -v /log:/log \
    -v /conf.d:/conf.d \
    -e RABBITMQ_HOST=rabbitmq.local \
    -e RABBITMQ_HOST=redis.local \
    arypurnomoz/sensu-server
```
