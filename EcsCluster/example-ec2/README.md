# AWS ECS EC2 Terraform Module Example

## How To Run and Test the Example

1) Initialize:

    ```sh
    terraform init
    ```

1) Plan

    ```sh
    terraform plan
    ```

1) Apply

    ```sh
    terraform apply
    ```

1) Navigate to the the ECS Cluster in the AWS console ([`xmpl-test-ecs-ec2`](https://us-west-2.console.aws.amazon.com/ecs/v2/clusters/xmpl-test-ecs-ec2/services/xmpl-test-ecs-ec2/health?region=us-west-2)).

1) Ensure 1 of 1 tasks are running (it may take some time for the task to complete).

1) Navigate to the ALB in the [EC2 Dashboard](https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#LoadBalancers:)

1) Select the example ALB (`xmpl-test-ecs-ec2`) created by this example Terraform.

1) Capture the "DNS Name" and open it in a browser.

1) The "Hello World!" response should be displayed.

## How To Destroy the Example

1) Delete all images from the example ECR.

1) Destroy the resources

    Currently, there are some issues with destroying the example ECS EC2 Cluster.
    To destroy the example ECS Cluster, you must manually terminate the EC2 instance.
    Then, manually delete the example ECS Cluster from the AWS console.

    This still may not do the job. If the autoscaling group is not deleted, run the following command
    (ensure the same AWS profile used in the terraform example is set in the terminal ie `export AWS_PROFILE=devops_sandbox_eo`):

    ```sh
    aws autoscaling delete-auto-scaling-group --auto-scaling-group-name xmpl-test-ecs-ec2 --force-delete
    ```

    Then, destroy the resources.

    ```sh
    terraform destroy
    ```

## Example Specs

[SPECS.md](./SPECS.md)
