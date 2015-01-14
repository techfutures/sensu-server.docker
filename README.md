Usage:
```sh
  docker run \
    # ssl dir should contain cert.pem and key.pem
    -v /ssl:/ssl \
    -v /conf.d:/conf.d \
    -v /log:/log \
    registy.skydns/sensu
```
