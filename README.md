# Microservices Playground

* S3 Hosted Angular Web
* .NET Core Docker API

# Docker Basics

```
$ docker run -it --rm alpine /bin/ash
```

* `-i` - Interactive mode (Keep STDIN open even if not attached)
* `-t` - Allocate a pseudo-TTY
* `alpine` - Docker image, pulled from registry or local
* `/bin/ash` - Entry point command
* `--rm` - Automatically remove the container when it exits

```
FROM alpine:latest
COPY . .
```

```
$ docker build -t my-alpine .
```