resource "aws_ecr_repository" "repository" {
    name = "${var.basename}-${var.env}"

    tags {
        Name        = "backend-repository"
        Creator     = "backend"
        Environment = "${var.env}"
        Description = "Repository containing docker images for the backend."
    }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
