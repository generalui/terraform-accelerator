module "documentdb-cluster" {
  source  = "cloudposse/documentdb-cluster/aws"
  version = "0.22.0"

  name      = var.name
  namespace = var.namespace
  stage     = var.stage

  allowed_security_groups = var.allowed_security_groups
  cluster_size            = var.cluster_size
  instance_class          = var.instance_class
  master_password         = var.master_password
  master_username         = var.master_username
  subnet_ids              = var.subnet_ids
  vpc_id                  = var.vpc_id
  zone_id                 = var.zone_id

  tags = var.tags
}
