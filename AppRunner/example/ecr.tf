module "ecr" {
  source = "git::git@github.com:generalui/terraform-accelerator.git//ECR?ref=1.0.1-ECR"

  name                 = local.ecr_name
  context              = module.this.context
  force_delete         = true
  image_tag_mutability = "MUTABLE"
  use_fullname         = false

  tags = merge(module.this.tags, { Name = local.ecr_name })
}

# Build the example docker image.
resource "docker_image" "this" {
  name = local.image_url

  build {
    context  = "."
    platform = "linux/amd64"
  }
}

# * Push our container image to our ECR.
resource "docker_registry_image" "this" {
  keep_remotely = true # Do not delete old images when a new image is pushed
  name          = resource.docker_image.this.name
}
