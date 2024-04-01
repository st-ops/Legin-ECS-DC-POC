locals {
  log_group = "/ecs/fullstack-td"
}



resource "aws_ecs_task_definition" "fullstack" {
  family             = "fullstack-td"
  network_mode       = "awsvpc"  # Updated to use awsvpc network mode
  task_role_arn =  "arn:aws:iam::244974977085:role/ecsTaskExecutionRole"
  execution_role_arn =  "arn:aws:iam::244974977085:role/ecsTaskExecutionRole"
  requires_compatibilities = ["FARGATE"]
  cpu = 1024
  memory = 3072
  runtime_platform {
        cpu_architecture ="X86_64"
        operating_system_family = "LINUX"
  }
  container_definitions = jsonencode([
        {
            "name": "frontend",
            "image": "legin04/fullstack-frontend:latest",
            "cpu": 0,
            "portMappings": [
                {
                    "name": "frontend-3000-tcp",
                    "containerPort": 3000,
                    "hostPort": 3000,
                    "protocol": "tcp",
                    "appProtocol": "http"
                }
            ],
            "essential": true,
            "environment": [],
            "mountPoints": [],
            "volumesFrom": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": "/ecs/fullstack-td",
                    "awslogs-region": "ap-south-1",
                    "awslogs-stream-prefix": "ecs"
                },
                "secretOptions": []
            },
            "systemControls": []
        },
        {
            "name": "backend",
            "image": "legin04/fullstack-backend:latest",
            "cpu": 0,
            "portMappings": [
                {
                    "name": "backend-4000-tcp",
                    "containerPort": 4000,
                    "hostPort": 4000,
                    "protocol": "tcp"
                }
            ],
            "essential": true,
            "environment": [
                {
                    "name": "MYSQL_DATABASE",
                    "value": "products"
                },
                {
                    "name": "MYSQL_PASSWORD",
                    "value": "root"
                },
                {
                    "name": "MYSQL_PORT",
                    "value": "3306"
                },
                {
                    "name": "MYSQL_HOST",
                    "value": "localhost"
                },
                {
                    "name": "MYSQL_USER",
                    "value": "root"
                }
            ],
            "mountPoints": [],
            "volumesFrom": [],
            "dependsOn": [
                {
                    "containerName": "mysql",
                    "condition": "HEALTHY"
                }
            ],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": "/ecs/fullstack-td",
                    "awslogs-region": "ap-south-1",
                    "awslogs-stream-prefix": "ecs"
                },
                "secretOptions": []
            },
            "systemControls": []
        },
        {
            "name": "mysql",
            "image": "legin04/fullstack-mysql:latest",
            "cpu": 0,
            "portMappings": [
                {
                    "name": "mysql-3306-tcp",
                    "containerPort": 3306,
                    "hostPort": 3306,
                    "protocol": "tcp"
                }
            ],
            "essential": true,
            "environment": [
                {
                    "name": "MYSQL_DATABASE",
                    "value": "products"
                },
                {
                    "name": "MYSQL_PASSWORD",
                    "value": "root"
                },
                {
                    "name": "MYSQL_ROOT_PASSWORD",
                    "value": "root"
                }
            ],
            "mountPoints": [],
            "volumesFrom": [],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": "/ecs/fullstack-td",
                    "awslogs-region": "ap-south-1",
                    "awslogs-stream-prefix": "ecs"
                },
                "secretOptions": []
            },
            "healthCheck": {
                "command": [
                    "CMD-SHELL",
                    "mysqladmin ping -h localhost"
                ],
                "interval": 10,
                "timeout": 5,
                "retries": 10
            },
            "systemControls": []
        }
    ])
    
}

