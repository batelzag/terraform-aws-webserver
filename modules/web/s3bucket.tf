# Creates a S3 bucket for uploading nginx access logs
resource "aws_s3_bucket" "s3-bucket" {
   bucket = "${var.bucket_name}"
   acl    = "private"

   tags = {
     Name        = "${var.bucket_name}"
   }
}