/* output "id" {
  description = "The ID of the instance"
  value = try(
    aws_instance.lab_server[0].id,
    aws_instance.ignore_ami[0].id,
    aws_spot_instance_request.lab_server[0].id,
    null,
  )
}

output "arn" {
  description = "The ARN of the instance"
  value = try(
    aws_instance.lab_server[0].arn,
    aws_instance.ignore_ami[0].arn,
    aws_spot_instance_request.lab_server[0].arn,
    null,
  )
}

output "outpost_arn" {
  description = "The ARN of the Outpost the instance is assigned to"
  value = try(
    aws_instance.lab_server[0].outpost_arn,
    aws_instance.ignore_ami[0].outpost_arn,
    aws_spot_instance_request.lab_server[0].outpost_arn,
    null,
  )
}

output "primary_network_interface_id" {
  description = "The ID of the instance's primary network interface"
  value = try(
    aws_instance.lab_server[0].primary_network_interface_id,
    aws_instance.ignore_ami[0].primary_network_interface_id,
    aws_spot_instance_request.lab_server[0].primary_network_interface_id,
    null,
  )
}

output "private_ip" {
  description = "The private IP address assigned to the instance"
  value = try(
    aws_instance.lab_server[0].private_ip,
    aws_instance.ignore_ami[0].private_ip,
    aws_spot_instance_request.lab_server[0].private_ip,
    null,
  )
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block"
  value = try(
    aws_instance.lab_server[0].tags_all,
    aws_instance.ignore_ami[0].tags_all,
    aws_spot_instance_request.lab_server[0].tags_all,
    {},
  )
}

output "ami" {
  description = "AMI ID that was used to create the instance"
  value = try(
    aws_instance.lab_server[0].ami,
    aws_instance.ignore_ami[0].ami,
    aws_spot_instance_request.lab_server[0].ami,
    null,
  )
}

################################################################################
# Block Devices
################################################################################
output "root_block_device" {
  description = "Root block device information"
  value       = try(aws_instance.lab_server[0].root_block_device, null)
}

output "ebs_block_device" {
  description = "EBS block device information"
  value       = try(aws_instance.lab_server[0].ebs_block_device, null)
}

output "ephemeral_block_device" {
  description = "Ephemeral block device information"
  value       = try(aws_instance.lab_server[0].ephemeral_block_device, null)
} */