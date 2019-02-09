resource "aws_ecr_repository" "repository" {
    name = "${var.env}.give-and-take"
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
