# devops/terraform/aws/providers.tf

# 1. تحديد إعدادات Terraform
# نحدد هنا مزود AWS والإصدار المطلوب
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # استخدم أحدث إصدار مستقر (تحقق من registry.terraform.io)
    }
  }
  # تكوين الـ backend لتخزين حالة Terraform في S3
  backend "s3" {
    bucket         = "taskflow-terraform-state-mohd2040" # ✅ اسم Bucket فريد عالمياً، استخدم الاسم الذي أنشأته
    key            = "taskflow-backend/terraform.tfstate" # مسار ملف الحالة داخل الـ Bucket
    region         = "us-west-1" # ✅ تم التحديث إلى us-west-1
    encrypt        = true # تشفير ملف الحالة في S3
    dynamodb_table = "taskflow-terraform-locks" # ✅ اسم جدول DynamoDB للقفل
  }
}

# 2. تكوين مزود AWS
# Terraform سيستخدم بيانات الاعتماد من متغيرات البيئة (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION)
provider "aws" {
  region = var.aws_region # يتم جلب المنطقة من متغير Terraform
}
