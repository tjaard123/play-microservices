# API (.NET Core & Docker)

Use the aspnetcore docker and simply copy the dist folder created by a dotnet publish:

```docker
FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY /dist .
ENTRYPOINT ["dotnet", "aspnetapp.dll"]
```

# AWS CodeBuild

AWS Codebuild executes a build using the buildspec.yml file. Publishing the built docker image to ECR:

```yml
version: 0.2

env:
  variables:
    REPOSITORY_URI: "<AWS-ACCOUNT>.dkr.ecr.eu-west-1.amazonaws.com/<IMAGE>"

phases:
  install:
    commands:
      - cd api
      - dotnet restore
  pre_build:
    commands:
      - $(aws ecr get-login --no-include-email --region eu-west-1)
  build:
    commands:
      - dotnet publish -c Release -o dist
      - docker build -t afgri .
      - docker tag afgri:latest $REPOSITORY_URI:latest
  post_build:
    commands:
      - docker push $REPOSITORY_URI:latest
```

Checklist:
* Setup a repository and provide env variable above
* .NET Core CodeBuild image
* CodeBuild role with full access to ECR
* Allow CodeBuild access to ECR with policy on ECR