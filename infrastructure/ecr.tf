resource "aws_ecr_repository" "AfgriApi" {
  name = "afgri"
}

resource "aws_ecr_repository_policy" "AfgriApiPolicy" {
  repository = "${aws_ecr_repository.AfgriApi.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "CodeBuildAccess",
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"  
      },
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability"
      ]
    }
  ]
}
EOF
}
