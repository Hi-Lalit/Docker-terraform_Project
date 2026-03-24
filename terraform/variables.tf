variable "key_name" {
  description = "AWS Key Pair Name"
  type        = string
  default     = "ec2"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0ec10929233384c7f" # Ubuntu 22.04 LTS

}

variable "region_name" {
  description = "Cloud provider name"
  type        = string
  default     = "us-east-1"

}