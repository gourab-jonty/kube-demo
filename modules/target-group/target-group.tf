resource "aws_alb_target_group" "alb_target_group" {
  name     = "${var.name}-TG"
  port     = var.port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
  }
  stickiness {
    enabled = var.stickiness
    type    = "lb_cookie"
  }
}
resource "aws_lb_target_group_attachment" "target_attach" {
  count            = var.instance_count
  target_group_arn = aws_alb_target_group.alb_target_group.arn
  target_id        = element(var.instance-id, count.index)
  port             = 80
}

