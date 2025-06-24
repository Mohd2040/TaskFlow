# تحديد إعدادات Terraform ومزود Render
terraform {
  required_providers {

    render = {
      source  = "hashicorp/render" # 
      version = "~> 0.1" 
    }
  }
}

provider "render" {
  api_key = var.render_api_key
}