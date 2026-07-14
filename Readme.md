# Student Registration Form Deployment

This project demonstrates the automated deployment of a Student Registration Form application on AWS using Infrastructure as Code (Terraform), Configuration Management (Ansible), and Continuous Integration/Continuous Deployment (Jenkins).

---

# Overview

- Automate infrastructure provisioning.
- Configure servers using Configuration Management.
- Implement Continuous Integration and Continuous Deployment (CI/CD).
- Host the application on an Nginx web server.

---

# Technologies Used

- Jenkins
- Terraform
- Ansible
- Git/GitHub
- Nginx
- Ubuntu
- AWS EC2
- AWS S3
- AWS CLI

---

# Project Structure
```text
project/
│
├── Jenkinsfile
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── ansible/
│   ├── files/
│   │   └── index.html
│   │
│   └── playbook/
│       └── main.yml
│
└── README.md
```
---

# Architecture

```text
Developer
    |
    v
GitHub Repository
    |
    v
GitHub Webhook
    |
    v
Jenkins Server
    |
    v
Terraform
    |
    v
AWS EC2 Target Server
    |
    v
Ansible
    |
    v
Configure Target Server
    |
    v
Nginx Web Server
    |
    v
Student Registration Form
```

---
# Project Workflow

1. Developer pushes code to GitHub.
2. Jenkins detects the changes.
3. Jenkins executes the pipeline.
4. Terraform creates the infrastructure.
5. Ansible configures the server.
6. Nginx is installed and configured.
7. The Student Registration Form is deployed automatically.
8. The application becomes accessible through the server's public IP.

---

# Configure AWS for Terraform

- Download and install the AWS CLI from AWS official documentation.
- Verify the installation:

```bash
aws --version
```

- Create an IAM user and attach required permissions.
- Create an access key and save the Access Key ID and Secret Access Key.
- Configure AWS CLI:

```bash
aws configure
```

Enter the values:

```text
AWS Access Key ID [None]: AKIAxxxxxxxxxxxxxxxx

AWS Secret Access Key [None]: xxxxxxxxxxxxxxxxxxxxxxxxx

Default region name [None]: us-east-1

Default output format [None]: json
```

- Verify the configuration:

```bash
aws sts get-caller-identity
```

> Note: Never store AWS Access Keys inside Terraform files or GitHub repositories.
---
# Cloud Servers

This project uses two cloud servers to implement an automated CI/CD deployment pipeline:

- Jenkins Server
- Target Server

---

# Prerequisites for Jenkins Server

- Install Jenkins and configure (refer official website).
- Install Terraform.
- Install Ansible.
- Install Git.
- install AWS CLI
- Configure AWS credentials.
- allow ports 80,22,8080

---

# Prerequisites for Target Server

- Ubuntu server
- SSH access enabled
- allow ports 80,22

---

# Deployment Stages

## 1. Code Push to GitHub

Developer pushes the latest application changes to GitHub.

```bash
git add .
git commit -m "Updated application"
git push origin main
```

---

## 2. GitHub Webhook Trigger

- GitHub Webhook monitors repository changes.
- When code is pushed, GitHub sends a notification to the Jenkins server.
- Jenkins automatically starts the CI/CD pipeline.

Webhook URL:

```text
http://<JENKINS_SERVER_IP>:8080/github-webhook/
```

---

## 3. Jenkins Pipeline Execution

The Jenkins server executes the `Jenkinsfile`.
```text
Pipeline stages:

Developer
    |
    v
GitHub
    |
    v
Webhook
    |
    v
Jenkins Server
    |
    v
Terraform
    |
    v
AWS EC2 Target Server
    |
    v
Ansible
    |
    v
Nginx Configuration
    |
    v
Student Registration Form
```
---

## 4. Source Code Checkout

Jenkins server downloads the latest code from GitHub.

Command:

```bash
checkout scm
```

---

## 5. Terraform Infrastructure Provisioning

Terraform runs on the Jenkins server.

Initialize Terraform:

```bash
terraform init
```

Create execution plan:

```bash
terraform plan
```

Deploy infrastructure:

```bash
terraform apply -auto-approve
```

Terraform creates and configures the target server resources.

---

## 6. Retrieve Target Server Details

Jenkins retrieves the target server IP using Terraform output.

Command:

```bash
terraform output -raw public_ip
```

The target server IP is passed to Ansible.

---

## 7. Create Ansible Inventory

Jenkins dynamically creates the Ansible inventory file:

```ini
[web]

<TARGET_SERVER_IP> ansible_user=ubuntu
```

---

## 8. SSH Connection Between Servers

Jenkins server connects to the target server using SSH credentials stored in Jenkins.

```text
Jenkins Server
      |
      | SSH
      |
      v
Target Server
```

---

## 9. Ansible Configuration

Ansible runs from the Jenkins server and configures the target server.

Command:

```bash
ansible-playbook -i ansible/inventory ansible/playbook/main.yml
```

Ansible performs:

- Connects to target server.
- Installs Nginx.
- Configures Nginx web server.
- Copies Student Registration Form files.
- Starts Nginx service.

---

## 10. Application Deployment on Target Server

The application is deployed to:

```text
/var/www/html/
```

Nginx serves the application.

---

## 11. Deployment Verification

After successful deployment, access the application:

```text
http://<TARGET_SERVER_PUBLIC_IP>
```

---

# Future Improvements

- Add Docker containerization.
- Use AWS Load Balancer.
- Add HTTPS using SSL certificates.
- Add monitoring using CloudWatch.
- Implement Terraform remote state using AWS S3.
- Add automated testing stage in Jenkins pipeline.

---


---

## 8. License (optional)

```markdown
# License

This project is for learning and demonstration purposes.