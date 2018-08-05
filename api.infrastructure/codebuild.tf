resource "aws_iam_role" "AfgriCloudBuildRole" {
  name = "example"

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

resource "aws_iam_role_policy" "AfgriCloudBuildPolicy" {
  role = "${aws_iam_role.AfgriCloudBuildRole.name}"

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
        "ecr:*"
      ]
    }
  ]
}
POLICY
}

resource "aws_codebuild_project" "AfgriApiCodeBuild" {
  name         = "AfgriApiCodeBuild"
  service_role = "${aws_iam_role.AfgriCloudBuildRole.arn}"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/dot-net:core-2.1"
    type            = "LINUX_CONTAINER"
    privileged_mode = "true"
  }

  source {
    type      = "GITHUB"
    location  = "https://github.com/tjaard123/play-microservices"
    buildspec = "api/buildspec.yml"
  }
}
