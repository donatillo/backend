resource "aws_ecs_task_definition" "service" {
    family          = "backend-app"
    network_mode    = "awsvpc"
	cpu             = 256 
	memory          = 512
    execution_role_arn = "arn:aws:iam::324139215624:role/ecsTaskExecutionRole"
    container_definitions = "${file("task.json")}"

    tags {
        Name        = "backend-taskdefs"
        Creator     = "backend"
        Environment = "${var.env}"
        Description = "Task definition for backend app."
    }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
