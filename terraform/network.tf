data "aws_vpc" "main" {
    tags {
        Name = "${var.basename}-vpc-${var.env}"
    }
}

data "aws_subnet" "public_a" {
    tags {
        Name = "${var.basename}-subnet-public-${var.env}-a"
    }
}

data "aws_subnet" "public_b" {
    tags {
        Name = "${var.basename}-subnet-public-${var.env}-b"
    }
}

resource "aws_security_group" "allow_5000" {
    name            = "allow_5000"
    description     = "Allow 5000 inbound"

    vpc_id          = "${data.aws_vpc.main.id}"
    
    ingress {
        from_port   = 5000
        to_port     = 5000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name        = "backend-allow_5000"
        Creator     = "backend"
        Description = "Allow port 5000 inbound"
    }
}

resource "aws_security_group" "allow_outbound" {   # this is needed for the service to go to ECR
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
