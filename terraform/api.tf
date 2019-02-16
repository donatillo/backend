# parse YAML file
data "template_file" "yaml" {
    template    = "${file("../api.yaml")}"
    vars {
        domain  = "internalapi-${var.env}.${var.domain}"
		port    = 5000
    }
}

# REST API
resource "aws_api_gateway_rest_api" "api" {
    name        = "giveandtake-backend-${var.env}"
    description = "Give and Take Application"
    body        = "${data.template_file.yaml.rendered}"
}

# API deployment
resource "aws_api_gateway_deployment" "api_deploy" {
    depends_on = [ "aws_api_gateway_rest_api.api" ]

    rest_api_id = "${aws_api_gateway_rest_api.api.id}"
    stage_name  = "${var.env}"
}

# API custom domain name
data "aws_acm_certificate" "cert" {
    domain   = "*.${var.domain}"
    statuses = ["ISSUED"]
}

resource "aws_api_gateway_domain_name" "api_domain" {
	certificate_arn     = "${data.aws_acm_certificate.cert.arn}"
	domain_name         = "${var.subdomain}.${var.domain}"
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
