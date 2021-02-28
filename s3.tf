resource "aws_s3_bucket" "flashcard_bucket" {
  #checkov:skip=CKV_AWS_18:Not needed
  #checkov:skip=CKV_AWS_52:Not needed
  bucket = "${var.bucket_name}-${var.stage}"
  acl    = "private"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
    }
  }
}

}