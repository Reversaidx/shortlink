resource "aws_globalaccelerator_accelerator" "shortlink" {
  name            = "shortlink"
  ip_address_type = "IPV4"
  enabled         = true

}
resource "aws_globalaccelerator_listener" "shortlink" {
  accelerator_arn = "${aws_globalaccelerator_accelerator.shortlink.id}"
  client_affinity = "SOURCE_IP"
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }
}

module "dynamodb" {
  source                = "../../modules/dynamodb"
  region                = "eu-west-3"
  replica_zones         = ["us-west-2"]
  tableName                      = "shortlink"
}

module "ecs-eu-west-3" {
  source                         = "../../modules/ecs"
  region                         = "eu-west-3"
  tableName                      = "shortlink"
  domain= aws_globalaccelerator_accelerator.shortlink.dns_name
  listener_arn                   = aws_globalaccelerator_listener.shortlink.id
  shortlink_image                = var.shortlink_image
  dynamodb_aws_access_key_id     = var.dynamodb_aws_access_key_id
  dynamodb_aws_secret_access_key = var.dynamodb_aws_secret_access_key
}
module "ecs-us-west-2" {
  source                         = "../../modules/ecs"
  region                         = "us-west-2"
  tableName                      = "shortlink"
  domain      = aws_globalaccelerator_accelerator.shortlink.dns_name
  listener_arn                   = aws_globalaccelerator_listener.shortlink.id
  shortlink_image                = var.shortlink_image
  dynamodb_aws_access_key_id     = var.dynamodb_aws_access_key_id
  dynamodb_aws_secret_access_key = var.dynamodb_aws_secret_access_key
}

output "dns_name" {
  value = aws_globalaccelerator_accelerator.shortlink.dns_name
}


