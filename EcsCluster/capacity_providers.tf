# Creates Capacity Provider linked with ASG and ECS Cluster

resource "aws_ecs_capacity_provider" "ecs_ec2" {
  count = module.this.enabled && local.is_ec2_launch_type ? 1 : 0
  name  = module.this.id

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.ecs_autoscaling_group[0].arn
    managed_draining               = var.autoscaling_managed_draining
    managed_termination_protection = var.autoscaling_managed_termination_protection

    managed_scaling {
      instance_warmup_period    = var.managed_scaling_instance_warmup_period
      maximum_scaling_step_size = var.managed_scaling_maximum_scaling_step_size
      minimum_scaling_step_size = var.managed_scaling_minimum_scaling_step_size
      status                    = "ENABLED"
      target_capacity           = var.managed_scaling_target_max_capacity
    }
  }
  tags = merge(module.this.tags, { Name = "${module.this.id}" })
}

resource "aws_ecs_cluster_capacity_providers" "ecs_ec2" {
  count              = module.this.enabled && local.is_ec2_launch_type ? 1 : 0
  cluster_name       = aws_ecs_cluster.default[0].name
  capacity_providers = [aws_ecs_capacity_provider.ecs_ec2[0].name]
}
