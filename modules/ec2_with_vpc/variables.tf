variable "instance_name" {
  description = "Value of the EC2 instance's Name tag."
  type        = string
  default     = "benjamin-terraform"
}

variable "instance_type" {
  description = "The EC2 instance's type."
  type        = string
  default     = "t3.micro"
}

variable "vpc_id" {
  description = "ID of the VPC where the EC2 instance will be launched."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the EC2 instance will be launched."
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the EC2 instance."
  type        = list(string)
}
