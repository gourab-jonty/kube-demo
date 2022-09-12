output "alb-sg_id" {
  description = "SG for instance"
  value       = aws_security_group.alb-sg.id
}
output "alb-sg_name" {
  description = "SG for instance"
  value       = aws_security_group.alb-sg.name
}

