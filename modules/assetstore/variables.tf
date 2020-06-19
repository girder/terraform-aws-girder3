variable "bucket_name" {
  type        = string
  description = "A globally unique S3 bucket name for the assetstore."
}

variable "upload_origins" {
  type        = list(string)
  description = "A list of all CORS origins (including the server) which are allowed to upload files."
}
