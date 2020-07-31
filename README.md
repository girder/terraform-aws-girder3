# terraform-aws-girder
A Terraform module to provision Girder infrastructure on AWS.

This provides an EC2 machine, S3 assetstore, and outgoing SMTP credentials.

## Note on AWS Email Sending
[Every AWS account must explicitly apply to send real emails](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/request-production-access.html),
once per Simple Email Service (SES) region.

Approvals seem to be granted liberally and to take about 24 hours.
