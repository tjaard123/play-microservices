# Web (Angular + S3)

Simply host on S3. AWS Codebuild executes a build on trigger using the buildspec.yml file. Publishing the artefacts to S3 from where you can deploy it to the hosting bucket.

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
