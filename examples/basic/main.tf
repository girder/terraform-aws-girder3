provider "aws" {
  region = "us-east-1"
}

data "aws_route53_zone" "domain" {
  # This must be created by hand in the AWS console
  zone_id = "Z123456789"
}

data "local_file" "ssh_pub" {
  # This must be an existing file on the local filesystem
  filename = "/home/user/.ssh/id_rsa.pub"
}

# This provides a zero-configuration option for assigning names,
# but most projects will want to select a more specific name instead
resource "random_pet" "instance_name" {
  prefix    = "girder"
  length    = 2
  separator = "-"
}

module "girder" {
  source  = "girder/girder/aws"
  version = "0.7.0"

  project_slug    = random_pet.instance_name.id
  route53_zone_id = data.aws_route53_zone.domain.zone_id
  ssh_public_key  = data.local_file.ssh_pub.content
  subdomain_name  = random_pet.instance_name.id
}

output "server_fqdn" {
  value = module.girder.server_fqdn
}
output "assetstore_bucket_name" {
  value = module.girder.assetstore_bucket_name
}
output "smtp_host" {
  value = module.girder.smtp_host
}
output "smtp_port" {
  value = module.girder.smtp_port
}
output "smtp_username" {
  value = module.girder.smtp_username
}
output "smtp_password" {
  value = module.girder.smtp_password
}
