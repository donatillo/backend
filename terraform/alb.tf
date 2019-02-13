resource "aws_lb" "alb" {
    name                = "backend-alb"
    internal            = false
    load_balancer_type  = "application"
    subnets             = [
        "${data.aws_subnet.public_a.id}",
        "${data.aws_subnet.public_b.id}"
    ]
    security_groups     = [
        "${aws_security_group.allow_8080.id}",
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
    port                = 8080
    protocol            = "HTTP"
    target_type         = "ip"
    vpc_id              = "${data.aws_vpc.main.id}"

    depends_on          = [ "aws_lb.alb" ]
}

resource "aws_lb_listener" "backend-listener" {
    load_balancer_arn   = "${aws_lb.alb}"
    port                = 8080
    protocol            = "HTTP"

    default_action {
        target_group_arn = "${aws_lb_target_group.backend-target.arn}"
        type             = "forward"
    }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
