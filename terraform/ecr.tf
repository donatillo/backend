resource "aws_ecr_repository" "repository" {
    name = "${var.basename}-${var.env}"
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
