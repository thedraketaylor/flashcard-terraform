data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
variable "bucket_name" {
  type = string
}

variable "region" {
    type = string
}

variable "stage" {
    type = string
}

variable "dynamodb_table" {
    type = map(object( {
        name = string
        RCU = number
        WCU = number
    }))
}