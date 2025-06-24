# devops/terraform/aws/variables.tf

variable "aws_region" {
  description = "AWS region for resource deployment"
  type        = string
  default     = "eu-central-1" # ✅ اختر منطقتك المفضلة هنا
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
  description = "AMI ID for the EC2 instance (e.g., Ubuntu 22.04 LTS)"
  type        = string
  # ✅ ابحث عن AMI ID المناسب لمنطقتك (مثلاً: Ubuntu Server 22.04 LTS)
  # يمكنك إيجاده عند محاولة إنشاء EC2 instance يدوياً في AWS Console
  # أو البحث عن 'ami-053b0d53c279c657a' لـ eu-central-1 (قد يتغير)
  default     = "ami-053b0d53c279c657a" 
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair in AWS"
  type        = string
  # ✅ يجب أن يكون لديك مفتاح SSH موجود في AWS (EC2 -> Key Pairs)
  # ونسخة من المفتاح الخاص (.pem) على جهازك للوصول إلى الخادم
  default     = "taskflow-ssh-key" 
}
