
# 🚀 TaskFlow: Smart DevOps-Driven Task Management System

## 📌 Project Overview

**TaskFlow** is a modern, full-stack task management application designed with a strong emphasis on DevOps principles and cloud-native architecture. It serves as a comprehensive portfolio project showcasing advanced skills in:

- 🏗️ Infrastructure as Code (Terraform)
- 🐳 Containerization (Docker)
- 🔁 CI/CD pipelines (GitHub Actions)
- ☁️ Cloud deployment (AWS & GCP)
- 🔄 GitOps with Argo CD & Helm
- ☸️ Kubernetes orchestration

Users can:
- 👤 Register & Log in
- ✅ Manage tasks (title, description, type, priority, status)

## 🛠️ DevOps Journey & Key Technologies

### 🧠 Backend
- **Tech Stack:** Node.js, Express.js
- **Database:** MongoDB Atlas (Cloud-hosted NoSQL)
- **Auth:** JWT (JSON Web Tokens)
- **Container:** Docker

### 🎨 Frontend
- **Tech Stack:** HTML, CSS (Tailwind), JavaScript
- **Purpose:** Simple and responsive interface

## ✨ Core DevOps Features

### 🏗️ IaC with Terraform (AWS)
- VPC, Subnets, Route Tables, IGW
- Security Groups
- EC2 Instance + Elastic IP
- S3 + DynamoDB (State management)
- Automated, repeatable deployments
- Git versioned & destructible

### 🐳 Docker Containerization
- Consistent builds across all environments

### 🔁 CI/CD with GitHub Actions
- Docker image build & push (GHCR/Docker Hub)
- Auto-update Helm `values.yaml`
- Deploy to Render (deploy hook)
- `terraform apply` on infra change
- Secrets managed with GitHub Secrets

### ☸️ Kubernetes & Helm
- **Local (Kind):** Fast iteration & testing
- **GKE (Google Cloud):** Production-ready
- **Helm:** Flexible app packaging

### 🔄 GitOps with Argo CD
- Declarative, Git-driven deployments
- Auto-sync cluster with Git changes
- Secure secret injection (via K8s secrets)

## ☁️ Cloud Deployment Strategy

- **Initial:** Render.com (quick preview)
- **Advanced:** AWS EC2 (manual Docker)
- **Production:** GKE + Helm + Argo CD

## 🗺️ Project Architecture

_Add diagram here showing Backend/API ↔ Frontend ↔ MongoDB & DevOps Tooling (CI/CD, Helm, Argo CD)_

## 🏁 Getting Started

### 📋 Prerequisites

- Node.js
- Docker
- Git
- AWS & GCP Account
- MongoDB Atlas
- Render.com
- kubectl
- Helm
- Argo CD CLI
- Kind (for local dev)

### 🖥️ Local Development

```bash
git clone https://github.com/Mohd2040/TaskFlow.git
cd TaskFlow
kind create cluster --name taskflow-cluster
# On Windows PowerShell:
$env:KUBECONFIG=(wsl.exe realpath ~/.kube/kind-config-taskflow-cluster.yaml)
cd kubernetes/helm/taskflow-app
# Create Secrets
kubectl create secret generic ghcr-pull-secret ...
kubectl create secret generic taskflow-backend-mongo-secret ...
kubectl create secret generic taskflow-backend-jwt-secret ...
helm upgrade --install taskflow-release .
kubectl port-forward service/taskflow-backend-service 8080:80
# Visit http://localhost:8080
```

### 🔙 Backend Setup

```bash
cd backend
npm install
cp .env.example .env
npm start
```

### 💻 Frontend Access

Open `backend/public/index.html` in your browser.

## ☁️ AWS Deployment (Terraform)

- Configure S3 Bucket & DynamoDB for state
- IAM + EC2 Key Pair + GitHub Secrets
- Push to main triggers infra creation

## 📡 EC2 Deployment

```bash
ssh -i key.pem ubuntu@<EC2_IP>
sudo apt install docker.io -y
docker login
docker run -d -p 80:5000 -e MONGO_URI=... -e JWT_SECRET=... your-image
```

## ☸️ GKE Deployment (Helm + Argo CD)

```bash
gcloud config set project <your-project-id>
gcloud container clusters get-credentials taskflow-gke-cluster ...
kubectl create secret generic ...
helm upgrade --install taskflow-release .
kubectl rollout restart deployment/taskflow-backend-deployment
```

### 🔄 Argo CD Workflow

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl port-forward svc/argocd-server -n argocd 8080:443
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

- Connect Git repo in Argo CD UI
- Create App (auto-sync on `main` branch)
- Argo CD detects & deploys Helm chart changes

## 💡 Future Enhancements

- 🤖 EC2 automation (UserData, Ansible)
- 📈 Auto-scaling, Load Balancer, HTTPS (ACM)
- 📊 Monitoring (Grafana, Prometheus)
- 🔐 Argo CD OIDC Login (Gmail + Domain)
- 🧪 Testing pipeline
- 🌐 Ingress + custom domain for Argo UI

---

## 🤝 Contribution

👨‍💻 Developed by **Mohamed AbuShallouf 🇵🇸**  
🔗 [GitHub](https://github.com/Mohd2040/TaskFlow) | [Upwork](https://upwork.com/freelancers/mohammeda857) | [LinkedIn](https://linkedin.com/in/mohamed-abushallouf)
