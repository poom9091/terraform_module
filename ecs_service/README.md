## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb_target_group_blue"></a> [alb\_target\_group\_blue](#module\_alb\_target\_group\_blue) | ../alb_target_group | n/a |
| <a name="module_alb_target_group_green"></a> [alb\_target\_group\_green](#module\_alb\_target\_group\_green) | ../alb_target_group | n/a |
| <a name="module_api_route"></a> [api\_route](#module\_api\_route) | ../api_gateway_route | n/a |
| <a name="module_listener_rule_main"></a> [listener\_rule\_main](#module\_listener\_rule\_main) | ../alb_listener_rule | n/a |
| <a name="module_listener_rule_test"></a> [listener\_rule\_test](#module\_listener\_rule\_test) | ../alb_listener_rule | n/a |
| <a name="module_service_security_group"></a> [service\_security\_group](#module\_service\_security\_group) | ../security_group | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.ecs_policy_cpu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.ecs_policy_memory](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.ecs_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.sidercar_container](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_cloudwatch_log_stream.sidercar_container](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_stream) | resource |
| [aws_ecs_service.api_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_service.load_balance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.policy-application](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.policy-lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecs_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.additional-ecs-task-execution-role-policy-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs-task-and-lambda-policy-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3-policy-attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_arn"></a> [acm\_arn](#input\_acm\_arn) | n/a | `string` | `null` | no |
| <a name="input_alb_arn"></a> [alb\_arn](#input\_alb\_arn) | n/a | `string` | `null` | no |
| <a name="input_alb_security_groups"></a> [alb\_security\_groups](#input\_alb\_security\_groups) | n/a | `string` | `null` | no |
| <a name="input_api_gateway_id"></a> [api\_gateway\_id](#input\_api\_gateway\_id) | n/a | `string` | `null` | no |
| <a name="input_aws_alb_target_group_arn"></a> [aws\_alb\_target\_group\_arn](#input\_aws\_alb\_target\_group\_arn) | n/a | `string` | `null` | no |
| <a name="input_cloudmap_arn"></a> [cloudmap\_arn](#input\_cloudmap\_arn) | n/a | `string` | `null` | no |
| <a name="input_cloudmap_id"></a> [cloudmap\_id](#input\_cloudmap\_id) | n/a | `string` | `null` | no |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | n/a | `string` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | `null` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | n/a | `string` | `null` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | n/a | `string` | `null` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | n/a | `number` | `null` | no |
| <a name="input_container_tag"></a> [container\_tag](#input\_container\_tag) | n/a | `any` | `null` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | n/a | `number` | `256` | no |
| <a name="input_dependsOn_sidercar_container"></a> [dependsOn\_sidercar\_container](#input\_dependsOn\_sidercar\_container) | n/a | `list(any)` | `null` | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | n/a | `number` | `200` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | n/a | `number` | `100` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | n/a | `number` | `1` | no |
| <a name="input_ecr_url"></a> [ecr\_url](#input\_ecr\_url) | n/a | `string` | `null` | no |
| <a name="input_ecs_service_security_groups"></a> [ecs\_service\_security\_groups](#input\_ecs\_service\_security\_groups) | n/a | `string` | `null` | no |
| <a name="input_enable_service"></a> [enable\_service](#input\_enable\_service) | n/a | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `list(any)` | `null` | no |
| <a name="input_env_secret"></a> [env\_secret](#input\_env\_secret) | n/a | `list(any)` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | `null` | no |
| <a name="input_expost"></a> [expost](#input\_expost) | n/a | `string` | `null` | no |
| <a name="input_health_check_path"></a> [health\_check\_path](#input\_health\_check\_path) | n/a | `string` | `null` | no |
| <a name="input_isBlueGreen"></a> [isBlueGreen](#input\_isBlueGreen) | n/a | `bool` | `false` | no |
| <a name="input_listener_arn_main"></a> [listener\_arn\_main](#input\_listener\_arn\_main) | n/a | `string` | `null` | no |
| <a name="input_listener_arn_test"></a> [listener\_arn\_test](#input\_listener\_arn\_test) | n/a | `string` | `null` | no |
| <a name="input_logs_retention_in_days"></a> [logs\_retention\_in\_days](#input\_logs\_retention\_in\_days) | n/a | `string` | `null` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | n/a | `number` | `512` | no |
| <a name="input_prefix_path"></a> [prefix\_path](#input\_prefix\_path) | n/a | `list(string)` | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_rule_priority"></a> [rule\_priority](#input\_rule\_priority) | n/a | `string` | `null` | no |
| <a name="input_security_group_api_gateway"></a> [security\_group\_api\_gateway](#input\_security\_group\_api\_gateway) | n/a | <pre>map(object({<br>    protocal   = string<br>    from_port  = number<br>    to_port    = number<br>    cidr_block = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_security_group_ecs_task"></a> [security\_group\_ecs\_task](#input\_security\_group\_ecs\_task) | n/a | <pre>map(object({<br>    protocal   = string<br>    from_port  = number<br>    to_port    = number<br>    cidr_block = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_service"></a> [service](#input\_service) | n/a | `string` | `null` | no |
| <a name="input_service_domain_name"></a> [service\_domain\_name](#input\_service\_domain\_name) | n/a | `string` | `null` | no |
| <a name="input_sidercar_container"></a> [sidercar\_container](#input\_sidercar\_container) | n/a | `list(any)` | `[]` | no |
| <a name="input_ssl_arn"></a> [ssl\_arn](#input\_ssl\_arn) | n/a | `string` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | `list(string)` | <pre>[<br>  "",<br>  ""<br>]</pre> | no |
| <a name="input_subnets_public"></a> [subnets\_public](#input\_subnets\_public) | n/a | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_use_arm64"></a> [use\_arm64](#input\_use\_arm64) | n/a | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `null` | no |
| <a name="input_vpc_link"></a> [vpc\_link](#input\_vpc\_link) | n/a | `string` | `null` | no |
| <a name="input_wait_for_steady_state"></a> [wait\_for\_steady\_state](#input\_wait\_for\_steady\_state) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_target_group_blue_arn"></a> [alb\_target\_group\_blue\_arn](#output\_alb\_target\_group\_blue\_arn) | n/a |
| <a name="output_alb_target_group_blue_name"></a> [alb\_target\_group\_blue\_name](#output\_alb\_target\_group\_blue\_name) | n/a |
| <a name="output_alb_target_group_green_arn"></a> [alb\_target\_group\_green\_arn](#output\_alb\_target\_group\_green\_arn) | n/a |
| <a name="output_alb_target_group_green_name"></a> [alb\_target\_group\_green\_name](#output\_alb\_target\_group\_green\_name) | n/a |
| <a name="output_api_gateway_integration_id"></a> [api\_gateway\_integration\_id](#output\_api\_gateway\_integration\_id) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_ecs_container_name"></a> [ecs\_container\_name](#output\_ecs\_container\_name) | n/a |
| <a name="output_security_group_ecs_task"></a> [security\_group\_ecs\_task](#output\_security\_group\_ecs\_task) | n/a |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | n/a |
