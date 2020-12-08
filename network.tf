resource "aws_vpc" "automation-network" {
  cidr_block           = "172.31.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "terraform_vpc"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = "${aws_vpc.automation-network.id}"
  cidr_block              = "172.31.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"

  tags = {
    Name = "Subnet public a"
  }
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id            = "${aws_vpc.automation-network.id}"
  cidr_block        = "172.31.2.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "Subnet private b"
  }
}

resource "aws_internet_gateway" "internet-gateway-terraform" {
  vpc_id = "${aws_vpc.automation-network.id}"

  tags = {
    Name = "InternetGateway"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.automation-network.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet-gateway-terraform.id}"
}

resource "aws_security_group" "ssh" {
  vpc_id = "${aws_vpc.automation-network.id}"

  tags = {
    Name = "terraform_sec_group_ssh"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "csgo" {
  description = "Security group for Counter Strike server"
  vpc_id      = "${aws_vpc.automation-network.id}"

  tags = {
    Name = "terraform_sec_group_csgo"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]

    from_port   = 27015
    to_port     = 27015
    protocol    = "udp"
    description = "CSgo server access"
  }
}