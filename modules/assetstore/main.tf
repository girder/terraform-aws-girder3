resource "aws_s3_bucket" "assetstore" {
  bucket = var.bucket_name
  acl    = "private"
  policy = data.aws_iam_policy_document.assetstore.json

  // Encrypt with an Amazon-managed key
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["POST", "PUT"]
    allowed_origins = var.upload_origins
    expose_headers  = [
      # https://docs.aws.amazon.com/AmazonS3/latest/API/RESTCommonResponseHeaders.html
      "Content-Length",
      "Connection",
      "Date",
      "ETag",
      "Server",
      "x-amz-delete-marker",
      "x-amz-version-id"
      # Exclude "x-amz-request-id" and "x-amz-id-2", as they are only for debugging
    ]
    max_age_seconds = 600
  }
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = [
      # Since this is redirected to by Girder (which may be fetched itself via CORS), the Origin
      # header may not be passed to S3
      # See https://stackoverflow.com/a/30217089
      "*"
    ]
    expose_headers  = [
      # https://docs.aws.amazon.com/AmazonS3/latest/API/RESTCommonResponseHeaders.html
      "Content-Length",
      "Content-Type",
      "Connection",
      "Date",
      "ETag"
    ]
    max_age_seconds = 600
  }
}

data "aws_iam_policy_document" "assetstore" {
  statement {
    sid = "DenyIncorrectEncryptionHeader"
    effect = "Deny"
    principals {
      identifiers = ["*"]
      type = "*"
    }
    resources = [
      # To prevent a circular reference, can't use "aws_s3_bucket.assetstore.arn" here
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
    actions = ["s3:PutObject"]
    condition {
      # If the header doesn't exist, this will still pass
      test = "StringNotEqualsIfExists"
      variable = "s3:x-amz-server-side-encryption"
      values = ["AES256"]
    }
  }
}
