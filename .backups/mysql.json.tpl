[
    {
      "name": "mysql",
      "image": "docker.io/legin04/fullstack-mysql",
      "cpu": 256,
      "memory": 1024,
      "portMappings": [
        {
          "containerPort": 3306,
          "hostPort": 3306,
          "protocol": "tcp"
        }
      ],
      "environment": [
        {
          "name": "MYSQL_ROOT_PASSWORD",
          "value": "root"
        },
        {
          "name": "MYSQL_DATABASE",
          "value": "products"
        },
        {
          "name": "MYSQL_USER",
          "value": "root"
        },
        {
          "name": "MYSQL_PASSWORD",
          "value": "root"
        }
      ],
      "healthCheck": {
        "command": [
          "CMD-SHELL",
          "mysqladmin ping -h localhost"
        ],
        "interval": 5,
        "retries": 10
      }
    }
  ]