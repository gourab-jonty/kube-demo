output "iam-role" {
  description = "IAM Role Name"
  value       = aws_iam_role.iam_role.name
}
output "instane-profile" {
  value = aws_iam_instance_profile.inst_profile.name
}
output "iam-role-arn" {
  description = "IAM Role Name"
  value       = aws_iam_role.iam_role.arn
}