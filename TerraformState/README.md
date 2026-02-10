# Terraform State

## Create

Follow this procedure just once to create your deployment.

1. Add the `terraform_state_backend` module to your `main.tf` file.
    Include the comment to help to remember to follow this procedure in the future:

    ```hcl
    # You cannot create a new backend by simply defining this and then
    # immediately proceeding to "terraform apply". The S3 backend must
    # be bootstrapped according to the simple yet essential procedure in
    # https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
    module "terraform_state_backend" {
        source = "./modules/TerraformState"

        attributes = ["state"]
        context    = module.this.context

        force_destroy                      = false
        profile                            = "default"
        role_arn                           = "arn:aws:iam::123456789876:role/DevOps" # Assumed Role Arn
        terraform_backend_config_file_path = "."
        terraform_state_file               = "test.terraform.tfstate"
    }

    # Your Terraform configuration
    module "another_module" {
        source = "....."
    }
    ```

   Note that when `terraform_backend_config_file_path` is empty (the default), no `backend.tf` file is created.

1. Ensure the `terraform_backend_config_file_path` module input is set to `"."` and the `force_destroy` module input is set to `false`.

    ```hcl
    force_destroy                      = false
    terraform_backend_config_file_path = "."
    ```

1. Download the Terraform modules and providers.

    ```sh
    terraform init
    ```

1. Create the state bucket and DynamoDB locking table, along with anything else defined in the `*.tf` files.

    ```sh
    terraform apply -auto-approve
    ```

    At this point, the Terraform state is still stored locally.
    A new `backend.tf` file will automatically be created that defines the S3 state backend.
    Ensure this is committed to git.
    If there is no `backend.tf` file, ensure the `terraform_backend_config_file_path` variable is set with `"."`.

    Example `backend.tf` file:

    ```hcl
    terraform {
        required_version = ">= 1.0.0"

        backend "s3" {
            region         = "us-west-2"
            bucket         = "eo-test-eotest-state"
            key            = "test.terraform.tfstate"
            dynamodb_table = "eo-test-eotest-state-lock"
            profile        = "default"
            role_arn       = "arn:aws:iam::123456789876:role/DevOps"
            encrypt        = "true"
        }
    }
    ```

    Remove the value from `profile` so it is like `profile = ""`.
    Moving forward, Terraform will read this newly-created backend definition file.

    If an error is returned with
    `error OperationAborted: A conflicting conditional operation is currently in progress against this resource. Please try again.`,
    ignore it and move on to the next step.

1. ```sh
    terraform init -force-copy
    ```

    Terraform moves the Terraform state to the S3 backend, and it does so per `-auto-approve`.
    Now the state is stored in the S3 bucket, and the DynamoDB table will be used to lock the state to prevent concurrent modification.

1. Remove the `terraform.tfstate` and `terraform.tfstate.backup` files.

This concludes the one-time preparation. Now you can extend and modify your Terraform configuration per usual.

## Destroy

Follow this procedure to delete the deployment.

1. Ensure the `terraform_backend_config_file_path` module input is set to `""` (the default) and the `force_destroy` module input is set to `true`.

    ```hcl
    force_destroy                      = true
    terraform_backend_config_file_path = ""
    ```

1. ```sh
    terraform apply -target module.terraform_state_backend -auto-approve
    ```

   This implements the above modifications by deleting the `backend.tf` file and enabling deletion of the S3 state bucket.

1. ```sh
    terraform init -force-copy
    ```

    Terraform moves the Terraform state from the S3 backend to local files, and it does so per `-auto-approve`.
    Now the state is once again stored locally and the S3 state bucket can be safely deleted.

1. Deletes all resources in the deployment.

    ```sh
    terraform destroy
    ```

    If an error is returned with
    `error OperationAborted: A conflicting conditional operation is currently in progress against this resource. Please try again.`,
    simply run `terraform destroy` again.

1. Examine local state file `terraform.tfstate` to verify that it contains no resources.
    It should be similar to:

    ```hcl
    {
        "version": 4,
        "terraform_version": "1.5.6",
        "serial": 15,
        "lineage": "c12345f1-123a-a2cf-2a4b-c86cf0f0e123",
        "outputs": {},
        "resources": [],
        "check_results": null
    }
    ```

## Module Specs

[SPECS.md](./SPECS.md)
