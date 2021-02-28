resource "aws_iam_user" "user" {
  name = "Jenkins"
  path = "/system/"
}

resource "aws_iam_group" "jenkins" {
  name = "Jenkins"
}

data "aws_iam_policy_document" "jenkins" {
  statement {
    actions = [
      "s3:*",
      "cloudformation:*",
      "lambda:*",
      "iam:GetRole",
      "iam:CreateRole",
      "logs:CreateLogGroup",
      "iam:PutRolePolicy",
      "iam:PassRole",
      "iam:DeleteRolePolicy",
      "iam:DeleteRole",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "jenkins_policy" {
  name   = "Jenkins"
  policy = data.aws_iam_policy_document.jenkins.json
}

resource "aws_iam_group_policy_attachment" "jenkins-attach" {
  group      = aws_iam_group.jenkins.name
  policy_arn = aws_iam_policy.jenkins_policy.arn
}

resource "aws_iam_user_group_membership" "jenkins" {
  user = aws_iam_user.user.name

  groups = [
    aws_iam_group.jenkins.name,
  ]
}
