data "aws_vpc" "main" {
    tags {
        Name = "${var.basename}-vpc-${var.env}"
    }
}

data "aws_subnet" "public" {
    tags {
        Name = "${var.basename}-subnet-public-${var.env}"
    }
}

resource "aws_security_group" "allow_8080" {
    name            = "allow_8080"
    description     = "Allow 8080 inbound"

    vpc_id          = "${data.aws_vpc.main.id}"
    
    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name        = "backend-allow_8080"
        Creator     = "backend"
        Description = "Allow port 8080 inbound"
    }
}

resource "aws_security_group" "allow_outbound" {
    name            = "allow_all_outbound"
    description     = "Allow all traffic outbound"

    vpc_id          = "${data.aws_vpc.main.id}"
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name        = "backend-allow_outbound"
        Creator     = "backend"
        Description = "Allow all traffic outbound"
    }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
