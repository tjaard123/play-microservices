# Web Infrastructure

TODO:
* Deploy to root S3 folder
* Make S3 bucket a public web host bucket

Step 1 - Update locals in `io.tf`:

```
locals {
  webHostBucket = "my-application-host-bucket"
  awsAccount = "111122223333"
  awsAssumeRole = "OrganizationAccountAccessRole"
  awsRegion = "eu-west-1"
  publicGitRepository = "https://github.com/tjaard123/play-microservices"
}
```

```
$ terraform apply
```

Creates:
* S3 bucket to host web site
* AWS CodeBuild project to pull from public repo and build and deploy to S3 bucket