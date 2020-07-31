output "server_fqdn" {
  value       = aws_route53_record.server.fqdn
  description = "The fully-qualified domain name of the server."
}

output "assetstore_bucket_name" {
  value = module.assetstore.bucket_name
  description = "The S3 bucket name for the assetstore."
}

output "smtp_host" {
  value       = module.smtp.host
  description = "The hostname for the outgoing SMTP server."
}
output "smtp_port" {
  value       = module.smtp.port
  description = "The port for the outgoing SMTP server."
}
output "smtp_username" {
  value       = module.smtp.username
  description = "The username for the outgoing SMTP server."
}
output "smtp_password" {
  value       = module.smtp.password
  sensitive = true
  description = "The password for the outgoing SMTP server."
}
