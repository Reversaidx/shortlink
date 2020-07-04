
variable "dynamodb_aws_secret_access_key" {
  description = "Database password"
}
variable "dynamodb_aws_access_key_id" {
  description = "Database password"
}

# variable "aws_secret_access_key" {
#   description = "aws password"
# }
# variable "aws_access_key_id" {
#   description = "aws key id"
# }
variable "shortlink_image" {
  description = "Docker image for shortlink app"
}

variable "listener_arn" {
}
variable "domain" {
}
variable "tableName" {
}
variable "region" {
}