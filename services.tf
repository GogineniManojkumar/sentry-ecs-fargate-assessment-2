resource "aws_ecs_service" "smtp" {
    name            = "smtp"
    cluster         = "${aws_ecs_cluster.ecs_cluster.id}"
    task_definition = "${aws_ecs_task_definition.smtp.arn}"
    launch_type = "FARGATE"
    desired_count   = 1
    scheduling_strategy = "REPLICA"
    network_configuration {
        subnets = [ "${aws_subnet.subnet1.id}","${aws_subnet.subnet2.id}"]
        security_groups = [ "${aws_security_group.smtp-sg.id}"]
    }
    service_registries {
        registry_arn = "${aws_service_discovery_service.smtp_dns.arn}"
    }
    depends_on = ["aws_ecs_task_definition.smtp", "aws_ecs_cluster.ecs_cluster", "aws_security_group.smtp-sg"]
}

resource "aws_ecs_service" "memcached" {
    name            = "memcached"
    cluster         = "${aws_ecs_cluster.ecs_cluster.id}"
    task_definition = "${aws_ecs_task_definition.memcached.arn}"
    launch_type = "FARGATE"
    desired_count   = 1
    scheduling_strategy = "REPLICA"
    network_configuration {
        subnets = [ "${aws_subnet.subnet1.id}","${aws_subnet.subnet2.id}"]
        security_groups = [ "${aws_security_group.memcached-sg.id}"]
    }
    service_registries {
        registry_arn = "${aws_service_discovery_service.memcached_dns.arn}"
    }
    depends_on = ["aws_ecs_task_definition.memcached" , "aws_ecs_cluster.ecs_cluster", "aws_security_group.memcached-sg"]
}

resource "aws_ecs_service" "sentry-web" {
    name            = "sentry-web"
    cluster         = "${aws_ecs_cluster.ecs_cluster.id}"
    task_definition = "${aws_ecs_task_definition.sentry-web.arn}"
    launch_type = "FARGATE"
    desired_count   = 1
    scheduling_strategy = "REPLICA"
    network_configuration {
        subnets = [ "${aws_subnet.subnet1.id}","${aws_subnet.subnet2.id}"]
        security_groups = [ "${aws_security_group.web-sg.id}"]
    }
    service_registries {
        registry_arn = "${aws_service_discovery_service.sentry_web_dns.arn}"
    }
  load_balancer {
    target_group_arn = "${aws_lb_target_group.sentry-tg.arn}"
    container_name   = "web"
    container_port   = 9000
    }
    depends_on = ["aws_ecs_task_definition.sentry-web", "aws_ecs_cluster.ecs_cluster", "aws_security_group.web-sg" ]
}

