resource "aws_security_group" "egress_only" {
  name        = "egress-only-${var.name}"
  description = "allow egress only. connect instance via session manager."
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "egress_only"
  }
}
resource "aws_iam_instance_profile" "main" {
  name = "instance-${var.name}"
  role = aws_iam_role.main.name
}
resource "aws_iam_role" "main" {
  name        = "instance-${var.name}"
  description = "EC2 role for SSM"

  # NOTE: SSMに必要な標準role
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Effect" : "Allow",
      }
    ]
  })
}
resource "aws_network_interface" "main" {
  subnet_id       = var.subnet_id
  description     = "managed by terraform"
  security_groups = [aws_security_group.egress_only.id]

  tags = {
    Name = var.name
  }
}

data "aws_ami" "default_ami" {
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210511"]
  }
  owners      = ["099720109477"]
  most_recent = true
}

resource "aws_instance" "main" {
  ami                  = var.ami == "" ? data.aws_ami.default_ami.id : var.ami
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.main.name
  ebs_optimized        = true

  network_interface {
    network_interface_id = aws_network_interface.main.id
    device_index         = 0
  }
  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    volume_size = 200
  }

  # NOTE: IMDSv2を有効にする。セキュリティベストプラクティスに基づく設定
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = var.name
  }
}

output "instance_id" {
  description = "created instance id"
  value       = aws_instance.main.id
}
