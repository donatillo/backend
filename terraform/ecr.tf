resource "aws_ecr_repository" "repository" {
    name = "${var.env}.${var.appname}"
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
