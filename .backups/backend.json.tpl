[
    {
      "name": "backend",
      "image": "docker.io/legin04/fullstack-backend",
      "cpu": 256,
      "memory": 512,
      "portMappings": [
        {
          "containerPort": 4000,
          "hostPort": 4000,
          "protocol": "tcp"
        }
      ],
      "environment": [
        {
          "name": "MYSQL_HOST",
          "value": "mysql"
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
        },
        {
          "name": "MYSQL_PORT",
          "value": "3306"
        }
      ]
    }
  ]
