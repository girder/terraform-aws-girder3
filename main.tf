locals {
  # Variable defaults cannot be directly based on other variables
  storage_bucket_name = var.assetstore_bucket_name != "" ? var.assetstore_bucket_name : "${var.project_slug}-assetstore"
}

module "server" {
  source = "./modules/server"

  project_slug      = var.project_slug
  ec2_instance_type = var.ec2_instance_type
  ec2_ami           = var.ec2_ami
  ec2_volume_size   = var.ec2_volume_size
  ssh_public_key    = var.ssh_public_key
}
resource "aws_route53_record" "server" {
  zone_id = var.route53_zone_id
  name    = var.subdomain_name
  type    = "A"
  ttl     = "300"
  records = [module.server.ec2_ip]
}

module "assetstore" {
  source = "./modules/assetstore"

  bucket_name = local.storage_bucket_name
  upload_origins = concat(
    ["https://${aws_route53_record.server.fqdn}"],
    var.extra_upload_origins
  )
}

resource "aws_iam_role_policy" "server_assetstore" {
  name   = "${var.project_slug}-assetstore-access"
  role   = module.server.ec2_iam_role_id
  policy = data.aws_iam_policy_document.server_assetstore.json
}
data "aws_iam_policy_document" "server_assetstore" {
  statement {
    actions = [
      "s3:*",
    ]
    resources = [
      module.assetstore.bucket_arn,
      "${module.assetstore.bucket_arn}/*",
    ]
  }
}

module "smtp" {
  source = "./modules/smtp"

  project_slug    = var.project_slug
  route53_zone_id = var.route53_zone_id
  fqdn            = aws_route53_record.server.fqdn
}
