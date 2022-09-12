output "instance-sg" {
  description = "SG for instance"
  value       = aws_security_group.resource-sg.id
}
output "instance-sg-name" {
  description = "SG for instance"
  value       = aws_security_group.resource-sg.name
}