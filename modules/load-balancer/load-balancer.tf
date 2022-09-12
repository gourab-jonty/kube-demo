resource "aws_lb" "load-balancer" {
  name                       = "${var.name}-ALB"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.inst-sg
  subnets                    = var.subnet_lb
  enable_deletion_protection = false

}

