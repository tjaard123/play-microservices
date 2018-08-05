resource "aws_s3_bucket" "CodeBuildWebArtifactsBucket" {
  bucket = "${local.webHostBucket}"
  acl    = "private"
}

resource "aws_iam_role" "CodeBuildRole" {
  name = "CodeBuildRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "CodeBuildPolicy" {
  role = "${aws_iam_role.CodeBuildRole.name}"
  name = "CodeBuildPolicy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": "*",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "cloudtrail:LookupEvents",
        "ecr:*",
        "s3:ListAllMyBuckets",
        "s3:HeadBucket"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
          "${aws_s3_bucket.CodeBuildWebArtifactsBucket.arn}",
          "arn:aws:s3:::*/*"
      ],
      "Action": "s3:*"
    }
  ]
}
POLICY
}

resource "aws_codebuild_project" "WebCodeBuild" {
  name         = "WebCodeBuild"
  service_role = "${aws_iam_role.CodeBuildRole.arn}"

  artifacts {
    type = "S3"
    location = "${aws_s3_bucket.CodeBuildWebArtifactsBucket.bucket}"
    name = "/" # To deploy to root of bucket
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/nodejs:8.11.0" # https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
    type            = "LINUX_CONTAINER"
  }

  source {
    type      = "GITHUB"
    location  = "${local.publicGitRepository}"
    buildspec = "web/buildspec.yml"
  }
}
