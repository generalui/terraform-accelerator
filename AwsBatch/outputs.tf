output "batch_instance_role" {
  description = "The name of the batch instance role."
  value       = aws_iam_role.batch_instance_role.name
}

output "job_definition_arn" {
  description = "The ARN of the job definition, includes revision (:#)."
  value       = aws_batch_job_definition.batch_job_definition.arn
}

output "job_definition_arn_prefix" {
  description = "The ARN of the job definition without the revision number."
  value       = aws_batch_job_definition.batch_job_definition.arn_prefix
}

output "job_definition_revision" {
  description = "The revision of the job definition."
  value       = aws_batch_job_definition.batch_job_definition.revision
}

output "job_queue_arn" {
  description = "The ARN of the job queue."
  value       = aws_batch_job_queue.batch_job_queue.arn
}
