resource "aws_instance" "ecs_instance" {
    ami = var.ami_id
    count = var.instance_count
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.public_subnets[count.index]
    security_groups = [var.security_groups]
    iam_instance_profile = var.iam_instance_profile

    user_data = file("${path.module}/ecs.sh")
    
    tags = {
      Name = "${var.env}-ecs-instance"
    }
}