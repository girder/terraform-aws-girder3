output "bucket_name" {
  value = aws_s3_bucket.assetstore.id
  description = "The S3 bucket name for the assetstore."
}
output "bucket_arn" {
  value = aws_s3_bucket.assetstore.arn
  description = "The S3 bucket ARN for the assetstore."
}
