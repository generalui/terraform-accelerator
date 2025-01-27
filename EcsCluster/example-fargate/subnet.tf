module "subnet" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//Subnet?ref=1.0.1-Subnet"

  context = module.this.context

  # For the ALB, at least two subnets in two different Availability Zones must be specified.
  availability_zones = ["${var.aws_region}a", "${var.aws_region}b"]
  igw_id             = [module.vpc.igw_id]
  ipv4_cidr_block    = [module.vpc.cidr_block]
  max_subnet_count   = 2
  vpc_id             = module.vpc.id
}
