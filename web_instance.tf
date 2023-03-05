resource "aws_instance" "shaima_web_instance" {
  ami           = "ami-006dcf34c09e50022"
  instance_type = "t2.micro"
  
  vpc_security_group_ids = [aws_security_group.shaima_web_instance_security_group.id]
  subnet_id = aws_subnet.sub_creation["public_subnet"].id

  tags = {
    Name = "shaima_web_instance"
  }
}

resource "aws_security_group" "shaima_web_instance_security_group" {
  name        = "shaima_web_instance_security_group"
  description = "Allow ports 80 & 443"
  vpc_id      = data.aws_vpc.shaima-vpc.id

  ingress {
    description      = "Allow https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "Allow http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "shaima_web_instance_security_group"
  }
}

terraform {
    backend "s3" {
    bucket = "amira-bucket"
    key    = "shaima-s3"
    region = "us-west-1"
  }
}