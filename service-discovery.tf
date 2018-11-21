resource "aws_service_discovery_private_dns_namespace" "local_dns" {
  name        = "${var.LOCAL_DNS}"
  description = "local DNS"
  vpc         = "${aws_vpc.main.id}"
  
}

resource "aws_service_discovery_service" "smtp_dns" {
  name = "smtp"

  dns_config {
    namespace_id = "${aws_service_discovery_private_dns_namespace.local_dns.id}"

    dns_records {
      ttl  = 10
      type = "A"
    }
  }
  health_check_custom_config {
    failure_threshold = 1
  }
 # depends_on = ["aws_service_discovery_private_dns_namespace.local_dns"]
}

resource "aws_service_discovery_service" "memcached_dns" {
  name = "memcached"

  dns_config {
    namespace_id = "${aws_service_discovery_private_dns_namespace.local_dns.id}"

    dns_records {
      ttl  = 10
      type = "A"
    }
  }
  health_check_custom_config {
    failure_threshold = 1
  }
#  depends_on = ["aws_service_discovery_private_dns_namespace.local_dns"]
}
resource "aws_service_discovery_service" "sentry_web_dns" {
  name = "sentry-web"

  dns_config {
    namespace_id = "${aws_service_discovery_private_dns_namespace.local_dns.id}"

    dns_records {
      ttl  = 10
      type = "A"
    }
  }
  health_check_custom_config {
    failure_threshold = 1
  }
 # depends_on = ["aws_service_discovery_private_dns_namespace.local_dns"]
}
