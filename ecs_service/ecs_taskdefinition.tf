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

  proxy_configuration {
    type           = "APPMESH"
    container_name = "envoy"
    properties = {
      AppPorts           = var.container_port
      EgressIgnoredIPs   = "169.254.170.2,169.254.169.254"
      EgressIgnoredPorts = "22"
      IgnoredUID         = "1337"
      ProxyEgressPort    = 15001
      ProxyIngressPort   = 15000
    }
  }

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
          command = var.command == null ? [] : var.command
          dependsOn : [
            {
              "containerName" : "envoy",
              "condition" : "HEALTHY"
            },
            {
              "containerName" : "aws-otel-collector",
              "condition" : "START"
            }
          ]

          secrets     = var.env_secret
          environment = var.env
          portMappings = [
            {
              containerPort = var.container_port
            }
          ]
        },
        {
          name : "envoy",
          image : "840364872350.dkr.ecr.eu-west-1.amazonaws.com/aws-appmesh-envoy:v1.26.4.0-prod",
          essential : true,
          environment : [
            {
              name : "APPMESH_VIRTUAL_NODE_NAME",
              value : "mesh/${var.environment}-${var.project_name}/virtualNode/${var.environment}-${var.project_name}-${var.service}"
            },
            {
              name : "ENABLE_ENVOY_XRAY_TRACING",
              value : "1"
            },
          ],
          logConfiguration = {
            logDriver     = "awslogs"
            secretOptions = null
            options = {
              awslogs-group         = "/ecs/${var.environment}-${var.service}-app-mesh"
              awslogs-region        = var.region
              awslogs-stream-prefix = "ecs"
            }
          }
          healthCheck : {
            command : [
              "CMD-SHELL",
              "curl -s http://localhost:9901/server_info | grep state | grep -q LIVE"
            ],
            startPeriod : 10,
            interval : 5,
            timeout : 2,
            retries : 3
          },
          user : "1337"
        },
        {
          image : "amazon/aws-otel-collector",
          name : "aws-otel-collector"
          logConfiguration : {
            logDriver : "awslogs",
            options : {
              awslogs-group : "/ecs/${var.environment}-${var.service}-otel"
              awslogs-region : var.region,
              awslogs-stream-prefix : "ecs",
            }
          },
          healthCheck : {
            command : ["/healthcheck"],
            interval : 5,
            timeout : 6,
            retries : 5,
            startPeriod : 1
          },
          portMappings : [
            {
              hostPort : 2000,
              protocol : "udp",
              containerPort : 2000
            },
            {
              hostPort : 4317,
              protocol : "tcp",
              containerPort : 4317
            },
            {
              hostPort : 8125,
              protocol : "udp",
              containerPort : 8125
            }
          ],
          command : [
            "--config=/etc/ecs/ecs-default-config.yaml"
          ],
        },
      ],
      var.sidercar_container
    ),
  )

  # runtime_platform {
  #   operating_system_family = "LINUX"
  #   cpu_architecture        = "ARM64"
  # }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.environment}-${var.project_name}-${var.service}-ecsTaskExecutionRole"

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
  name        = "${var.environment}-${var.project_name}-${var.service}-ssm"
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
