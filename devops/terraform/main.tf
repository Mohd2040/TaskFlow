# devops/terraform/main.tf
    # تعريف مورد خدمة الويب (Render Web Service Resource)
    resource "render_web_service" "taskflow_backend_service" {
      # اسم الخدمة على Render (كما تظهر في لوحة التحكم)
      name = "taskflow" # استخدم الاسم الفعلي لخدمتك التي نشرتها على Render

      # معرف المالك لحسابك على Render
      owner_id = var.render_owner_id

      # رابط مستودع GitHub الخاص بك (Terraform سيعرف الخدمة وتستخدم هذا repo)
      repo_url = "https://github.com/Mohd2040/TaskFlow.git"

      # الفرع الذي سيتم النشر منه
      branch = "main"

      # مجلد الجذر للمشروع داخل المستودع (مجلد الـ backend)
      root_directory = "backend"

      # نوع بيئة التشغيل
      runtime = "node"

      # أمر البناء
      build_command = "npm install"

      # أمر بدء تشغيل الخدمة
      start_command = "npm start"

      # تفعيل النشر التلقائي عند كل دفع لـ Git
      # ✅ هام: إذا كنت تريد أن يسحب Render أحدث Docker Image،
      # يجب أن تكون خدمة Render مكونة لسحب من Registry (وليست من Git)
      # وإلا، ستستمر في سحب من Git بناءً على هذا الإعداد.
      # إذا كنت ستستخدم Docker Images التي تدفعها GitHub Actions،
      # قد تحتاج لضبط 'auto_deploy' في Render يدوياً بعد أول تطبيق لـ Terraform
      # أو البحث عن طريقة لتعريف الخدمة كـ Docker Image Service في Terraform إذا كان المزود يدعمها.
      # حالياً، هذا التعريف سيجعلها خدمة مبنية من Git.
      auto_deploy = "yes" 

      # متغيرات البيئة التي سيتم تمريرها إلى خدمة Render
      env_vars = {
        "MONGO_URI"  = var.mongo_uri
        "JWT_SECRET" = var.jwt_secret
      }

      # تعريف متغيرات البيئة التي تحتوي على معلومات حساسة (Render يعرفها كـ Secret)
      secret_env_vars = {
        "MONGO_URI"  = true
        "JWT_SECRET" = true
      }

      # Health Check Path
      health_check_path = "/api"
    }