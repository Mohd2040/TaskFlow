# devops/terraform/aws/outputs.tf

# إخراج عنوان IP العام لـ EC2 instance
output "backend_public_ip" {
  description = "The public IP address of the backend server"
  value       = aws_eip.taskflow_eip.public_ip # استخدام الـ EIP
}

# إخراج اسم DNS العام لـ EC2 instance
output "backend_public_dns" {
  description = "The public DNS of the backend server"
  value       = aws_instance.taskflow_backend_server.public_dns
}

# إخراج الـ SSH command للوصول إلى الخادم
output "ssh_command" {
  description = "SSH command to connect to the backend server"
  value       = "ssh -i ~/.ssh/${var.ssh_key_name}.pem ubuntu@${aws_eip.taskflow_eip.public_ip}"
}
