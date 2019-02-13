resource "aws_ecs_service" "backend" {
    name            = "backend-service"
    cluster         = "${aws_ecs_cluster.cluster.id}"
    task_definition = "${aws_ecs_task_definition.service.arn}"
    desired_count   = 2
    launch_type     = "FARGATE"

    network_configuration {
        subnets          = [
            "${data.aws_subnet.public_a.id}",
            "${data.aws_subnet.public_b.id}"
        ]
        security_groups  = [
            "${aws_security_group.allow_8080.id}",
            "${aws_security_group.allow_outbound.id}"
        ]
        assign_public_ip = true
    }

    load_balancer {
        target_group_arn = "${aws_lb_target_group.backend-target.arn}"
        container_name   = "backend-app"
        container_port   = 8080
    }

    depends_on = [ "aws_lb_listener.backend-listener" ]

    tags {
        Name        = "backend-service"
        Creator     = "backend"
        Environment = "${var.env}"
        Description = "Backend service"
    }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
