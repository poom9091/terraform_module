## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb_listener_rule.host_based_weighted_routing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_listener_arn"></a> [listener\_arn](#input\_listener\_arn) | n/a | `any` | n/a | yes |
| <a name="input_rule_priority"></a> [rule\_priority](#input\_rule\_priority) | n/a | `any` | n/a | yes |
| <a name="input_service_domain_name"></a> [service\_domain\_name](#input\_service\_domain\_name) | n/a | `any` | n/a | yes |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
