resource "aws_api_gateway_rest_api" "api" {
    name        = "giveandtake-backend"
    description = "Give and Take Application"
    body        = "${file("../api.yaml")}"

    # TODO - add tags
}

resource "aws_api_gateway_deployment" "api_deploy" {
    depends_on = [ "aws_api_gateway_rest_api.api" ]

    rest_api_id = "${aws_api_gateway_rest_api.api.id}"
    stage_name  = "${var.env}"

    # TODO - add tags
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
