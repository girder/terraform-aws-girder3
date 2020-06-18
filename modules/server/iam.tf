resource "aws_iam_role" "server" {
  name = var.project_slug
  assume_role_policy = data.aws_iam_policy_document.server_assumeRolePolicy.json
}

data "aws_iam_policy_document" "server_assumeRolePolicy" {
  statement {
    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com",
      ]
    }
    actions = [
      "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_instance_profile" "server" {
  name = var.project_slug
  role = aws_iam_role.server.name
}
