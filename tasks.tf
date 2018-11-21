resource "aws_ecs_task_definition" "smtp" {
  family                = "smtp"
  container_definitions = "${data.template_file.smtp_task.rendered}"
  task_role_arn   = "${aws_iam_role.ecs_role.arn}"
  execution_role_arn = "${aws_iam_role.ecs_role.arn}"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu =  256
  memory = 512
  depends_on  =   ["aws_iam_role.ecs_role", "data.template_file.smtp_task"]
}

resource "aws_ecs_task_definition" "memcached" {
  family                = "memcached"
  container_definitions = "${data.template_file.memcached_task.rendered}"
  task_role_arn   = "${aws_iam_role.ecs_role.arn}"
  execution_role_arn = "${aws_iam_role.ecs_role.arn}"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu =  256
  memory = 512
  depends_on  =   ["aws_iam_role.ecs_role", "data.template_file.memcached_task"]
}


resource "aws_ecs_task_definition" "sentry-web" {
  family                = "sentry-web"
  container_definitions = "${data.template_file.web_task.rendered}"
  task_role_arn   = "${aws_iam_role.ecs_role.arn}"
  execution_role_arn = "${aws_iam_role.ecs_role.arn}"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu =  1024
  memory = 2048
  volume{
      name = "sentry-data"
  }
  depends_on  =   ["aws_iam_role.ecs_role", "data.template_file.web_task"]
}