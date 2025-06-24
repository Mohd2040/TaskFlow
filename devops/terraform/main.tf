# devops/terraform/main.tf
    # (Render Web Service Resource)
    resource "render_web_service" "taskflow_backend_service" {
      
      name = "taskflow" 

      owner_id = var.render_owner_id

      repo_url = "https://github.com/Mohd2040/TaskFlow.git"

      branch = "main"

      root_directory = "backend"

      runtime = "node"

      build_command = "npm install"

      start_command = "npm start"
      auto_deploy = "yes" 

      env_vars = {
        "MONGO_URI"  = var.mongo_uri
        "JWT_SECRET" = var.jwt_secret
      }

      secret_env_vars = {
        "MONGO_URI"  = true
        "JWT_SECRET" = true
      }
      # Health Check Path
      health_check_path = "/api"
    }