resource "aws_iam_role" "nragent" {
  name = var.aws_nragent_role_name

  assume_role_policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "Service": "ecs-tasks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

  tags = var.base_tags
}
resource "aws_iam_policy" "secret" {
  name        = "${var.aws_nragent_role_name}-secret-manager-policy"
  description = "Get secrets from the secret manager"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "secretsmanager:GetSecretValue",
            "Resource": "${data.aws_secretsmanager_secret.newrelic.arn}",
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "nragent-policy-attachment" {
  role       = aws_iam_role.nragent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "secret-policy-attachment" {
  role       = aws_iam_role.nragent.name
  policy_arn = aws_iam_policy.secret.arn
}

data "aws_secretsmanager_secret" "newrelic" {
  name = var.nr_license_secret_name
}