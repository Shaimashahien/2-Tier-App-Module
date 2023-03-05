variable "shaima-vpc" {}
data "aws_vpc" "shaima-vpc" {
  id = var.shaima-vpc
}

variable "subnets" {
 
    type = map
    default = {
    private_subnet_1 = {
    "name" = "private_subnet_1"
    "availability_zone_id" = "use1-az4"
    "cidr_block" = "10.10.2.0/24"
  }
  
    private_subnet_2 = {

    "name" = "private_subnet_2"
    "availability_zone_id" = "use1-az6"
    "cidr_block" = "10.10.3.0/24"
  }
 
    public_subnet = {
    "name" = "public_subnet"
    "availability_zone_id" = "use1-az4"
    "cidr_block" = "10.10.1.0/24"
 
  }
}
}





