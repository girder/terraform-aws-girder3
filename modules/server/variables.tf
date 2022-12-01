variable "project_slug" {
  type        = string
  nullable    = true
  description = "A slugified name, used to label AWS resources."
}

variable "ssh_public_key" {
  type        = string
  nullable    = true
  description = "An SSH public key, to be installed on the server."
}

variable "ec2_instance_type" {
  type        = string
  nullable    = true
  default     = "t3.medium"
  description = "The EC2 instance type for the server."
}

variable "ec2_volume_size" {
  type        = number
  nullable    = true
  default     = 40
  description = "The size, in GB, of the root EBS volume for the server."
}
