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

resource "aws_security_group" "allow_80" {
    name            = "allow_80"
    description     = "Allow 80 inbound"

    vpc_id          = "${data.aws_vpc.main.id}"
    
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name        = "backend-allow_80"
        Creator     = "backend"
        Description = "Allow port 80 inbound"
    }
}

resource "aws_security_group" "allow_443" {
    name            = "allow_443"
    description     = "Allow 443 inbound"

    vpc_id          = "${data.aws_vpc.main.id}"
    
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name        = "backend-allow_443"
        Creator     = "backend"
        Description = "Allow port 443 inbound"
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
