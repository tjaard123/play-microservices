locals {
  webHostBucket = "my-application-host-bucket"
  awsAccount = "111122223333"
  awsAssumeRole = "OrganizationAccountAccessRole"
  awsRegion = "eu-west-1"
  publicGitRepository = "https://github.com/tjaard123/play-microservices"
}

provider "aws" {
  region = "${local.awsRegion}"

  assume_role {
    role_arn = "arn:aws:iam::${local.awsAccount}:role/${local.awsAssumeRole}"
  }
}
