output "app_url" {
  description = "URL na kojem je dostupna aplikacija preko ALB-a"
  value       = "http://${aws_lb.app_lb.dns_name}"
}
