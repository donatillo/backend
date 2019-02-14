resource "aws_api_gateway_rest_api" "api" {
    name        = "giveandtake-backend"
    description = "Give and Take Application"
}

resource "aws_api_gateway_resource" "proxy" {
    rest_api_id = "${aws_api_gateway_rest_api.api.id}"
    parent_id   = "${aws_api_gateway_rest_api.api.root_resource_id}"
    path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
    rest_api_id     = "${aws_api_gateway_rest_api.api.id}"
    resource_id     = "${aws_api_gateway_resource.proxy.id}"
    http_method     = "ANY"
    authorization   = "NONE"
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
