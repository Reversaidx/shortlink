
variable "dynamodb_aws_secret_access_key" {
  description = "Database key"
}
variable "dynamodb_aws_access_key_id" {
  description = "Database user id"
}
variable "shortlink_image" {
  description = "Docker image for shortlink app"
  default = "reversaidx/jetbrains:v0.4"
}
variable "aws_access_key_id" {
  description = "AWS user key"
}
variable "aws_secret_access_key" {
  description = "AWS secret access key"
}
variable "region" {
  description = "default region for resources"
  default = "eu-west-3"
}
variable "tableName" {
  description = "DynamoDb table name"
  default = "shortlink"
}