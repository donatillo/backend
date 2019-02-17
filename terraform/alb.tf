resource "aws_lb" "alb" {
    name                = "backend-alb"
    internal            = false
    load_balancer_type  = "application"
    subnets             = [
        "${data.aws_subnet.public_a.id}",
        "${data.aws_subnet.public_b.id}"
    ]
    security_groups     = [
        "${aws_security_group.allow_80.id}",
        "${aws_security_group.allow_443.id}",
        "${aws_security_group.allow_outbound.id}"
    ]

    enable_deletion_protection = false

    # TODO - logs

    tags {
        Name        = "backend-alb"
        Creator     = "backend"
        Environment = "${var.env}"
        Description = "Backend application load balancer"
    }
}

resource "aws_lb_target_group" "backend-target" {
    name                = "backend-lb-tg"
    port                = 443
    protocol            = "HTTPS"
    target_type         = "ip"
    vpc_id              = "${data.aws_vpc.main.id}"

    depends_on          = [ "aws_lb.alb" ]

    tags {
        Name        = "backend-lb-tg"
        Creator     = "backend"
        Environment = "${var.env}"
        Description = "Target group for the backend"
    }
}

data "aws_acm_certificate" "cert" {
    domain   = "*.${var.domain}"
    statuses = ["ISSUED"]
}

resource "aws_lb_listener" "backend-listener" {
    load_balancer_arn   = "${aws_lb.alb.arn}"
    port                = 443
    protocol            = "HTTPS"
    ssl_policy          = "ELBSecurityPolicy-2016-08"
	certificate_arn     = "${data.aws_acm_certificate.cert.arn}"

    default_action {
        target_group_arn = "${aws_lb_target_group.backend-target.arn}"
        type             = "forward"
    }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
