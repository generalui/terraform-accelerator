# Role for ECS task
# This is because our Fargate ECS must be able to pull images from ECS
# and put logs from application container to log driver

data "aws_secretsmanager_secret" "ci_secrets_by_name" {
  name = var.ci_secret_name
}

data "aws_secretsmanager_secret_version" "ci_secrets" {
  secret_id = data.aws_secretsmanager_secret.ci_secrets_by_name.id
}

data "aws_iam_policy_document" "ecs_task_exec_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_exec_role" {
  name               = "${var.environment_name}-taskrole-ecs"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_exec_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_exec_role" {
  role       = aws_iam_role.ecs_task_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Cloudwatch logs

resource "aws_cloudwatch_log_group" "api" {
  name = "/fargate/${var.environment_name}-api"

  tags = {
    App = var.name_api
  }
}

resource "aws_cloudwatch_log_group" "fe" {
  name = "/fargate/${var.environment_name}-fe"

  tags = {
    App = var.name_fe
  }
}

# Cluster

resource "aws_ecs_cluster" "api" {
  depends_on = [aws_cloudwatch_log_group.api]
  name       = "${var.environment_name}-api"

  tags = {
    App = var.name_api
  }
}

resource "aws_ecs_cluster" "fe" {
  depends_on = [aws_cloudwatch_log_group.fe]
  name       = "${var.environment_name}-fe"

  tags = {
    App = var.name_fe
  }
}

# Task definition for the application

resource "aws_ecs_task_definition" "api" {
  family                   = "${var.environment_name}-td-api"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_fargate_application_cpu
  memory                   = var.ecs_fargate_application_mem
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_exec_role.arn
  container_definitions = jsonencode([
    {
      name  = "${var.environment_name}-api"
      image = "${aws_ecr_repository.repo.repository_url}:api-latest"
      environment = [
        {
          name  = "DATABASE_URL"
          value = "ecto://${jsondecode(data.aws_secretsmanager_secret_version.db_secrets.secret_string)[var.db_secret_user]}:${jsondecode(data.aws_secretsmanager_secret_version.db_secrets.secret_string)[var.db_secret_pass]}@${aws_db_instance.default.address}:${aws_db_instance.default.port}/${var.db_name}"
        }
      ],
      portMappings = [
        {
          containerPort = 4000
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.api.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs-fargate"
        }
      }
    }
  ])

  tags = {
    App = var.name_api
  }
}

resource "aws_ecs_task_definition" "fe" {
  family                   = "${var.environment_name}-td-fe"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_fargate_application_cpu
  memory                   = var.ecs_fargate_application_mem
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_exec_role.arn
  container_definitions = jsonencode([
    {
      name        = "${var.environment_name}-fe"
      image       = "${aws_ecr_repository.repo.repository_url}:fe-latest"
      environment = [],
      portMappings = [
        {
          containerPort = 3000
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.fe.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs-fargate"
        }
      }
    }
  ])

  tags = {
    App = var.name_fe
  }
}


resource "aws_ecs_service" "api" {
  name            = "${var.environment_name}-service-api"
  cluster         = aws_ecs_cluster.api.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = var.ecs_application_count

  load_balancer {
    target_group_arn = aws_lb_target_group.api.arn
    container_name   = "${var.environment_name}-api"
    container_port   = 4000
  }

  network_configuration {
    assign_public_ip = false

    security_groups = [
      aws_security_group.egress_all_api.id,
      aws_security_group.service_api.id
    ]
    subnets = [aws_subnet.private_api.id]
  }

  depends_on = [
    aws_lb_listener.http_api,
    aws_ecs_task_definition.api
  ]

  tags = {
    App = var.name_api
  }
}

resource "aws_ecs_service" "fe" {
  name            = "${var.environment_name}-service-fe"
  cluster         = aws_ecs_cluster.fe.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.fe.arn
  desired_count   = var.ecs_application_count

  load_balancer {
    target_group_arn = aws_lb_target_group.fe.arn
    container_name   = "${var.environment_name}-fe"
    container_port   = 3000
  }

  network_configuration {
    assign_public_ip = false

    security_groups = [
      aws_security_group.egress_all_fe.id,
      aws_security_group.service_fe.id
    ]
    subnets = [aws_subnet.private_fe.id]
  }

  depends_on = [
    aws_lb_listener.http_fe,
    aws_ecs_task_definition.fe
  ]

  tags = {
    App = var.name_fe
  }
}
