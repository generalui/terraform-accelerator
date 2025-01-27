module "vpc" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//VPC?ref=1.0.1-VPC"

  name    = "vpc"
  context = module.this.context

  assign_generated_ipv6_cidr_block = false
  internet_gateway_enabled         = true
}

module "subnet" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//Subnet?ref=1.0.1-Subnet"

  name    = "subnet"
  context = module.this.context

  # Building a VPC with a single subnet in a single AZ is a bit silly, but it's a good example.
  availability_zones = ["${var.aws_region}a"]
  igw_id             = [module.vpc.igw_id]
  ipv4_cidr_block    = ["10.0.0.0/24"]
  max_subnet_count   = 1
  vpc_id             = module.vpc.id
}

module "vpc_endpoint_security_group" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//SecurityGroup?ref=1.0.1-SecurityGroup"

  name        = "${module.this.name}-vpc-endpoint"
  description = "Security group for VPC endpoints"
  context     = module.this.context
  vpc_id      = module.vpc.id

  ingress_with_self = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "Container to VPC endpoint service"
      self        = true
    },
  ]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["https-443-tcp"]
}
