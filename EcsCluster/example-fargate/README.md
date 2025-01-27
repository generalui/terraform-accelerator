# AWS ECS Fargate Terraform Module Example

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

1) Navigate to the the ECS Cluster in the AWS console ([`xmpl-test-ecs-fargate`](https://us-west-2.console.aws.amazon.com/ecs/v2/clusters/xmpl-test-ecs-fargate/services/xmpl-test-ecs-fargate/health?region=us-west-2)).

1) Ensure 1 of 1 tasks are running (it may take some time for the task to complete).

1) Navigate to the ALB in the [EC2 Dashboard](https://us-west-2.console.aws.amazon.com/ec2/home?region=us-west-2#LoadBalancers:)

1) Select the example ALB (`xmpl-test-ecs-fargate`) created by this example Terraform.

1) Capture the "DNS Name" and open it in a browser.

1) The "Hello World!" response should be displayed.

## How To Destroy the Example

1) Delete all images from the example ECR.

1) Destroy the resources

    ```sh
    terraform destroy
    ```

## Example Specs

[SPECS.md](./SPECS.md)
