# devops/terraform/variables.tf

    variable "render_api_key" {
      description = "Your Render API Key for authentication"
      type        = string
      sensitive   = true
    }

    variable "render_owner_id" {
      description = "Your Render account owner ID"
      type        = string
    }

    variable "mongo_uri" {
      description = "MongoDB Connection URI for the application"
      type        = string
      sensitive   = true
    }

    variable "jwt_secret" {
      description = "JWT Secret Key for authentication"
      type        = string
      sensitive   = true
    }
    