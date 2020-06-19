variable "project_slug" {
  type        = string
  description = "A slugified name, used to label AWS resources."
}

variable "ec2_instance_type" {
  type        = string
  default     = "t3.medium"
  description = "The EC2 instance type for the server."
}
variable "ec2_ami" {
  type        = string
  default     = "ami-0ac80df6eff0e70b5"
  description = "The base AMI ID for the server."
}
variable "ssh_public_key" {
  type        = string
  description = "An SSH public key, to be installed on the server."
}

variable "subdomain_name" {
  type        = string
  description = "The DNS subdomain name where the server will be available."
}
variable "route53_zone_id" {
  type        = string
  description = "The Route 53 zone ID to create new DNS records within."
}

variable "extra_upload_origins" {
  type        = list(string)
  default     = []
  description = "A list of extra CORS origins which are allowed to upload files, in addition to the server."
}
