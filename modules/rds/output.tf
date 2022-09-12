output "db_endpoint" {
  value     = aws_db_instance.sqlserver.endpoint
  sensitive = false
}
