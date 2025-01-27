module "ecs_cluster" {
  source = "../"

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

  alb_security_group = module.alb.security_group_id
  container_image    = local.image_url
  container_name     = module.this.id
  container_port     = local.container_port
  desired_count      = local.desired_count
  ecs_load_balancers = [{
    container_name   = module.this.id
    container_port   = local.container_port
    target_group_arn = module.alb.default_target_group_arn
  }]
  ignore_changes_task_definition = false
  log_group_name                 = local.log_group_name
  propagate_tags                 = "SERVICE"
  security_group_ids             = [module.vpc.default_security_group_id, module.alb.security_group_id]
  subnet_ids                     = concat(module.subnet.private_subnet_ids, module.subnet.public_subnet_ids)
  use_alb_security_group         = true
  vpc_id                         = module.vpc.id
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
