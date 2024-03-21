resource "aws_iam_role" "newrelic" {
  name = var.aws_nerelic_role_name

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${var.newrelic_aws_account_id}:root"
            },
            "Action": "sts:AssumeRole",
            "Condition": {
                "StringEquals": {
                    "sts:ExternalId": "${var.newrelic_external_id}"
                }
            }
        }
    ]
}
EOF

  tags = var.base_tags
}

resource "aws_iam_role_policy_attachment" "newrelic-policy-attachment" {
  role       = aws_iam_role.newrelic.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}