resource "aws_db_subnet_group" "rds-db" {

  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]
  name       = "main"

  tags = {
    Name  = "Subnet group for RDs"
    Owner = {}
  }

}

resource "aws_elasticache_subnet_group" "cvengine-ecache-subgroup" {

  name       = "cvengine-ecache-subgrp"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]

  tags = {
    "Name" = "Subnet Group of ecache"
     "Owner" = {}
  }
}

resource "aws_db_instance" "cvengine-rds" {

  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = var.dbname
  username               = var.dbuser
  password               = var.dbpass
  parameter_group_name   = "default.mysql5.7"
  publicly_accessible    = "false"
  multi_az               = "false"
  skip_final_snapshot    = "true"
  db_subnet_group_name   = aws_db_subnet_group.rds-db.name
  vpc_security_group_ids = [aws_security_group.cvengine-backend-sg.id]

}

resource "aws_elasticache_cluster" "cvengine-cache" {
  cluster_id           = "cvengine-cache"
  engine               = "memcached"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  port                 = 11211
  subnet_group_name    = aws_elasticache_subnet_group.cvengine-ecache-subgroup.name
  security_group_ids   = [aws_security_group.cvengine-backend-sg.id]
}

/*resource "aws_mq_broker" "cvengine-rmq" {
  broker_name = "cvengine-rmq"

  engine_type        = "ActiveMQ"
  engine_version     = "5.15.0"
  host_instance_type = "mq.t2.micro"
  security_groups    = [aws_security_group.cvengine-backend-sg.id]
  subnet_ids         = [module.vpc.private_subnets[0]]

  user {
    username = var.rmquser
    password = var.rmqpass
  }*/
  
