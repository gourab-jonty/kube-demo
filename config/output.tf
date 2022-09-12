output "Data_Module" {
  value = module.Data
}
output "EC2-SG_Module" {
  value = module.Resource-SG
}
output "ALB-SG_Module" {
  value = module.ALB-SG
}
output "IAM-ROLE_Module" {
  value = module.EC2-Role
}
output "Private-Subnet" {
  value = module.Network
}
output "RDS" {
  value = module.RDS
}