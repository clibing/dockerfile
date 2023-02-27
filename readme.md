### buildx

use buildx build platform `linux/amd64`, `linux/arm64/v8`, `linux/arm/v7`, `linux/arm/v6`.

### open buildx

```shell
vi ~/.docker/config.json

{ 
    "debug":"true",
    "experimental" : "enabled"
}

or

export DOCKER_CLI_EXPERIMENTAL=enabled
```

`auto-push is currently not implemented for docker driver` exec
```shell
docker buildx create --use
```

### demo

build alpine

```shell
docker buildx build --platform=linux/amd64,linux/arm64/v8,linux/arm/v7,linux/arm/v6 --build-arg ALPINE_VERSION=3.12 -t clibing/alpine:3.12 --push -f alpine/Dockerfile .
```

### other

...

### build step

* alpine

https://github.com/docker/build-push-action 查看 with的参数