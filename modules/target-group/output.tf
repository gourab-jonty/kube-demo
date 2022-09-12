output "arn" {
  description = "The ARN of the load balancer."
  value       = aws_alb_target_group.alb_target_group.arn
}