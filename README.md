# terraform-aws-girder
A Terraform module to provision Girder infrastructure on AWS.

This provides an EC2 server, S3 assetstore, and outgoing SMTP credentials.

See [full usage documentation at Terraform Registry](https://registry.terraform.io/modules/girder/girder/aws).

## Note on AWS Email Sending
[Every AWS account must explicitly apply to send real emails](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/request-production-access.html),
once per Simple Email Service (SES) region.

Approvals seem to be granted liberally and to take about 24 hours.

## Note on EC2 Server AMIs
A newly launched server will use the latest AMI at the time of launch, but an existing server will
not be replaced when a newer AMI is available.

Likewise, setting or changing the optional variable `ec2_worker_launch_ami_id` will only affect
a newly launched server, but will also not trigger the replacement of an existing server with
a different AMI.

Use [the `-replace` option](https://developer.hashicorp.com/terraform/cli/commands/plan#replace-address)
with the `module.<girder>.module.server.aws_instance.server` target (where
`<girder>` is the local name of this module) to force the replacement of an existing server.
