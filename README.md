🚀 TaskFlow: Smart DevOps-Driven Task Management System
📌 Project Overview

TaskFlow is a modern, full-stack task management application designed with a strong emphasis on DevOps principles and cloud-native architecture. It serves as a comprehensive portfolio project showcasing advanced skills in:
🏗️ Infrastructure as Code
🐳 Containerization
🔁 CI/CD pipelines
☁️ Cloud deployment on AWS and Google Cloud Platform (GCP)
** orchestrating deployments with Kubernetes and GitOps**

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
🏢 VPC
📍 Public Subnets
🌐 Internet Gateway & 📑 Route Tables
🛡️ Security Groups (SSH, HTTP, HTTPS)
📡 EC2 Instance
📬 Elastic IP
💾 S3 Bucket
🧮 DynamoDB Table
♻️ Repeatable Deployments for multiple environments
🔄 Version Controlled via Git
💣 Automated Destruction of infrastructure

🐳 Containerization with Docker:

📦 Node.js app is packaged into a container
🌍 Runs consistently across environments

🔁 CI/CD with GitHub Actions:

🏗️ Docker Image Build: triggered on backend code changes
📤 Push to Registries:
📦 GitHub Container Registry
🐙 Docker Hub
🚀 Automated Helm Chart Update: Automatically updates the image tag in values.yaml in Git after a successful image build.
🎯 Deploy to Render: via secure deploy hook after image build
📜 Deploy Infrastructure: trigger terraform apply on devops/terraform/aws/ changes
🔐 Secrets Managed: via GitHub Secrets (AWS, Docker, JWT, Mongo, Render)

☸️ Kubernetes Orchestration with Helm & Argo CD:

☁️ Local Kubernetes (Kind):

Lightweight Clusters: Utilizes Kind (Kubernetes in Docker) for local Kubernetes cluster creation and management.

Development & Testing: Provides a consistent local environment for rapid iteration and testing of containerized applications.

🚀 Google Kubernetes Engine (GKE):

Managed Kubernetes: Deploys the application to Google Cloud's managed Kubernetes service for scalable and robust cloud deployments.

Production-ready Environment: Leverages GKE's capabilities for high availability, auto-scaling, and integration with GCP services.

📦 Helm for Packaging:

Application Packaging: Uses Helm to define, install, and upgrade the TaskFlow application on Kubernetes clusters.

Templating & Customization: Allows flexible configuration of deployments through values.yaml for different environments.

🔄 GitOps with Argo CD:

Declarative Deployments: Argo CD continuously monitors the Git repository (where Helm Charts reside) as the single source of truth.

Automated Synchronization: Automatically synchronizes the Kubernetes cluster state with the desired state defined in Git.

Continuous Delivery: Enables automated deployments and updates to the application whenever changes are pushed to the Git repository.

Secure Secret Management: Integrates with Kubernetes Secrets to securely provide sensitive information to pods, keeping them out of Git.

☁️ Cloud Deployment Strategy:

🧪 Initial (Render.com): Unified deployment for fast access
⚙️ Advanced (AWS EC2):
🔑 SSH into instance
🐳 Install Docker
📥 Pull and 🏃 Run image
☸️ Kubernetes (GKE):
📦 Deploy via Helm Chart
🔄 Managed by Argo CD for GitOps-driven continuous delivery

🗺️ Project Architecture

(يمكنك هنا إضافة رسم توضيحي جديد أو تحديث الموجود ليعكس GKE و Argo CD)

🏁 Getting Started

📋 Prerequisites

📦 Node.js
🐳 Docker
🧪 Git
☁️ AWS Account
☁️ Google Cloud Platform (GCP) Account
💾 MongoDB Atlas
🔗 Render.com
☸️ kubectl (configured for GKE)
📦 Helm
🔄 Argo CD CLI
☸️ Kind (for local development)

🖥️ Local Development

git clone https://github.com/Mohd2040/TaskFlow.git
cd TaskFlow

Local Kubernetes (Kind):

# In WSL (Ubuntu)
kind create cluster --name taskflow-cluster

# In Windows PowerShell (for kubectl/helm access)
$env:KUBECONFIG=(wsl.exe realpath ~/.kube/kind-config-taskflow-cluster.yaml)

# Navigate to Helm Chart directory
cd kubernetes/helm/taskflow-app

# Create Kubernetes Secrets (if not already created)
kubectl create secret generic ghcr-pull-secret --docker-server=ghcr.io --docker-username=YOUR_GITHUB_USERNAME --docker-password=YOUR_GITHUB_PAT --docker-email=your-email@example.com
kubectl create secret generic taskflow-backend-mongo-secret --from-literal=MONGODB_URL="YOUR_MONGODB_URL_VALUE"
kubectl create secret generic taskflow-backend-jwt-secret --from-literal=JWT_SECRET="YOUR_JWT_SECRET_VALUE"

# Deploy with Helm
helm upgrade --install taskflow-release .

# Access application locally
kubectl port-forward service/taskflow-backend-service 8080:80
# Open http://localhost:8080 in your browser

🔙 Backend Setup

cd backend
npm install
cp .env.example .env # Edit .env
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

# Run Docker Image
# docker login (Hub or GHCR)
docker pull your-username/taskflow-backend:latest

docker run -d -p 80:5000 \
  -e MONGO_URI="..." \
  -e JWT_SECRET="..." \
  --name taskflow-app \
  your-username/taskflow-backend:latest

Access via Public IP in browser 🔍

☸️ Cloud Deployment (Google Kubernetes Engine - GKE)

⚙️ GKE Setup

Create a GCP Project and enable Billing.

Enable Kubernetes Engine API.

Create a GKE Standard Cluster (e.g., taskflow-gke-cluster) in your desired region/zone with e2-medium machine type and 1 node.

🔐 gcloud CLI Configuration

# In WSL (Ubuntu)
gcloud auth login romiooeng@gmail.com
gcloud config set account romiooeng@gmail.com
gcloud config set project YOUR_GCP_PROJECT_ID # Replace with your actual GCP Project ID

# Get GKE cluster credentials
gcloud container clusters get-credentials taskflow-gke-cluster --zone YOUR_CLUSTER_ZONE --project YOUR_GCP_PROJECT_ID

# Install gke-gcloud-auth-plugin (if prompted)
gcloud components install gke-gcloud-auth-plugin

📦 Helm Chart Deployment

# Navigate to Helm Chart directory
cd kubernetes/helm/taskflow-app

# Ensure backend-service.yaml type is LoadBalancer for external access
# Ensure values.yaml does NOT contain sensitive data (MONGO_URI, JWT_SECRET)

# Create Kubernetes Secrets in GKE (if not already created)
# These secrets are NOT stored in Git
kubectl create secret generic ghcr-pull-secret --docker-server=ghcr.io --docker-username=YOUR_GITHUB_USERNAME --docker-password=YOUR_GITHUB_PAT --docker-email=your-email@example.com
kubectl create secret generic taskflow-backend-mongo-secret --from-literal=MONGODB_URL="YOUR_MONGODB_URL_VALUE"
kubectl create secret generic taskflow-backend-jwt-secret --from-literal=JWT_SECRET="YOUR_JWT_SECRET_VALUE"

# Deploy with Helm
helm upgrade --install taskflow-release .

# Force rollout restart to apply new configurations (if needed)
kubectl rollout restart deployment/taskflow-backend-deployment

🔄 GitOps with Argo CD

Install Argo CD on GKE:

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Access Argo CD UI (Local Port Forward):

kubectl port-forward svc/argocd-server -n argocd 8080:443
# Open https://localhost:8080 in browser

Get Initial Admin Password:

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

Login to Argo CD UI with admin and this password.

Connect GitHub Repository to Argo CD:

In Argo CD UI -> Settings -> Repositories -> CONNECT REPO.

Type: Git, URL: https://github.com/Mohd2040/TaskFlow.git, Credential Type: HTTPS.

Username: Your GitHub Username, Password: GitHub PAT (with repo scope).

Create Argo CD Application:

In Argo CD UI -> Applications -> + NEW APP.

Application Name: taskflow-backend, Project: default, Sync Policy: Automatic (with Prune & Self Heal).

Source: Repository URL: https://github.com/Mohd2040/TaskFlow.git, Revision: HEAD, Path: kubernetes/helm/taskflow-app.

Destination: Cluster: in-cluster, Namespace: default.

Click CREATE.

GitOps Workflow:

Update Backend Code: Make a change in backend/ directory.

Commit & Push to Git (main branch):

git add backend/
git commit -m "feat: Made a new change in backend"
git push origin main

GitHub Actions: Workflow will build a new Docker image with a date-based tag (e.g., 20250711-103520) and push it to GHCR/Docker Hub.

Automated values.yaml Update: The GitHub Actions workflow will automatically update kubernetes/helm/taskflow-app/values.yaml with the new image tag and push this change to Git.

Argo CD Sync: Argo CD will detect the values.yaml change in Git, automatically pull the new image, and deploy the updated application to GKE.

💡 Future Enhancements

🤖 Automate EC2 setup (User Data / Ansible)
🔁 Load Balancer (ALB)
📈 Auto Scaling
📊 CloudWatch / Monitoring
🧱 MongoDB IaC
🧪 Add Tests to CI/CD
🔐 HTTPS via ACM
🌐 Custom Domain for Argo CD UI (with Ingress & SSL)
🚀 Argo CD ApplicationSet for Multi-Environment Deployments
👁️ Advanced Monitoring & Alerting (Prometheus/Grafana)
🛡️ Network Policies for Kubernetes

🤝 Contribution

We welcome your contributions! 🙌
👨‍💻 Developed By Mohamed AbuShallouf 🇵🇸
Upwork Profile
LinkedIn Profile
GitHub Repository (This Project)
