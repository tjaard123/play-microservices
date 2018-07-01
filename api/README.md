# Web (Angular + Nginx)

Use the albine (minimal) nginx linux docker and simply copy the nginx config and dist folder created by running `ng build`:

```docker
FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY dist/web /usr/share/nginx/html
```

Run it like this:

```
docker build -t play-web .
docker run -p 3000:80 --rm play-web
```

* Visit site on host via port 3000
* --rm is to automatically remove the container when it exits

To get a shell:
```
docker exec -it <container> sh
```

# AWS CodeBuild

AWS Codebuild executes a build on trigger using the buildspec.yml file. Publishing the artefacts to S3

```yml
version: 0.2
phases:
  install:
    commands:
      - cd web
      - npm install
  build:
    commands:
      - npm run build
artifacts:
  files:
      - web/dist/web/**/*
```
