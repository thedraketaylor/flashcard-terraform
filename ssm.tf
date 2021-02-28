resource "aws_ssm_parameter" "dynamodb_stream" {
  name  = "flashcards_dynamodb_stream_arn"
  type  = "String"
  value = aws_dynamodb_table.flashcards_table.stream_arn
  depends_on = [ aws_dynamodb_table.flashcards_table ]
}