TaskFlow: Smart DevOps-Driven Task Management System
🚀 Project Overview
TaskFlow is a modern, full-stack task management application designed with a strong emphasis on DevOps principles and cloud-native architecture. It serves as a comprehensive portfolio project showcasing advanced skills in infrastructure as code, containerization, CI/CD pipelines, and cloud deployment on AWS.

The application allows users to register, log in, and manage their tasks with various attributes like title, description, type, priority, and status.

🛠️ DevOps Journey & Key Technologies
This project embodies a complete DevOps lifecycle, leveraging industry-standard tools and practices to ensure efficient, scalable, and reliable deployment.

Backend
Technology Stack: Node.js, Express.js

Database: MongoDB Atlas (Cloud-hosted NoSQL Database)

Authentication: JWT (JSON Web Tokens) for secure user authentication

Containerization: Docker for packaging the application and its dependencies into isolated, portable containers.

Frontend
Technology Stack: Pure HTML, CSS (Tailwind CSS), and JavaScript

Purpose: Simple and responsive user interface to interact with the backend API.

✨ Core DevOps Features
This project highlights the following key DevOps capabilities:

Infrastructure as Code (IaC) with Terraform & AWS:

Automated Infrastructure Provisioning: Terraform is used to define and provision the entire AWS infrastructure required for the backend, including:

Virtual Private Cloud (VPC): Secure and isolated network environment.

Public Subnets: Network segments for publicly accessible resources.

Internet Gateway (IGW) & Route Tables: Enabling internet connectivity.

Security Groups: Configurable firewalls to control network traffic (SSH, HTTP, HTTPS).

EC2 Instance: Virtual server where the Dockerized backend application will run.

Elastic IP (EIP): A static public IP address for the EC2 instance, ensuring a consistent endpoint.

S3 Bucket & DynamoDB Table: Configured as a secure Terraform Remote Backend for state management and locking, crucial for team collaboration.

Repeatable Deployments: Ability to provision identical environments (development, staging, production) consistently.

Version Control: All infrastructure definitions are version-controlled in Git.

Automated Destruction: Terraform facilitates easy and complete teardown of the provisioned infrastructure to manage costs and environments.

Containerization with Docker:

The Node.js backend application is containerized using a Dockerfile.

Ensures consistent runtime environments across development, testing, and production.

Continuous Integration/Continuous Delivery (CI/CD) with GitHub Actions:

Automated Docker Image Builds: A GitHub Actions workflow automatically builds the Docker image of the backend whenever changes are pushed to the backend/ directory.

Multi-Registry Push: The built Docker image is automatically pushed to both:

GitHub Container Registry (GHCR): For seamless integration within the GitHub ecosystem.

Docker Hub: For broader accessibility and distribution.

Automated Application Deployment (via Render Hook): A dedicated GitHub Actions workflow triggers a deployment on Render.com (via a Secure Deploy Hook) after a successful Docker image build, ensuring the latest application version is always live.

Automated Infrastructure Deployment (via Terraform on AWS): A separate GitHub Actions workflow triggers terraform apply when changes are pushed to the devops/terraform/aws/ directory, automatically provisioning or updating the AWS infrastructure.

Secure Secrets Management: All sensitive credentials (AWS Access Keys, Docker Hub Tokens, Render API Keys, MongoDB URIs, JWT Secrets) are securely stored and accessed via GitHub Secrets, never exposed in code.

Cloud Deployment Strategy:

Initial Deployment (Render.com): The project is initially deployed on Render.com as a unified web service (Node.js backend serving static HTML/JS frontend) for rapid prototyping and easy access.

Advanced Cloud Deployment (AWS EC2): Demonstrates the capability to deploy the Dockerized backend onto a custom-provisioned AWS EC2 instance, showcasing deeper cloud operational skills. This phase involves manually SSHing into the EC2 instance, installing Docker, pulling the image, and running the container. (Future enhancements will automate this part further).

☁️ Project Architecture
graph TD
    subgraph "Local Development/Git"
        A[Developer Code] --> B(git push)
    end

    subgraph "GitHub Repository"
        B --> C[GitHub Repo]
    end

    subgraph "CI/CD Pipelines (GitHub Actions)"
        C --> D1{Build & Push Docker Image}
        D1 --> E1(GitHub Container Registry)
        D1 --> E2(Docker Hub)
        C -- (changes in devops/terraform/aws/) --> D2{Terraform AWS Apply}
    end

    subgraph "Cloud Platforms"
        E1 --> F1[Render.com Deployment]
        E2 --> F2[Render.com Deployment]
        D1 -- (triggers Render Hook) --> F1
        D2 --> G[AWS Infrastructure]
        G --> H(EC2 Instance with Docker)
        H -- (pulls Docker Image) --> E1 & E2
        H --> I[MongoDB Atlas Database]
    end

    subgraph "User Access"
        J[Web Browser] --> F1 & I
        J --> H & I
    end

    style D1 fill:#f9f,stroke:#333,stroke-width:2px
    style D2 fill:#9cf,stroke:#333,stroke-width:2px
    style E1 fill:#afe,stroke:#333,stroke-width:2px
    style E2 fill:#afe,stroke:#333,stroke-width:2px
    style F1 fill:#bbf,stroke:#333,stroke-width:2px
    style G fill:#ffc,stroke:#333,stroke-width:2px
    style H fill:#cff,stroke:#333,stroke-width:2px
    style I fill:#faa,stroke:#333,stroke-width:2px

🏃 Getting Started
Prerequisites
Node.js (for local development)

Docker (for local development/testing)

Git

AWS Account (for cloud deployment)

MongoDB Atlas Account (for database)

Render.com Account (for initial easy deployment)

Local Development
Clone the repository:

git clone https://github.com/Mohd2040/TaskFlow.git
cd TaskFlow

Backend Setup:

cd backend
npm install
cp .env.example .env
# Edit .env with your MongoDB Atlas URI and JWT_SECRET
npm start

Frontend Access:
Open backend/public/index.html in your browser.

Cloud Deployment (AWS via Terraform)
AWS Setup:

Create an AWS account.

Configure an IAM User with programmatic access and necessary permissions (EC2, VPC, S3, DynamoDB FullAccess).

Create an S3 bucket (e.g., taskflow-terraform-state-yourname) with versioning enabled for Terraform state.

Create a DynamoDB table (e.g., taskflow-terraform-locks) with LockID as primary key for state locking.

Create an EC2 Key Pair (e.g., taskflow-ssh-key) for SSH access to instances.

GitHub Secrets:
Add the following as GitHub Repository Secrets:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

SSH_KEY_NAME (e.g., taskflow-ssh-key)

DOCKER_HUB_USERNAME

DOCKER_HUB_TOKEN (Docker Hub Access Token with write access)

RENDER_DEPLOY_HOOK (Render.com Deploy Hook URL for your backend service)

Terraform Configuration:

Navigate to devops/terraform/aws/.

Ensure providers.tf, variables.tf, main.tf, outputs.tf are configured with your AWS region, S3 bucket name, DynamoDB table name, AMI ID, and SSH key name.

Push these files to main branch. The Deploy AWS Infrastructure GitHub Actions workflow will automatically provision your AWS infrastructure.

Application Deployment to EC2 (Manual for now):

Get the public IP/DNS from Terraform outputs (from GitHub Actions logs) or AWS Console.

SSH into the EC2 instance using your SSH key.

Install Docker:

sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu # Add current user to docker group
# Logout and login again for group changes to apply, or run `newgrp docker`

Pull and Run Docker Image:

# Log in to Docker Hub (if using private image)
# docker login -u YOUR_DOCKER_HUB_USERNAME -p YOUR_DOCKER_HUB_TOKEN
# OR log in to GHCR
# docker login ghcr.io -u YOUR_GH_USERNAME -p YOUR_GITHUB_TOKEN

docker pull YOUR_DOCKER_HUB_USERNAME/taskflow-backend:latest # Or ghcr.io/...
docker run -d -p 80:5000 \
    -e MONGO_URI="YOUR_MONGODB_ATLAS_URI" \
    -e JWT_SECRET="YOUR_JWT_SECRET" \
    --name taskflow-app \
    YOUR_DOCKER_HUB_USERNAME/taskflow-backend:latest

Note: The -p 80:5000 maps container port 5000 (Node.js app) to host port 80 (HTTP). Ensure Security Group allows port 80.

Access the application using the EC2 instance's Public IP or DNS in your browser.

💡 Future Enhancements
Automate EC2 Application Deployment: Integrate User Data in Terraform or use Configuration Management tools (e.g., Ansible) within GitHub Actions to automatically install Docker, pull the image, and run the container on EC2.

Load Balancing: Implement an AWS Application Load Balancer (ALB) for high availability and traffic distribution.

Auto Scaling: Configure Auto Scaling Groups for the EC2 instances to handle varying loads.

Monitoring & Logging: Integrate AWS CloudWatch or third-party tools like Prometheus/Grafana for comprehensive monitoring.

Database IaC: Use Terraform to provision and manage MongoDB Atlas resources (Users, Clusters, IP Whitelist).

Advanced CI/CD: Implement testing phases (unit, integration) within GitHub Actions.

HTTPS/SSL: Integrate AWS Certificate Manager (ACM) with Load Balancer for HTTPS.

🤝 Contribution
Contributions are welcome! Feel free to open issues or submit pull requests.

👨‍💻 Developed By
Mohamed AbuShallouf 🇵🇸

Upwork Profile

LinkedIn Profile

GitHub Repository (This Project)