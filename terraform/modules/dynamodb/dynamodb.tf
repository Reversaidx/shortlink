resource "aws_dynamodb_table" "shortlink" {
  name             = var.tableName
  hash_key         = "id"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "id"
    type = "S"
  }

  dynamic "replica"{
    for_each = toset(var.replica_zones)
    content {
    region_name = replica.value
    }
  }

}

