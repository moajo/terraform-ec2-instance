## example

```tf

module "instance" {
  source        = "./ec2_instance"
  vpc_id        = aws_vpc.main.vpc_id
  subnet_id     = aws_vpc.main.private_subnet_ids[0]
  name          = "hogehoge"
  # ami           = "ami-xxxxxxxxxxx"
  instance_type = "g4dn.xlarge"
}

```

<!-- BEGIN_TF_DOCS -->

## Requirements

No requirements.

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                              | Type        |
| --------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_iam_instance_profile.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource    |
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                         | resource    |
| [aws_instance.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)                         | resource    |
| [aws_network_interface.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface)       | resource    |
| [aws_security_group.egress_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)      | resource    |
| [aws_ami.default_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)                         | data source |

## Inputs

| Name                                                                     | Description   | Type     | Default | Required |
| ------------------------------------------------------------------------ | ------------- | -------- | ------- | :------: |
| <a name="input_ami"></a> [ami](#input_ami)                               | ami           | `string` | `""`    |    no    |
| <a name="input_instance_type"></a> [instance_type](#input_instance_type) | instance_type | `string` | n/a     |   yes    |
| <a name="input_name"></a> [name](#input_name)                            | name          | `string` | n/a     |   yes    |
| <a name="input_subnet_id"></a> [subnet_id](#input_subnet_id)             | Subnet ID     | `string` | n/a     |   yes    |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id)                      | vpc_id        | `string` | n/a     |   yes    |

## Outputs

| Name                                                                 | Description         |
| -------------------------------------------------------------------- | ------------------- |
| <a name="output_instance_id"></a> [instance_id](#output_instance_id) | created instance id |

<!-- END_TF_DOCS -->
