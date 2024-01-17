resource "aws_ecs_task_definition" "main" {
  family             = "${var.environment}-${var.project_name}-${var.service}"
  network_mode       = "awsvpc"
  task_role_arn      = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  cpu                = var.cpu
  memory             = var.memory
  requires_compatibilities = [
    "FARGATE",
  ]

  container_definitions = jsonencode(
    concat(
      [
        {
          name      = "${var.environment}-${var.project_name}-${var.service}-container"
          image     = "${var.ecr_url}:latest"
          essential = true
          logConfiguration = {
            logDriver     = "awslogs"
            secretOptions = null
            options = {
              awslogs-group         = "/ecs/${var.environment}-${var.project_name}-${var.service}"
              awslogs-region        = var.region
              awslogs-stream-prefix = "ecs"
            }
          }
          command     = var.command == null ? [] : var.command
          secrets     = var.env_secret
          environment = var.env
          portMappings = [
            {
              containerPort = var.container_port
            }
          ]
        },
      ],
    ),
  )
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.environment}-${var.project_name}-${var.service}-ecsTask"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_policy" "policy-application" {
  name        = "${var.environment}-${var.project_name}-${var.service}"
  description = "SSM policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:PutLogEvents",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:DescribeLogStreams",
        "logs:DescribeLogGroups",
        "logs:PutRetentionPolicy",
        "xray:PutTraceSegments",
        "xray:PutTelemetryRecords",
        "xray:GetSamplingRules",
        "xray:GetSamplingTargets",
        "xray:GetSamplingStatisticSummaries",
        "cloudwatch:PutMetricData",
        "ec2:DescribeVolumes",
        "ec2:DescribeTags",
        "ssm:GetParameters",
        "appmesh:*",
        "lambda:*",
        "ssm:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "additional-ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.policy-application.arn
}
