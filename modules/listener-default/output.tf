output "arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb_listener.default.arn
}