output "ec2_ip" {
  value       = aws_eip.server.public_ip
  description = "The public IP address of the server."
}
output "ec2_iam_role_id" {
  value       = aws_iam_role.server.id
  description = "The IAM role ID for the server's instance profile role."
}
