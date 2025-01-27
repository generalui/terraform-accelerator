module "write_iam_role" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//IamRole?ref=1.0.1-IamRole"

  name    = "example-ecr-write-access-role"
  context = module.this.context

  role_description      = "Example ECR Write Access Role"
  policy_document_count = 0
  principals = {
    AWS = ["arn:aws:iam::${local.account_id}:root"]
  }
  use_fullname = false
}

module "read_iam_role" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//IamRole?ref=1.0.1-IamRole"

  name    = "example-ecr-read-access-role"
  context = module.this.context

  role_description      = "Example ECR Read Access Role"
  policy_document_count = 0
  principals = {
    AWS = ["arn:aws:iam::${local.account_id}:root"]
  }
  use_fullname = false
}

module "ecr" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//ECR?ref=1.0.1-ECR"

  name    = local.ecr_name
  context = module.this.context

  force_delete               = true
  principals_readonly_access = [module.read_iam_role.arn]
  principals_push_access     = [module.write_iam_role.arn]
  use_fullname               = false
}

# Build the example docker image.
resource "docker_image" "this" {
  name = local.image_url

  build {
    context  = "." # Path to the local Dockerfile
    platform = "linux/amd64"
  }
}

# * Push our container image to our ECR.
resource "docker_registry_image" "this" {
  keep_remotely = true # Do not delete old images when a new image is pushed
  name          = resource.docker_image.this.name
}
