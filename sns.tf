resource "aws_sns_topic" "num_cards" {
  #checkov:skip=CKV_AWS_26:Not needed
  name = "num_cards"
  display_name = "Number of Cards"
}