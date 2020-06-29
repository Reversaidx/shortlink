locals {
  env = "${terraform.workspace}"
  regions = {
    "default" = "eu-west-3"
    "ew3"     = "eu-west-3"
    "uw2"     = "us-west-2"
  }
  REGION = "${lookup(local.regions, local.env)}"
}
variable "REGION" {
  default = "eu-west-3"
}
variable "aws_access_key_id" {
  description = "AWS access key"
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
}