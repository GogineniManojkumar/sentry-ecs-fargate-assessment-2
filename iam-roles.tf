resource "aws_iam_role" "ecs_role" {
  name               = "ecs_role"
  assume_role_policy = "${data.template_file.ecs_role_policy.rendered}"
  depends_on = ["data.template_file.ecs_role_policy"]
}

/* ecs service scheduler role */
resource "aws_iam_role_policy" "ecs_service_role_policy" {
  name     = "ecs_service_role_policy"
  policy   = "${data.template_file.ecs_service_role_policy.rendered}"
  role     = "${aws_iam_role.ecs_role.id}"
  depends_on  =   ["aws_iam_role.ecs_role", "data.template_file.ecs_service_role_policy"]
}
