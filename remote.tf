data "terraform_remote_state" "default" {
  backend = "s3"

  workspace = "dev"

  config = {
    bucket = "drakeworld-state"
    key    = "flashcards"
    region = var.region
  }
}