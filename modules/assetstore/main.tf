resource "aws_s3_bucket" "assetstore" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "assetstore" {
  bucket = aws_s3_bucket.assetstore.id
  acl    = "private"
}

resource "aws_s3_bucket_cors_configuration" "assetstore" {
  bucket = aws_s3_bucket.assetstore.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["POST", "PUT"]
    allowed_origins = var.upload_origins
    expose_headers = [
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
    expose_headers = [
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

resource "aws_s3_bucket_lifecycle_configuration" "assetstore" {
  bucket = aws_s3_bucket.assetstore.id

  rule {
    id     = "abort-incomplete-multipart-upload"
    status = "Enabled"
    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "assetstore" {
  bucket = aws_s3_bucket.assetstore.id

  // Encrypt with an Amazon-managed key
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_policy" "assetstore" {
  bucket = aws_s3_bucket.assetstore.id
  policy = data.aws_iam_policy_document.assetstore.json
}

data "aws_iam_policy_document" "assetstore" {
  statement {
    sid    = "DenyIncorrectEncryptionHeader"
    effect = "Deny"
    principals {
      identifiers = ["*"]
      type        = "*"
    }
    resources = [
      # To prevent a circular reference, can't use "aws_s3_bucket.assetstore.arn" here
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
    actions = ["s3:PutObject"]

    # Both conditions must pass to trigger a deny
    condition {
      # If the header exists
      # Missing headers will cause the default encryption to be applied
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["false"]
    }
    condition {
      # If the header isn't "AES256"
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"
      values   = ["AES256"]
    }
  }
}

resource "aws_s3_bucket_public_access_block" "assetstore" {
  bucket = aws_s3_bucket.assetstore.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  # restrict_public_buckets also blocks cross-account access to the bucket
  restrict_public_buckets = true
}
