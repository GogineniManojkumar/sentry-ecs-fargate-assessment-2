data "template_file" "smtp_task" {
  template = "${file("task-definitions/smtp.json")}"

  vars {
    log_group   =   "${var.log_group_name}"
    log_region  =   "${var.log_region}"
    log_prefix  =   "${var.smtp_log_prefix}"
  } 
}

data "template_file" "memcached_task" {
  template = "${file("task-definitions/memcached.json")}"

  vars {
    log_group   =   "${var.log_group_name}"
    log_region  =   "${var.log_region}"
    log_prefix  =   "${var.memcached_log_prefix}"
  } 
}

data "template_file" "ecs_role_policy" {
  template = "${file("policies/ecs-role.json")}"
}
data "template_file" "ecs_service_role_policy" {
  template = "${file("policies/ecs-service-role-policy.json")}"
}


data "template_file" "web_task" {
  template = "${file("task-definitions/web.json")}"

  vars {
    SENTRY_SECRET_KEY =  "${var.sentry_secret_key}"
    SENTRY_REDIS_PORT =  "${var.redis_port}"
    SENTRY_REDIS_HOST =   "${aws_elasticache_replication_group.sentry_ec_redis.primary_endpoint_address}"
    SENTRY_POSTGRES_HOST =   "${module.db.this_db_instance_address}"
    SENTRY_MEMCACHED_HOST = "${var.memcached_host}.${var.LOCAL_DNS}"
    SENTRY_MEMCACHED_PORT =  "${var.memcached_port}"
    SENTRY_POSTGRES_PORT =  "${var.postgres_port}"
    SENTRY_DB_NAME =  "${var.postgres_rds_db_name}"
    SENTRY_DB_USER =  "${var.postgres_rds_user}"
    SENTRY_DB_PASSWORD =  "${var.postgres_rds_password}"
    SENTRY_EMAIL_HOST =   "${var.smtp_host}.${var.LOCAL_DNS}"
    log_group   =   "${var.log_group_name}"
    log_region  =   "${var.log_region}"
    web_log_prefix  =   "${var.web_log_prefix}"
    cron_log_prefix  =   "${var.cron_log_prefix}"
    worker_log_prefix  =   "${var.worker_log_prefix}"
    SENTRY_WEB_USER  = "${var.sentry_web_admin_user}"
    SENTRY_WEB_PASSWORD  = "${var.sentry_web_admin_password}"

  }
}

data "aws_ami" "basic_ami" {
  most_recent      = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }
   filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  owners     = ["amazon"]
}

data "template_file" "init_template" {
  template = "${file("${path.module}/userdata.txt")}"
   vars {
    SENTRY_SECRET_KEY =  "${var.sentry_secret_key}"
    SENTRY_POSTGRES_HOST =   "${module.db.this_db_instance_address}"
    SENTRY_POSTGRES_PORT =  "${var.postgres_port}"
    SENTRY_DB_NAME =  "${var.postgres_rds_db_name}"
    SENTRY_DB_USER =  "${var.postgres_rds_user}"
    SENTRY_DB_PASSWORD =  "${var.postgres_rds_password}"
    SENTRY_WEB_USER  = "${var.sentry_web_admin_user}"
    SENTRY_WEB_PASSWORD  = "${var.sentry_web_admin_password}"
    SENTRY_REDIS_HOST =   "${aws_elasticache_replication_group.sentry_ec_redis.primary_endpoint_address}"

  }
}


