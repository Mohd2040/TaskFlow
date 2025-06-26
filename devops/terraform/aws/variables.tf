# devops/terraform/aws/variables.tf

variable "aws_region" {
  description = "AWS region for resource deployment"
  type        = string
  default     = "us-west-1" # ✅ تم التحديث إلى us-west-1
}

variable "project_name" {
  description = "Name of the project to tag resources"
  type        = string
  default     = "TaskFlow"
}

variable "instance_type" {
  description = "EC2 instance type for the backend server"
  type        = string
  default     = "t2.micro" # مناسب للخطة المجانية وللتطوير

}

variable "ami_id" {
  description = "AMI ID for the EC2 instance (e.g., Ubuntu 22.04 LTS for us-west-1)"
  type        = string
  default     = "ami-043b59f1d11f8f189" # ✅ AMI ID لـ Ubuntu 22.04 LTS في us-west-1ami-043b59f1d11f8f189
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair in AWS"
  type        = string
  default     = "taskflow-ssh-key" # استخدم اسم مفتاح SSH الذي أنشأته في AWS
}
