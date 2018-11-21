
################ VPC #################
resource "aws_vpc" "main" {
  cidr_block       = "${var.main_vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags {
    Name = "assesment-vpc"
  }
}

 ################# Subnets #############
resource "aws_subnet" "subnet1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  depends_on = ["aws_vpc.main"]
  tags {
    Name = "app-subnet-1"
    }
}
resource "aws_subnet" "subnet2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  depends_on = ["aws_vpc.main"]
  tags {
    Name = "app-subnet-2"
  }
}
resource "aws_subnet" "subnet3" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.3.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  depends_on = ["aws_vpc.main"]
  tags {
    Name = "nat-subnet-1"
  }
}
resource "aws_subnet" "subnet4" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.4.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  depends_on = ["aws_vpc.main"]
  tags {
    Name = "alb-subnet-1"
  }
}
resource "aws_subnet" "subnet5" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.5.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  depends_on = ["aws_vpc.main"]
  tags {
    Name = "alb-subnet-2"
  }
}
######## IGW ###############
resource "aws_internet_gateway" "main-igw" {
  vpc_id = "${aws_vpc.main.id}"
  depends_on = ["aws_vpc.main"]
  tags {
    Name = "assesment-vpc-igw"
  }
}

########### NAT ##############
resource "aws_eip" "nat" {
}

resource "aws_nat_gateway" "main-natgw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.subnet3.id}"
  depends_on = ["aws_subnet.subnet3","aws_eip.nat"]
  tags {
    Name = "assesment-vpc-nat"
  }
}

############# Route Tables ##########

resource "aws_route_table" "main-public-rt" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-igw.id}"
  }
  depends_on = ["aws_vpc.main"]
  tags {
    Name = "assesment-public-rt"
  }
}

resource "aws_route_table" "main-private-rt" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.main-natgw.id}"
  }
  depends_on = ["aws_vpc.main"]
  tags {
    Name = "assesment-private-rt"
  }
}

######### PUBLIC Subnet assiosation with rotute table    ######
resource "aws_route_table_association" "private-assoc-1" {
  subnet_id      = "${aws_subnet.subnet1.id}"
  route_table_id = "${aws_route_table.main-private-rt.id}"
  depends_on = [ "aws_route_table.main-private-rt"]
}
resource "aws_route_table_association" "private-assoc-2" {
  subnet_id      = "${aws_subnet.subnet2.id}"
  route_table_id = "${aws_route_table.main-private-rt.id}"
  depends_on = [ "aws_route_table.main-private-rt"]
}
resource "aws_route_table_association" "public-assoc-3" {
  subnet_id      = "${aws_subnet.subnet3.id}"
  route_table_id = "${aws_route_table.main-public-rt.id}"
  depends_on = [ "aws_route_table.main-public-rt"]
}
resource "aws_route_table_association" "public-assoc-4" {
  subnet_id      = "${aws_subnet.subnet4.id}"
  route_table_id = "${aws_route_table.main-public-rt.id}"
  depends_on = [ "aws_route_table.main-public-rt"]
}
resource "aws_route_table_association" "public-assoc-5" {
  subnet_id      = "${aws_subnet.subnet5.id}"
  route_table_id = "${aws_route_table.main-public-rt.id}"
  depends_on = [ "aws_route_table.main-public-rt"]
}