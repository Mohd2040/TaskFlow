# devops/terraform/aws/providers.tf

# 1. تحديد إعدادات Terraform
# نحدد هنا مزود AWS والإصدار المطلوب
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # ✅ استخدم أحدث إصدار لمزود AWS (تحقق من registry.terraform.io)
    }
  }
  # تكوين الـ backend لتخزين حالة Terraform في S3
  backend "s3" {
    bucket         = "taskflow-terraform-state-mohamed" # ✅ اسم Bucket فريد عالمياً! استبدل باسم فريد خاص بك
    key            = "taskflow-backend/terraform.tfstate" # مسار ملف الحالة داخل الـ Bucket
    region         = "eu-central-1" # ✅ نفس المنطقة التي ستنشر فيها مواردك
    encrypt        = true # تشفير ملف الحالة في S3
    dynamodb_table = "taskflow-terraform-locks" # ✅ اسم جدول DynamoDB للقفل (للتزامن)
  }
}

# 2. تكوين مزود AWS
# Terraform سيستخدم بيانات الاعتماد من متغيرات البيئة (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION)
provider "aws" {
  region = var.aws_region # يتم جلب المنطقة من متغير Terraform
}
