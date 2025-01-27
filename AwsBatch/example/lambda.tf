# module "lambda" {
#   depends_on = [module.inside_policy]
#   source = "git::git@github.com:generalui/terraform-accelerator.git//Lambda?ref=1.0.1-Lambda"

#   name    = "example-batch-slack-lambda"
#   context = module.this.context

#   filename               = join("", data.archive_file.lambda_zip.*.output_path)
#   function_name          = module.this.id
#   handler                = "handler.handler"
#   runtime                = "nodejs14.x"
#   ephemeral_storage_size = 1024

#   custom_iam_policy_arns = [
#     "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess",
#     local.policy_arn_inside
#     # module.inside_policy.arn, # This will result in an error message and is why we use local.policy_arn_inside
#   ]
# }

# resource "aws_lambda_function" "handler_ecs_event_instance_availability" {
#   filename = "${data.archive_file.lambda_zip_ecs_event_instance_availability.output_path}"
#   source_code_hash = "${data.archive_file.lambda_zip_ecs_event_instance_availability.output_base64sha256}"
#   function_name = "${local.lambda_name_ecs_event_instance_availability}"
#   role = "${aws_iam_role.lambda_ecs_event.arn}"

#   depends_on = ["aws_cloudwatch_log_group.lambda_ecs_event_instance_availability"]

#   # {file_name}.{function_name}
#   handler = "main.lambda_handler"
#   runtime = "python2.7"
#   timeout = 30

#   environment {
#     variables = {
#       SLACK_WEBHOOK_URL = "https://${var.slack_webhook_url_alert}"
#       SLACK_WEBHOOK_CHANNEL = "${var.slack_webhook_channel_alert}"
#       SLACK_WEBHOOK_BOT_NAME = "AWS ECS Event (Instance Availability)"
#       SLACK_WEBHOOK_BOT_EMOJI = ":this_is_fine:"
#       ECS_CLUSTER_NAME = "${aws_ecs_cluster.container.name}"
#       CURRENT_AWS_REGION = "${var.region}"
#       META_COMPANY = "${var.company}"
#       META_PROJECT = "${var.project}"
#       ENV = "AWS"
#     }
#   }

#   lifecycle {
#     ignore_changes = []
#   }

#   tags {
#     Terraform = "true"

#     Environment = "${var.environment}"
#     Company = "${var.company}"
#     Project = "${var.project}"

#     # belongs to the ecs resource
#     Name = "ecs.${lower(var.project)}.${lower(var.company)}.io"
#   }
# }
