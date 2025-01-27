resource "aws_autoscaling_group" "ecs_autoscaling_group" {
  count = module.this.enabled && local.is_ec2_launch_type ? 1 : 0

  name = module.this.id

  force_delete          = var.autoscaling_force_delete
  max_size              = var.autoscaling_max_size
  min_size              = var.autoscaling_min_size
  vpc_zone_identifier   = var.subnet_ids
  health_check_type     = "EC2"
  protect_from_scale_in = var.autoscaling_protect_from_scale_in

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  launch_template {
    id      = aws_launch_template.ecs_ec2[0].id
    version = aws_launch_template.ecs_ec2[0].latest_version
  }

  instance_refresh { strategy = "Rolling" }

  lifecycle { create_before_destroy = true }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = module.this.tags

    content {
      key                 = tag.key
      value               = tag.key == "Name" ? "${module.this.id}" : tag.value
      propagate_at_launch = true
    }
  }
}


## Define Target Tracking on ECS Cluster Task level
resource "aws_appautoscaling_target" "ecs_target" {
  count              = module.this.enabled && local.is_ec2_launch_type ? 1 : 0
  max_capacity       = var.appautoscaling_target_max_capacity
  min_capacity       = var.appautoscaling_target_min_capacity
  resource_id        = "service/${aws_ecs_cluster.default[0].name}/${module.ecs_alb_service_task[0].service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  tags               = merge(module.this.tags, { Name = "${module.this.id}" })
}


## Policy for CPU tracking
resource "aws_appautoscaling_policy" "ecs_cpu_policy" {
  count              = module.this.enabled && local.is_ec2_launch_type ? 1 : 0
  name               = "${module.this.id}-cpu"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 80

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}


## Policy for memory tracking
resource "aws_appautoscaling_policy" "ecs_memory_policy" {
  count              = module.this.enabled && local.is_ec2_launch_type ? 1 : 0
  name               = "${module.this.id}-memory"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target[0].resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target[0].scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target[0].service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 80

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}
