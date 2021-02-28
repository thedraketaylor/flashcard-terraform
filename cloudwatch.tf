resource "aws_cloudwatch_event_rule" "getnewcards" {
  name        = "GetNewCards"
  description = "Check for new cards in SQS. If any exist, migrate them to DynamoDB"
  schedule_expression = "cron(0 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "trigger_target" {
  rule      = aws_cloudwatch_event_rule.getnewcards.name
  arn       = "arn:aws:lambda:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:function:getqueuenumbers-dev-get_number_messages"
}

resource "aws_cloudwatch_event_rule" "populatejson" {
  name        = "PopulateJson"
  description = "Populates the cards json files from DynamoDB"
  schedule_expression = "cron(30 * * * ? *)"
}

resource "aws_cloudwatch_event_target" "populate_trigger" {
  rule      = aws_cloudwatch_event_rule.populatejson.name
  arn       = "arn:aws:lambda:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:function:populate-exam-json-files-dev-populate"
}


resource "aws_cloudwatch_metric_alarm" "num_cards_in_queue" {
  alarm_name                = "Number of Cards in Queue"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateNumberOfMessagesVisible"
  namespace                 = "AWS/SQS"
  period                    = "60"
  alarm_actions             = [aws_sns_topic.num_cards.arn]
  treat_missing_data        = "notBreaching"
  statistic                 = "Minimum"
  threshold                 = "5"
  alarm_description         = "This metric monitors number of messages in the SQS Queue"

  depends_on = [ aws_sns_topic.num_cards ]
}


