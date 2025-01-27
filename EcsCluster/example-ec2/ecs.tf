module "ecs_cluster" {
  depends_on = [module.ecr]
  source     = "../"

  context = module.this.context

  container_environment = [{
    name  = "TEST"
    value = "value"
  }]

  container_log_configuration = {
    logDriver = "awslogs"
    options = {
      "awslogs-create-group" : "true",
      "awslogs-group" : "${local.log_group_name}",
      "awslogs-region" : "${var.aws_region}",
      "awslogs-stream-prefix" : "${module.this.name}"
    }
  }

  container_port_mappings = [{
    appProtocol   = "http"
    containerPort = local.container_port
    hostPort      = local.container_port
    name          = "http-${local.image_tag_name}"
  }]

  cluster_setting = {
    name  = "containerInsights"
    value = "enabled"
  }

  alb_security_group                         = module.alb.security_group_id
  autoscaling_force_delete                   = true
  autoscaling_managed_draining               = "DISABLED"
  autoscaling_managed_termination_protection = "DISABLED"
  container_cpu                              = 256
  container_image                            = "${module.ecr.url}:${local.image_tag_name}"
  container_memory                           = 512
  container_name                             = module.this.id
  container_port                             = local.container_port
  desired_count                              = local.desired_count
  ec2_instance_type                          = "t3.small"
  ecs_load_balancers = [{
    container_name   = module.this.id
    container_port   = local.container_port
    target_group_arn = module.alb.default_target_group_arn
  }]
  ignore_changes_task_definition = false
  launch_type                    = "EC2"
  log_group_name                 = local.log_group_name
  network_mode                   = null
  propagate_tags                 = "SERVICE"
  security_group_ids             = [module.vpc.default_security_group_id, module.alb.security_group_id]
  subnet_ids                     = concat(module.subnet.private_subnet_ids, module.subnet.public_subnet_ids)
  task_cpu                       = 512
  task_memory                    = 1024
  use_alb_security_group         = true
  vpc_id                         = module.vpc.id

  # Need to pass the Project and Environment tags to the ECS Cluster as the Autoscaling group will not have these tags applied automatically
  tags = merge(module.this.tags, {
    Project     = var.project
    Environment = var.environment_name
    Name        = "${module.this.id}"
  })
}

resource "aws_vpc_security_group_ingress_rule" "example" {
  depends_on        = [module.vpc, module.vpc.default_security_group_id]
  description       = "Allow inbound http traffic"
  security_group_id = module.vpc.default_security_group_id
  cidr_ipv4         = module.vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = local.container_port

  tags = merge(module.this.tags, { Name = "${module.this.id}" })
}
