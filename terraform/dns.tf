data "aws_route53_zone" "primary" {
    name                = "${var.domain}"
    private_zone        = false
}

#
# private API
#
resource "aws_route53_record" "private-ipv4" {
    zone_id         = "${data.aws_route53_zone.primary.zone_id}"
    name            = "privateapi-${var.env}.${var.domain}"
    type            = "A"
    alias {
        name        = "${aws_lb.alb.dns_name}"
        zone_id     = "${aws_lb.alb.zone_id}"
        evaluate_target_health = true
    }
}

resource "aws_route53_record" "private-ipv6" {
    zone_id         = "${data.aws_route53_zone.primary.zone_id}"
    name            = "privateapi-${var.env}.${var.domain}"
    type            = "AAAA"
    alias {
        name        = "${aws_lb.alb.dns_name}"
        zone_id     = "${aws_lb.alb.zone_id}"
        evaluate_target_health = true
    }
} 

#
# external API
#

resource "aws_route53_record" "public-ipv4" {
    zone_id         = "${data.aws_route53_zone.primary.zone_id}"
    name            = "${var.subdomain}.${var.domain}"
    type            = "A"
    alias {
        name        = "${aws_api_gateway_domain_name.api_domain.cloudfront_domain_name}"
        zone_id     = "${aws_api_gateway_domain_name.api_domain.cloudfront_zone_id}"
        evaluate_target_health = true
    }
}

resource "aws_route53_record" "public-ipv6" {
    zone_id         = "${data.aws_route53_zone.primary.zone_id}"
    name            = "${var.subdomain}.${var.domain}"
    type            = "AAAA"
    alias {
        name        = "${aws_api_gateway_domain_name.api_domain.cloudfront_domain_name}"
        zone_id     = "${aws_api_gateway_domain_name.api_domain.cloudfront_zone_id}"
        evaluate_target_health = true
    }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
