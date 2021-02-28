resource "aws_sqs_queue" "terraform_queue" {
  #checkov:skip=CKV_AWS_26:Not needed
  #checkov:skip=CKV_AWS_27:Not needed
  name                      = "drakeworld-flashcards-${var.stage}"
  message_retention_seconds = 345600
  receive_wait_time_seconds = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = 4
  })
  depends_on=[aws_sqs_queue.dlq]
}


resource "aws_sqs_queue" "dlq" {
  #checkov:skip=CKV_AWS_26:Not needed
  #checkov:skip=CKV_AWS_27:Not needed
  name                      = "drakeworld-flashcards-dlq-${var.stage}"
  message_retention_seconds = 345600
  receive_wait_time_seconds = 10
}