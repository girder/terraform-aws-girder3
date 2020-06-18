variable "project_slug" {
  type = string
  description = "A slugified name, used to label AWS resources."
}

variable "ec2_instance_type" {
  type = string
  description = "The EC2 instance type for the server."
}
variable "ec2_ami" {
  type = string
  description = "The base AMI ID for the server."
}
variable "ssh_public_key" {
  type = string
  description = "An SSH public key, to be installed on the server."
}
