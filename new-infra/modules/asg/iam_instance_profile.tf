resource "aws_iam_instance_profile" "lt" {
  name = "${local.name_prefix}-instance-profile"
  role = aws_iam_role.lt.name
  tags = var.tags
}
resource "aws_iam_role" "lt" {
  name        = "${local.name_prefix}-ec2-role"
  description = "The IAM role for the ECS/EC2 instances."

  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags               = var.tags
}

# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com",
        "ecs.amazonaws.com",
      ]
    }
  }
}
data "aws_iam_policy_document" "ec2" {

  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "ec2:CancelCapacityReservation",
      "ec2:CreateCapacityReservation",
      "ec2:CreateTags",
      "ec2:DescribeCapacityReservations",
      "ec2:DescribeTags",
      "ec2:GetCapacityReservationUsage",
      "ec2:ModifyCapacityReservation",
      "ec2:ModifyInstanceCapacityReservationAttributes",
    ]
  }

  # This is the policy which enables pulling Docker images from ECR.
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeRepositories",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:ListImages",
    ]
  }

  # This is the policy which enables the ECS cluster to self-manage.
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:SubmitAttachmentStateChanges",
      "ecs:SubmitContainerStateChange",
      "ecs:SubmitTaskStateChange",
    ]
  }

  # This is the policy which enables ECS (EC2) instances to send logs to CloudWatch Logs.
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
    ]
  }

  # This is the policy which enables SSM login.
  # https://docs.aws.amazon.com/systems-manager/latest/userguide/getting-started-add-permissions-to-existing-profile.html
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "kms:Decrypt",
      "s3:GetEncryptionConfiguration",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]
  }
}

# ------------------------------------------------------------------------------

resource "aws_iam_policy" "ec2" {
  name        = "${local.name_prefix}-ecs-ec2"
  description = "Enables logging and EC2 renaming."

  policy = data.aws_iam_policy_document.ec2.json
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "lt" {
  role       = aws_iam_role.lt.name
  policy_arn = aws_iam_policy.ec2.arn
}

# Attach AmazonSSMManagedInstanceCore policy to allow Session Manager
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.lt.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
