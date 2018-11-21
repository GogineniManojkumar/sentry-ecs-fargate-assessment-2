resource "aws_elasticache_subnet_group" "redis-subnet-group" {
  name       = "redis-subnet-group"
  subnet_ids = ["${aws_subnet.subnet1.id}","${aws_subnet.subnet2.id}"]
}
resource "aws_elasticache_replication_group" "sentry_ec_redis" {
  automatic_failover_enabled    = true
  replication_group_id          = "sentry-redis"
  replication_group_description = "sentry-redis"
  node_type                     = "${var.redis_node_type}"
  number_cache_clusters         = "${var.redis_node_count}"
  port                          = 6379
  engine               = "${var.redis_engine}"
  engine_version       = "${var.redis_engine_version}" 
  security_group_ids   = [ "${aws_security_group.redis-sg.id}" ]
  subnet_group_name    = "${aws_elasticache_subnet_group.redis-subnet-group.name}"
  apply_immediately    = true
  automatic_failover_enabled    = false

}