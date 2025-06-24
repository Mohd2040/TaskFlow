    # devops/terraform/providers.tf

    # تحديد إعدادات Terraform ومزود Render
    terraform {
      required_providers {
        render = {
          source  = "renderinc/render"
          version = "~> 0.1" # تحقق من أحدث إصدار للمزود
        }
      }
    }

    # تكوين مزود Render (Provider Configuration)
    provider "render" {
      api_key = var.render_api_key
    }
    