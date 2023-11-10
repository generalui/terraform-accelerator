# AWS EC2 Bastion Server

This module creates a generic Bastion host with parameterized `user_data` and support for AWS SSM Session Manager for remote access with IAM authentication.

<https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html>
<https://docs.aws.amazon.com/prescriptive-guidance/latest/patterns/access-a-bastion-host-by-using-session-manager-and-amazon-ec2-instance-connect.html>

secretsmanager:GetSecretValue
arn:aws:secretsmanager:us-west-2:981823270915:secret:eo-test-eotest-db-7fgk5o-4edZ9Q

aws --query SecretString --output text secretsmanager get-secret-value --secret-id arn:aws:secretsmanager:us-west-2:981823270915:secret:eo-test-eotest-db-7fgk5o-4edZ9Q
