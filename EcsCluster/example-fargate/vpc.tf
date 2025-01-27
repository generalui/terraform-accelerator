module "vpc" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//VPC?ref=1.0.1-VPC"

  context = module.this.context

  assign_generated_ipv6_cidr_block = false
}
