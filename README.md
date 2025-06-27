TaskFlow: Smart DevOps-Driven Task Management System

📌 Project Overview
TaskFlow is a modern, full-stack task management application designed with a strong emphasis on DevOps principles and cloud-native architecture. It serves as a comprehensive portfolio project showcasing advanced skills in:

🏗️ Infrastructure as Code

🐳 Containerization

🔁 CI/CD pipelines

☁️ Cloud deployment on AWS


The application allows users to:


👤 Register & Log in

✅ Manage tasks with attributes like title, description, type, priority, and status

🛠️ DevOps Journey & Key Technologies
🧠 Backend
📦 Technology Stack: Node.js, Express.js

💾 Database: MongoDB Atlas (Cloud-hosted NoSQL Database)

🔐 Authentication: JWT (JSON Web Tokens)

🐳 Containerization: Docker

🎨 Frontend
💻 Technology Stack: HTML, CSS (Tailwind CSS), JavaScript

🧩 Purpose: Simple and responsive interface for interacting with the backend API

✨ Core DevOps Features

🏗️ Infrastructure as Code (IaC) with Terraform & AWS:

🪄 Automated Provisioning using Terraform to set up AWS infrastructure:
  - 🏢 VPC
  - 📍 Public Subnets
  - 🌐 Internet Gateway & 📑 Route Tables
  - 🛡️ Security Groups (SSH, HTTP, HTTPS)
  - 📡 EC2 Instance
  - 📬 Elastic IP
  - 💾 S3 Bucket
  - 🧮 DynamoDB Table

♻️ Repeatable Deployments for multiple environments

🔄 Version Controlled via Git

💣 Automated Destruction of infrastructure

🐳 Containerization with Docker:

📦 Node.js app is packaged into a container

🌍 Runs consistently across environments

🔁 CI/CD with GitHub Actions:

🏗️ Docker Image Build: triggered on backend code changes

📤 Push to Registries:

  - 📦 GitHub Container Registry
  - 🐙 Docker Hub

🎯 Deploy to Render: via secure deploy hook after image build

📜 Deploy Infrastructure: trigger terraform apply on devops/terraform/aws/ changes

🔐 Secrets Managed: via GitHub Secrets (AWS, Docker, JWT, Mongo, Render)

☁️ Cloud Deployment Strategy:

🧪 Initial (Render.com): Unified deployment for fast access

⚙️ Advanced (AWS EC2):

  - 🔑 SSH into instance
  - 🐳 Install Docker
  - 📥 Pull and 🏃 Run image

🗺️ Project Architecture

![TaskFlow Project Architecture](docs/images/project-architecture.svg)

🏁 Getting Started

📋 Prerequisites

📦 Node.js

🐳 Docker

🧪 Git

☁️ AWS Account

💾 MongoDB Atlas

🔗 Render.com

🖥️ Local Development

git clone https://github.com/Mohd2040/TaskFlow.git
cd TaskFlow

🔙 Backend Setup

cd backend
npm install
cp .env.example .env
# Edit .env with your MongoDB Atlas URI and JWT_SECRET
npm start

💻 Frontend Access

Open backend/public/index.html in your browser.

☁️ Cloud Deployment (AWS via Terraform)

⚙️ AWS Setup
Create AWS Account

IAM User w/ EC2, VPC, S3, DynamoDB access

💾 S3 Bucket (e.g., taskflow-terraform-state-<name>) with versioning

🧮 DynamoDB Table (e.g., taskflow-terraform-locks)

🔐 EC2 Key Pair (e.g., taskflow-ssh-key)

🔐 GitHub Secrets

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

SSH_KEY_NAME

DOCKER_HUB_USERNAME

DOCKER_HUB_TOKEN

RENDER_DEPLOY_HOOK

📜 Terraform Configuration

cd devops/terraform/aws/
# Ensure tf files are properly configured
# Push to main branch

GitHub Actions will auto-deploy infrastructure.

📡 EC2 Deployment (Manual)

# SSH into instance
ssh -i taskflow-ssh-key.pem ubuntu@<EC2_PUBLIC_IP>

# Install Docker
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu

# Logout and login again for group changes to apply, or run `newgrp docker`

🏃 Run Docker Image

# docker login (Hub or GHCR)
# Example for Docker Hub login:
# docker login -u YOUR_DOCKER_HUB_USERNAME -p YOUR_DOCKER_HUB_TOKEN
# Example for GHCR login:
# docker login ghcr.io -u YOUR_GH_USERNAME -p ${{ secrets.GITHUB_TOKEN }} # Note: Use GITHUB_TOKEN as password for GHCR

docker pull your-username/taskflow-backend:latest # e.g., mohamed2040/taskflow-backend:latest

# OR if pulling from GHCR: ghcr.io/Mohd2040/taskflow-backend:latest

docker run -d -p 80:5000 \
  -e MONGO_URI="YOUR_MONGODB_ATLAS_URI" \
  -e JWT_SECRET="YOUR_JWT_SECRET" \
  --name taskflow-app \
  your-username/taskflow-backend:latest

Access via Public IP in browser 🔍

💡 Future Enhancements

🤖 Automate EC2 setup (User Data / Ansible)

🔁 Load Balancer (ALB)

📈 Auto Scaling

📊 CloudWatch / Monitoring

🧱 MongoDB IaC

🧪 Add Tests to CI/CD

🔐 HTTPS via ACM

🤝 Contribution

We welcome your contributions! 🙌

👨‍💻 Developed By
Mohamed AbuShallouf 🇵🇸

- [**Upwork Profile**](https://upwork.com/freelancers/mohammeda857)
- [**LinkedIn Profile**](https://www.linkedin.com/in/mohdabushalloufdevops2040/)
- [**GitHub Repository**](https://github.com/Mohd2040/TaskFlow) (This Project)