provider "aws" {
  region = "us-east-1"
  # Must set AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY envvars
}

data "aws_route53_zone" "this" {
  # This must be created by hand in the AWS console
  name = "rootdomain.test"
}

data "local_file" "ssh_public_key" {
  # This must be an existing file on the local filesystem
  filename = "/home/user/.ssh/id_rsa.pub"
}

# This provides a zero-configuration option for assigning names,
# but most projects will want to select a more specific name instead
resource "random_pet" "instance_name" {
  prefix    = "girder3"
  length    = 2
  separator = "-"
}

module "girder3" {
  source = "girder/girder3/aws"

  project_slug    = random_pet.instance_name.id
  route53_zone_id = data.aws_route53_zone.this.zone_id
  ssh_public_key  = data.local_file.ssh_public_key.content
  subdomain_name  = random_pet.instance_name.id
}

output "server_fqdn" {
  value = module.girder3.server_fqdn
}
output "assetstore_bucket_name" {
  value = module.girder3.assetstore_bucket_name
}
output "smtp_host" {
  value = module.girder3.smtp_host
}
output "smtp_port" {
  value = module.girder3.smtp_port
}
output "smtp_username" {
  value = module.girder3.smtp_username
}
output "smtp_password" {
  value = module.girder3.smtp_password
}
