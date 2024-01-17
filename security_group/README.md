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
| [aws_security_group.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"null"` | no |
| <a name="input_security_groups_ingress_role"></a> [security\_groups\_ingress\_role](#input\_security\_groups\_ingress\_role) | n/a | <pre>map(object({<br>    protocal   = string<br>    from_port  = number<br>    to_port    = number<br>    cidr_block = list(string)<br>  }))</pre> | <pre>{<br>  "HTTP": {<br>    "cidr_block": [<br>      "0.0.0.0/0"<br>    ],<br>    "from_port": 80,<br>    "protocal": "tcp",<br>    "to_port": 80<br>  },<br>  "HTTPS": {<br>    "cidr_block": [<br>      "0.0.0.0/0"<br>    ],<br>    "from_port": 443,<br>    "protocal": "tcp",<br>    "to_port": 443<br>  }<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `"null"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_securiyt_group_id"></a> [securiyt\_group\_id](#output\_securiyt\_group\_id) | n/a |
