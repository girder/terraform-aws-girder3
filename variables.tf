variable "project_slug" {
  type = string
  description = "A slugified name, used to label AWS resources."
  validation {
    // Ensures that the slug does not start or end with a period or dash
    // Ensures that the overall slug is no longer than 52 characters, which allows this to be used
    // for the assetstore bucket name (the overall bucket name must be less than 63 characters)
    condition     = can(regex("^[a-z0-9]+[a-z0-9.-]{0,50}[a-z0-9]+$", var.project_slug))
    error_message = "The project_slug value may contain only lowercase letters, numbers, periods, and dashes."
  }
}

variable "ec2_instance_type" {
  type = string
  default = "t3.medium"
  description = "The EC2 instance type for the server."
}
variable "ec2_ami" {
  type = string
  default = "ami-0ac80df6eff0e70b5"
  description = "The base AMI ID for the server."
  validation {
    condition     = can(regex("^ami-", var.ec2_ami))
    error_message = "The ec2_ami value must be a valid AMI id, starting with \"ami-\"."
  }
}
variable "ssh_public_key" {
  type = string
  description = "An SSH public key, to be installed on the server."
}

variable "subdomain_name" {
  type = string
  description = "The DNS subdomain name where the server will be available."
}
variable "route53_zone_id" {
  type = string
  description = "The Route 53 zone ID to create a new DNS record within."
}

variable "extra_upload_origins" {
  type = list(string)
  default = []
  description = "A list of extra CORS origins which are allowed to upload files, in addition to the server."
}
