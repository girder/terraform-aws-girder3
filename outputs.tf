output "ec2_fqdn" {
  value = aws_route53_record.server.fqdn
  description = "The fully-qualified domain name of the server."
}

output "smtp_host" {
  value = module.smtp.host
  description = "The hostname for the outgoing SMTP server."
}
output "smtp_port" {
  value = module.smtp.port
  description = "The port for the outgoing SMTP server."
}
output "smtp_username" {
  value = module.smtp.username
  description = "The username for the outgoing SMTP server."
}
output "smtp_password" {
  value = module.smtp.password
  description = "The password for the outgoing SMTP server."
}
