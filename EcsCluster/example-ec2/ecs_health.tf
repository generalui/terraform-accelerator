# Cloudwatch Alarm for Frontend API ECS Cluster

resource "aws_cloudwatch_metric_alarm" "ecs_alert_high_cpu_reservation" {
  alarm_name          = "${module.this.id}-high-cpu-resv"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  period              = "60"
  evaluation_periods  = "1"
  datapoints_to_alarm = 1

  statistic         = "Average"
  threshold         = "80"
  alarm_description = ""

  metric_name = "CPUReservation"
  namespace   = "AWS/ECS"
  dimensions  = { ClusterName = module.ecs_cluster.cluster_name }

  actions_enabled           = true
  insufficient_data_actions = []
  ok_actions                = []
  alarm_actions             = [aws_sns_topic.ecs_healthcheck.arn]
  treat_missing_data        = "notBreaching"

  tags = merge(module.this.tags, { Name = "${module.this.id}-high-cpu-resv" })
}

resource "aws_cloudwatch_metric_alarm" "ecs_alert_high_mem_reservation" {
  alarm_name          = "${module.this.id}-high-mem-resv"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  period              = "60"
  evaluation_periods  = "1"
  datapoints_to_alarm = 1

  statistic         = "Average"
  threshold         = "80"
  alarm_description = ""

  metric_name = "MemoryReservation"
  namespace   = "AWS/ECS"
  dimensions  = { ClusterName = module.ecs_cluster.cluster_name }

  actions_enabled           = true
  insufficient_data_actions = []
  ok_actions                = []
  alarm_actions             = [aws_sns_topic.ecs_healthcheck.arn]
  treat_missing_data        = "notBreaching"

  tags = merge(module.this.tags, { Name = "${module.this.id}-high-mem-resv" })
}

# Cloudwatch Alarm for ASG (of Frontend API ECS Cluster)

resource "aws_cloudwatch_metric_alarm" "ecs_asg_alert_has_system_check_failure" {
  alarm_name          = "${module.this.id}-has-sys-check-failure"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  period              = "60"
  evaluation_periods  = "1"
  datapoints_to_alarm = 1

  statistic         = "Sum"
  threshold         = "1"
  alarm_description = ""

  metric_name = "StatusCheckFailed"
  namespace   = "AWS/EC2"
  dimensions  = { ClusterName = module.ecs_cluster.cluster_name }

  actions_enabled           = true
  insufficient_data_actions = []
  ok_actions                = []
  alarm_actions             = [aws_sns_topic.ecs_healthcheck.arn]
  treat_missing_data        = "missing"

  tags = merge(module.this.tags, { Name = "${module.this.id}-has-sys-check-failure" })
}

resource "aws_cloudwatch_metric_alarm" "example" {
  alarm_name          = "${module.alb.name}-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  period             = 60
  evaluation_periods = 1

  statistic         = "Sum"
  threshold         = local.desired_count
  unit              = "Count"
  alarm_description = "ALB UnHealthy Host Count is less than ${local.desired_count}"

  metric_name = "UnHealthyHostCount"
  namespace   = "AWS/ApplicationELB"

  dimensions = {
    TargetGroup  = module.alb.default_target_group_arn_suffix
    LoadBalancer = module.alb.arn_suffix
  }

  actions_enabled           = true
  insufficient_data_actions = []
  ok_actions                = []
  alarm_actions             = [aws_sns_topic.ecs_healthcheck.arn]
  treat_missing_data        = "missing"

  tags = merge(module.this.tags, { Name = "${module.alb.name}-alarm" })
}
