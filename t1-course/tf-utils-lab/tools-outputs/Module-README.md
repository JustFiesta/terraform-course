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
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | ID AMI do użycia | `string` | n/a | yes |
| <a name="input_enable_monitoring"></a> [enable\_monitoring](#input\_enable\_monitoring) | Czy włączyć monitoring | `bool` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Nazwa instancji EC2 | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Typ instancji EC2 | `string` | `"t3.micro"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | ID subnetu | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | ID utworzonej instancji EC2 |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Publiczny adres IP instancji |