# App Runner example

Runnable example: ECR repository, Docker image build/push, and App Runner service.

## Prerequisites

- AWS CLI configured (profile or default)
- Terraform >= 1.1
- Docker (for building and pushing the image)

## Run the app in Docker locally

Build and run the same image used by App Runner to test the PythonExample app locally:

```bash
cd infra/AppRunner/example
docker build -t apprunner-example .
docker run --rm -p 5001:5000 apprunner-example
```

Open <http://localhost:5001> (and <http://localhost:5001/health> for the health check).

## Run

```bash
cd infra/AppRunner/example
terraform init
terraform apply
```

After apply, use the `service_url` output to open the app in a browser.

## Clean up

```bash
terraform destroy
```

## What it creates

- **Label** (context / naming)
- **ECR** repository (via terraform-accelerator ECR module)
- **Docker image** built from the local Dockerfile (Flask app on port 5000), pushed to ECR
- **App Runner service** using that image; module creates the ECR access role automatically

## Variables

Override as needed, e.g. `-var="aws_region=us-east-1"` or a `.tfvars` file.
Key variables: `aws_profile`, `aws_region`, `project`, `namespace`, `environment_name`.
