variable "project_slug" {
  type        = string
  description = "A slugified name, used to label AWS resources."
}

variable "ssh_public_key" {
  type        = string
  description = "An SSH public key, to be installed on the server."
}

variable "ec2_instance_type" {
  type        = string
  default     = "t3.medium"
  description = "The EC2 instance type for the server."
}

variable "ec2_ami" {
  type        = string
  default     = "ami-07df16d0682f1fa59"
  description = "The base AMI ID for the server."
}

variable "ec2_volume_size" {
  type        = number
  default     = 40
  description = "The size, in GB, of the root EBS volume for the server."
}
