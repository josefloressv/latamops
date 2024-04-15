# Task Execution role
# The IAM role allows that grants the Amazon ECS container agent permission

resource "aws_iam_role" "exec" {
  name               = "${local.name_prefix}-exec"
  description        = "The task execution role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_trust.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "exec" {
  role       = aws_iam_role.exec.name
  policy_arn = aws_iam_policy.exec.arn
}

resource "aws_iam_policy" "exec" {
  name   = "${local.name_prefix}-exec-policy"
  policy = data.aws_iam_policy_document.exec.json
  tags   = var.tags
}

data "aws_iam_policy_document" "exec" {
  statement {
    sid    = "OnlyWildcardSupported"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }
  statement {
    sid     = "RetrieveSSMParameters"
    effect  = "Allow"
    actions = ["ssm:GetParameters"]
    resources = [
      "arn:aws:ssm:us-east-1:${var.aws_account_id}:parameter/${local.ssm_prefix_path}/*"
    ]
  }
  statement {
    sid    = "ECRPull"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecs:TagResource",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:ecr:us-east-1:${var.aws_account_id}:repository/${local.name_prefix}*",
    ]
  }
  statement {
    sid    = "CloudWatchLogs"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:us-east-1:${var.aws_account_id}:log-group:${local.name_prefix}*:*",
    ]
  }
}

# Trusted policy
data "aws_iam_policy_document" "ecs_task_execution_trust" {
  # Allow the ECS task to assume the role of the ECS service.
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
