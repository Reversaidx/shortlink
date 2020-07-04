resource "aws_globalaccelerator_endpoint_group" "shortlink" {
  listener_arn = var.listener_arn
  health_check_port = 80
  health_check_path = "/"
    lifecycle {
    ignore_changes = [health_check_path]
  }
  endpoint_configuration {
    endpoint_id = aws_lb.shortlink.arn
  }

}

