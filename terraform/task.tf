resource "aws_ecs_task_definition" "service" {
    family      = "backend-app"
    container_definitions = "${file("task.json")}"

    tags {
        Name        = "backend-taskdefs"
        Creator     = "backend"
        Environment = "${var.env}"
        Description = "Task definition for backend app."
    }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
