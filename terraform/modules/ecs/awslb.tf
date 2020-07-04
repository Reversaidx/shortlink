resource "aws_lb" "shortlink" {
  name               = "shortlink-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_8080.id, aws_security_group.allow_80.id]
  subnets            = ["${aws_subnet.shortlink_public_sn_01.id}", "${aws_subnet.shortlink_public_sn_02.id}"]
  tags = {
    Environment = "production"
  }
}

resource "aws_alb_target_group" "jetbrains_app_target_group" {
  name                 = "jetbrains-app-target-group"
  port                 = 8080
  protocol             = "HTTP"
  vpc_id               = aws_vpc.jetbrains.id
  deregistration_delay = "10"
  target_type          = "ip"

  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "6"
    interval            = "30"
    matcher             = "200,301,302"
    path                = "/"
    protocol            = "HTTP"
    timeout             = "5"
  }

  stickiness {
    type = "lb_cookie"
  }

}
resource "aws_alb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.shortlink.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.jetbrains_app_target_group.arn
    type             = "forward"
  }
  depends_on = [aws_alb_target_group.jetbrains_app_target_group]
}