terraform {
  backend "s3" {
    bucket = "jetbrais-terraform-state"
    key    = "dynamodb"
    region = "eu-central-1"
  }
}

