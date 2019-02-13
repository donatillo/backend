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

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
