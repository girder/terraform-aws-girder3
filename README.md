# terraform-aws-girder3
A Terraform module to provision Girder3 infrastructure on AWS.

This provides an EC2 machine, S3 assetstore, and outgoing SMTP credentials.

See [full usage documentation at Terraform Registry](https://registry.terraform.io/modules/girder/girder3/aws).

## Note on AWS Email Sending
[Every AWS account must explicitly apply to send real emails](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/request-production-access.html),
once per Simple Email Service (SES) region.

Approvals seem to be granted liberally and to take about 24 hours.
