resource "aws_security_group" "shaima_RDS_instance_security_group" {
  name        = "shaima_RDS_instance_security_group"
  description = "Allow port 3306"
  vpc_id      = data.aws_vpc.shaima-vpc.id

  ingress {
    description      = "Allow RDS traffic"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["10.10.0.0/16"]
  }
  tags = {
    Name = "allow RDS traffic"
  }
}


resource "aws_db_subnet_group" "shaima-sub-group" {
  name       = "shaima-sub-group"
  subnet_ids = [aws_subnet.sub_creation["private_subnet_1"].id, aws_subnet.sub_creation["private_subnet_2"].id]

  tags = {
    Name = "shaima-sub-group"
  }
}

resource "aws_db_instance" "shaima_RDS_instance" {
  allocated_storage    = 10
  db_name              = "shaima_RDS"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "shaima"
  password             = "shimo123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = "shaima-sub-group"
  multi_az = true

  vpc_security_group_ids = [aws_security_group.shaima_RDS_instance_security_group.id]
}



