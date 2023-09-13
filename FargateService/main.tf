module "ecs-fargate-service" {
  source  = "cn-terraform/ecs-fargate-service/aws"
  version = "2.0.41"

  additional_certificates_arn_for_https_listeners = var.additional_certificates_arn_for_https_listeners
  container_name                                  = var.container_name
  default_certificate_arn                         = var.default_certificate_arn
  ecs_cluster_arn                                 = var.ecs_cluster_arn
  lb_internal                                     = var.lb_internal
  name_prefix                                     = var.name_prefix
  private_subnets                                 = var.private_subnets
  public_subnets                                  = var.public_subnets
  ssl_policy                                      = var.ssl_policy
  task_definition_arn                             = var.task_definition_arn
  vpc_id                                          = var.vpc_id

  tags = var.tags
}
