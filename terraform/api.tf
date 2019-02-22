# parse YAML file
data "template_file" "yaml" {
    template    = "${file("../api.yaml")}"
    vars {
        env     = "${var.env}"
        domain  = "privateapi-${var.env}.${var.domain}"
		port    = 443
    }
}

# REST API
resource "aws_api_gateway_rest_api" "api" {
    name        = "${var.basename}-backend-${var.env}"
    description = "${var.basename} application - ${var.env}"
    body        = "${data.template_file.yaml.rendered}"
}

# API custom domain name
resource "aws_api_gateway_domain_name" "api_domain" {
	certificate_arn     = "${data.aws_acm_certificate.cert.arn}"
	domain_name         = "${var.subdomain}.${var.domain}"
}

# API base mapping
resource "aws_api_gateway_base_path_mapping" "mapping" {
	api_id      = "${aws_api_gateway_rest_api.api.id}"
	stage_name  = "${aws_api_gateway_deployment.api_deploy.stage_name}"
	domain_name = "${aws_api_gateway_domain_name.api_domain.domain_name}"
}

# API deployment
resource "aws_api_gateway_deployment" "api_deploy" {
    depends_on = [ "aws_api_gateway_rest_api.api" ]

    rest_api_id = "${aws_api_gateway_rest_api.api.id}"
    stage_name  = "devl"
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
