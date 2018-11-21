variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
    description = "Region To Setup Stack"
}

variable "log_group_name"{
    description = "log_group"
    default = "ecs-logs"
}
variable "ecs_cluster_name"{
    description = "ECS Cluster Name"
    default = "assesment2"
}

variable "log_region"{
    description = "log_region"
    default = "us-east-1"
}
variable "smtp_log_prefix"{
    description = "postgres log_prefix"
    default = "smtp"
}
variable "memcached_log_prefix"{
    description = "postgres log_prefix"
    default = "memcached"
}
variable "web_log_prefix"{
    description = "web log_prefix"
    default = "web"
}
variable "cron_log_prefix"{
    description = "cron log_prefix"
    default = "cron"
}
variable "worker_log_prefix"{
    description = "worker log_prefix"
    default = "worker"
}

variable "postgres_port"{
    description = "Postgres Port"
    default = "5432"
}
variable "sentry_secret_key"{
    description = "sentry secret key"
    default="AM9_jdY&3$G#MYD^dhLsO*!@.DmQHsPlAzICSDD(%SaDQ"
}

variable "redis_port"{
    description = "Redis Port"
    default = "6379"
}

variable "memcached_host"{
    description = "Memcached Host"
    default = "memcached"
}

variable "memcached_port"{
    description = "Memcached Port"
    default = "11211"
}

variable "smtp_host"{
    description = "SMTP Host"
    default = "smtp"
}

variable "LOCAL_DNS"{
    description = "Domain for DNS"
    default = "manoj.local"
}

variable "sentry_web_admin_user"{
    description = "SuperUser UserName Email"
    default = "admin@gmail.com"
}

variable "sentry_web_admin_password"{
    description = "SuperUser Password"
    default = "Admin@123"
}
data "aws_availability_zones" "available" {}
 
variable "instancetype" {
    description = "sentry instance type"
    default = "t2.medium"
}

variable "keypair" {
    description = "ssh keypair"
    default = "test"
}

variable "rds_data_populate" {
  description = "The rds_data_populate condition"
  default     = "true"
}

variable "main_vpc_cidr" {
    description = "CIDR of the VPC"
    default = "10.0.0.0/16"
}


variable "postgres_rds_identifier" {
    description = "RDS Name"
    default = "sentry-postgres"
}

variable "postgres_rds_engine" {
    description = "RDS engine"
    default = "postgres"
}

variable "postgres_rds_engine_version" {
    description = "RDS Version"
    default = "9.5.14"
}

variable "postgres_instance_class" {
    description = "RDS Instance Type"
    default = "db.t2.micro"
}

variable "postgres_rds_db_name" {
    description = "DB Name"
    default = "sentry"
}

variable "postgres_rds_user" {
    description = "RDS User Name"
    default = "sentryadmin"
}

variable "postgres_rds_password" {
    description = "RDS Password"
    default = "Sentry1234"
}

variable "postgres_rds_parameter_group" {
    description = "RDS Parameter Group"
    default = "postgres9.5"
}
variable "redis_node_type" {
    description = "Redis Instacnce Type"
    default = "cache.t2.micro"
}
variable "redis_engine_version" {
    description = "Redis engine"
    default = "3.2.10"
}
variable "redis_engine" {
    description = "Redis engine"
    default = "redis"
}

variable "redis_node_count" {
    description = "Redis nodes count"
    default = "1"
}