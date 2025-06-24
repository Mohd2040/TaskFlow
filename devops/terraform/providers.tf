    # devops/terraform/providers.tf

    # تحديد إعدادات Terraform ومزود Render
    terraform {
  required_providers {
    render = {
      source  = "renderinc/render"
      version = "0.7.1"
    }
  }

  required_version = ">= 1.4.0"
}

provider "render" {
  api_key = var.render_api_key
}