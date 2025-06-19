resource "aws_efs_file_system" "efs" {
  creation_token = "myefs"

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  performance_mode = "generalPurpose"
  throughput_mode = "bursting"
}

resource "aws_efs_mount_target" "mount_target" {
  count = length(var.public_subnets)
  file_system_id = aws_efs_file_system.efs.id
  subnet_id = var.public_subnets[count.index]
  security_groups = [ var.security_groups ]
}