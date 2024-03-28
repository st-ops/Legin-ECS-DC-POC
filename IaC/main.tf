
# ECS Cluster
resource "aws_ecs_cluster" "my_cluster" {
  name = "fullstack-cluster"
}


data "aws_iam_policy_document" "ecs_task_execution_role" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_ecs_service" "fullstack" {
  name            = "fullstack-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.fullstack.arn
  launch_type = "FARGATE"
  desired_count   = 1
  # deployment_minimum_healthy_percent = 50
  # deployment_maximum_percent = 100

  network_configuration {
    subnets = "${data.aws_subnet.test_subnet.*.id}"
    security_groups = [aws_security_group.my_security_group.id]
  }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecs-staging-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "test_subnet_ids" {
  filter {
    name = "vpc-id"
    values = [ data.aws_vpc.default.id ]
  }
}

data "aws_subnet" "test_subnet" {
  count = "${length(data.aws_subnets.test_subnet_ids.ids)}"
  id    = "${tolist(data.aws_subnets.test_subnet_ids.ids)[count.index]}"
}


# Create a security group
resource "aws_security_group" "my_security_group" {
  vpc_id = data.aws_vpc.default.id

  // Add ingress rules to allow inbound traffic
  ingress {
    from_port   = 3306 // MySQL port
    to_port     = 3306 // MySQL port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Allow traffic from anywhere (for demonstration purposes)
  }

  ingress {
    from_port   = 3000 // Frontend port
    to_port     = 3000 // Frontend port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Allow traffic from anywhere (for demonstration purposes)
  }

  ingress {
    from_port   = 4000 // Backend port
    to_port     = 4000 // Backend port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Allow traffic from anywhere (for demonstration purposes)
  }

  // Add egress rule to allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_log_group" "fullstack" {
  name = "/ecs/fullstack"

}

