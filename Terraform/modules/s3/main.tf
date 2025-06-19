resource "aws_s3_bucket" "ecs_bucket" {
    bucket = var.bucket_name
    acl = "private"
}

