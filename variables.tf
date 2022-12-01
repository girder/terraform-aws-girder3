# Required variables
variable "project_slug" {
  type        = string
  nullable    = false
  description = "A slugified name, used to label AWS resources."
}

variable "route53_zone_id" {
  type        = string
  nullable    = false
  description = "The Route 53 zone ID to create new DNS records within."
}

variable "ssh_public_key" {
  type        = string
  nullable    = false
  description = "An SSH public key, to be installed on the server."
}

variable "subdomain_name" {
  type        = string
  nullable    = false
  description = "The DNS subdomain name where the server will be available."
}

# Optional variables
variable "assetstore_bucket_name" {
  type        = string
  nullable    = true
  default     = null # Effective default is set internally
  description = "The globally unique S3 bucket name of the assetstore."
}

variable "ec2_instance_type" {
  type        = string
  nullable    = false
  default     = "t3.medium"
  description = "The EC2 instance type for the server."
}

variable "ec2_volume_size" {
  type        = number
  nullable    = false
  default     = 40
  description = "The size, in GB, of the root EBS volume for the server."
}

variable "extra_upload_origins" {
  type        = list(string)
  nullable    = false
  default     = []
  description = "A list of extra CORS origins which are allowed to upload files, in addition to the server."
}
