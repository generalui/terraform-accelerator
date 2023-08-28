# A key pair is required to ultimately allow SSH access
resource "aws_key_pair" "kp" {
  key_name      = "${var.environment_name}"
  public_key    = file(var.ec2_key)
}