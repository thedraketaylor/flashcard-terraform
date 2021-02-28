resource "aws_dynamodb_table" "flashcards_table" {
  #checkov:skip=CKV_AWS_28::Not needed
  name           = "drakeworld-flashcards-${var.stage}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "PK"
  range_key      = "SK"
  stream_enabled   = true
  stream_view_type = "KEYS_ONLY"
  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "S"
  }

}