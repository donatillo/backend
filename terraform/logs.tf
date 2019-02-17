resource "aws_cloudwatch_log_group" "backend" {
    name = "backend-logs-${var.env}"

    tags {
        Name        = "backend-logs-${var.env}"
        Creator     = "backend"
        Environment = "${var.env}"
        Description = "Cloudwatch log group for backend"
    }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
