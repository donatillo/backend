data "aws_route53_zone" "primary" {
    name                = "${var.domain}"
    private_zone        = false
}

// IPv4
resource "aws_route53_record" "ipv4" {
    zone_id         = "${data.aws_route53_zone.primary.zone_id}"
    name            = "internalapi-${var.env}.${var.domain}"
    type            = "A"
    alias {
        name        = "${aws_lb.alb.dns_name}"
        zone_id     = "${aws_lb.alb.zone_id}"
        evaluate_target_health = true
    }
}

// IPv6
resource "aws_route53_record" "ipv6" {
    zone_id         = "${data.aws_route53_zone.primary.zone_id}"
    name            = "internalapi-${var.env}.${var.domain}"
    type            = "AAAA"
    alias {
        name        = "${aws_lb.alb.dns_name}"
        zone_id     = "${aws_lb.alb.zone_id}"
        evaluate_target_health = true
    }
} 

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
