module "chatbot_slack_configuration" {
  source  = "waveaccounting/chatbot-slack-configuration/aws"
  version = "1.0.0"

  configuration_name = "${var.project_name}-awschatbot"
  iam_role_arn       = aws_iam_role.awschatbot_role.arn
  slack_channel_id   = var.slack_channel_id
  slack_workspace_id = var.slack_workspace_id

  sns_topic_arns = concat([aws_sns_topic.chatbot.arn], var.sns)
}

resource "aws_sns_topic" "chatbot" {
  name = "${var.project_name}-awschatbot"
}

resource "aws_iam_role" "awschatbot_role" {
  name               = "awschatbot-role-${var.project_name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "chatbot.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "awschatbot_role_policy" {
  name   = "awschatbot_policy"
  role   = aws_iam_role.awschatbot_role.name
  policy = data.aws_iam_policy_document.awschatbot_policy.json
}

data "aws_iam_policy_document" "awschatbot_policy" {
  statement {
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "lambda:InvokeFunction",
    ]
    resources = ["*"]
  }
}
