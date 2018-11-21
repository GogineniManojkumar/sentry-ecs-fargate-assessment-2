resource "aws_cloudwatch_log_group" "log_group" {
  name_prefix = "${var.log_group_name}"
  retention_in_days = 60

  tags {
    Environment = "assesment"
  }
}