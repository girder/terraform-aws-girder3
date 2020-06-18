output "ec2_fqdn" {
  value = aws_route53_record.server.fqdn
  description = "The fully-qualified domain name of the server."
}
