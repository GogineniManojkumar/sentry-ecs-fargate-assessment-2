##################################
# Security Groups 
#################################
resource "aws_security_group" "web-sg" {
    name = "web-sg"
    description = "app security group"
    vpc_id = "${aws_vpc.main.id}"
     ingress {
        from_port = 9000
        to_port = 9000
        protocol = "tcp"
 #      security_groups = ["${aws_security_group.sentry-elb-sg.id}"]
        cidr_blocks = ["0.0.0.0/0"]
    }
     ingress {
        from_port = 9000
        to_port = 9000
        protocol = "tcp"
        security_groups = ["${aws_security_group.sentry-elb-sg.id}"]
#        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
 #      security_groups = ["${aws_security_group.sentry-elb-sg.id}"]
        cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "sentry-web-app-sg"
    }
}

resource "aws_security_group" "smtp-sg" {
    name = "smtp-sg-new"
    description = "smtp security group"
    vpc_id = "${aws_vpc.main.id}"
     ingress {
        from_port = 25
        to_port = 25
        protocol = "tcp"
#        cidr_blocks = ["0.0.0.0/0"]
        security_groups = ["${aws_security_group.web-sg.id}"]
    }
    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "smtp-sg-new"
    }
    depends_on = ["aws_security_group.web-sg"]
}


resource "aws_security_group" "memcached-sg" {
    name = "memcached-sg"
    description = "memcached security group"
    vpc_id = "${aws_vpc.main.id}"
     ingress {
        from_port = 11211
        to_port = 11211
        protocol = "tcp"
#        cidr_blocks = ["0.0.0.0/0"]
        security_groups = ["${aws_security_group.web-sg.id}"]
    }
    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "memcached-sg"
    }
    depends_on = ["aws_security_group.web-sg"]
}


resource "aws_security_group" "redis-sg" {
    name = "redis-sg"
    description = "redis security group"
    vpc_id = "${aws_vpc.main.id}"
     ingress {
        from_port = 6379
        to_port = 6379
        protocol = "tcp"
#        cidr_blocks = ["0.0.0.0/0"]
        security_groups = ["${aws_security_group.web-sg.id}"]
    }
    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "redis-sg"
    }
    depends_on = ["aws_security_group.web-sg"]
}

resource "aws_security_group" "postgres-sg" {
    name = "postgres-sg"
    description = "postgres security group"
    vpc_id = "${aws_vpc.main.id}"
     ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
#        cidr_blocks = ["0.0.0.0/0"]
        security_groups = ["${aws_security_group.web-sg.id}"]
    }
     ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
#        security_groups = ["${aws_security_group.web-sg.id}"]
    }
    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "postgres-sg"
    }
    depends_on = ["aws_security_group.web-sg"]
}


resource "aws_security_group" "sentry-elb-sg" {
    name = "sentry-elb-sg"
    description = "elb security group"
    vpc_id = "${aws_vpc.main.id}"
     ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags {
        Name = "sentry-elb-sg"
    }
}