terraform {
  backend "s3" {
    bucket = "jetbrais-terraform-state"
    key    = "global"
    region = "eu-central-1"
  }
}

