variable "bucket_name" {
  type        = string
  nullable    = false
  description = "A globally unique S3 bucket name for the assetstore."
}

variable "upload_origins" {
  type        = list(string)
  nullable    = false
  description = "A list of all CORS origins (including the server) which are allowed to upload files."
}
