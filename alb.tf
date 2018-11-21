resource "aws_lb" "sentry-lb" {
  name_prefix        = "sentry"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.sentry-elb-sg.id}"]
  subnets            = ["${aws_subnet.subnet5.id}","${aws_subnet.subnet4.id}"]
 # enable_deletion_protection = true
  enable_cross_zone_load_balancing = true
  tags {
    Environment = "assesment"
  }
}

#######
#Sentry Target Group 
########
resource "aws_lb_target_group" "sentry-tg" {
  name_prefix    = "sentry"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = "${aws_vpc.main.id}"
  health_check {
      interval = 30
      path = "/"
      port = 9000
      protocol = "HTTP"
      timeout = 20
      healthy_threshold = 4
      unhealthy_threshold = 5
      matcher = "200,302"
  }
}

###########
#Listner 80
######
resource "aws_lb_listener" "http_80" {
  load_balancer_arn = "${aws_lb.sentry-lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.sentry-tg.arn}"
  }
  depends_on = [ "aws_lb.sentry-lb"]
}