resource "aws_eip" "backend_eip" {
    instance 		= "${aws_lb.alb.id}"
    vpc             = true

    tags {
        Name        = "backend-eip"
        Creator     = "backend"
        Environment = "${var.env}"
        Description = "Main backend instance elastic IP"
    }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
