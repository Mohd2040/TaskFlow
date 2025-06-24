    # devops/terraform/outputs.tf

    # إخراج URL لخدمة الـ Backend المنشورة
    output "backend_url" {
      description = "The URL of the deployed TaskFlow Backend service"
      value       = render_web_service.taskflow_backend_service.service_details[0].url
    }
    