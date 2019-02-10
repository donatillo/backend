resource "aws_ecs_cluster" "cluster" {
    name = "${var.appname}-${var.env}"
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
