# parse YAML file
data "template_file" "yaml" {
    template    = "${file("../api.yaml")}"
    vars {
        domain  = "privateapi-${var.env}.${var.domain}"
		port    = 5000
    }
}

# REST API
resource "aws_api_gateway_rest_api" "api" {
    name        = "giveandtake-backend-${var.env}"
    description = "Give and Take Application"
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

# client certificate
resource "aws_api_gateway_client_certificate" "client_certificate" {
	description = "Certificate for backend running at ${var.subdomain}.${var.domain}"
}

# API deployment
resource "aws_api_gateway_deployment" "api_deploy" {
    depends_on = [ "aws_api_gateway_rest_api.api" ]

    rest_api_id = "${aws_api_gateway_rest_api.api.id}"
    stage_name  = ""
}

resource "aws_api_gateway_stage" "test" {
    stage_name            = "${var.env}"
    rest_api_id           = "${aws_api_gateway_rest_api.api.id}"
    deployment_id         = "${aws_api_gateway_deployment.api_deploy.id}"
	client_certificate_id = "${aws_api_gateway_client_certificate.client_certificate.id}"
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
