resource "aws_ecs_cluster" "cluster" {
    name = "${var.basename}-${var.env}"

    tags {
        Name        = "backend-cluster"
        Creator     = "backend"
        Environment = "${var.env}"
        Description = "Cluster for the backend service"
    }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
