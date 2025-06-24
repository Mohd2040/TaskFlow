# تحديد إعدادات Terraform ومزود Render
terraform {
  required_providers {
    # ✅ تغيير مصدر المزود إلى "hashicorp/render"
    # هذا هو الاسم القياسي للمزودات الرسمية أو الشريكة لـ HashiCorp.
    # إذا لم يعمل هذا، سنحتاج للتحقق من التوثيقات الرسمية لمزود Render Terraform Provider
    # أو أنهم لم يوفروا مزوداً رسمياً بعد.
    render = {
      source  = "hashicorp/render" # ✅ هذا هو التغيير الرئيسي
      version = "~> 0.1" # حافظ على الإصدار أو استخدم أحدث إصدار مستقر
    }
  }
}

# تكوين مزود Render (Provider Configuration)
provider "render" {
  api_key = var.render_api_key
}