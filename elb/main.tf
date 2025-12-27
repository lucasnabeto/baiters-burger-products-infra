resource "aws_lb" "baitersburger_products_alb" {
  name               = "baitersburger-products-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnets
}

resource "aws_lb_listener" "baitersburger_products_alb_listener" {
  load_balancer_arn = aws_lb.baitersburger_products_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.baitersburger_products_alb_tg.arn
  }
}

resource "aws_lb_target_group" "baitersburger_products_alb_tg" {
  name        = "baitersburger-products-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_default
  target_type = "ip"
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_default
}

resource "aws_vpc_security_group_ingress_rule" "alb_http_in" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "alb_all_out" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}