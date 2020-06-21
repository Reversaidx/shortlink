resource "aws_dynamodb_table" "shortlink" {
  name             = "shortlink"
  hash_key         = "id"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "id"
    type = "S"
  }

  replica {
    region_name = "eu-west-3"
  }

  replica {
    region_name = "us-west-2"
  }
}