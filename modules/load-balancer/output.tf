output "arn" {
  description = "The ARN of the load balancer."
  value       = aws_lb.load-balancer.arn
}

output "dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.load-balancer.dns_name
}