## CST8918 Final Project – Remix Weather App on Azure

A fully automated Infrastructure as Code (IaC) solution for deploying the Remix Weather Application on Azure Kubernetes Service (AKS) using Terraform, with CI/CD automation powered by GitHub Actions.

## 👥 Team Members

- Nirajan Khadka: https://github.com/khad0062
- Samir Mishra : https://github.com/mishsamir  -mishsamir
- Sai Karthick Kalidoss - https://github.com/Saikarthick07 -Saikarthick07

## 📌 Project Overview

This project demonstrates the implementation of modern DevOps practices, including:
- Infrastructure as Code with Terraform
- Application Containerization using Docker
- Kubernetes Orchestration on Azure AKS
- CI/CD Automation via GitHub Actions
- Multi-Environment Deployments (Test / Production)
- Azure OIDC Authentication for secure integration

## 🗺 Architecture Overview

```
├── .github/workflows/       # GitHub Actions CI/CD Pipelines
│   ├── terraform-static-analysis.yml     # Code quality & security checks
│   ├── infra-ci-cd.yml                   # PR validation & planning
│   ├── infra-ci-cd-terraformapply.yml    # Infrastructure deployment
│   ├── build-push-weather-app.yml        # Docker build & push
│   └── deploy-remix-to-aks.yml           # AKS application deployment
│
├── infra/                   # Terraform Infrastructure Code
│   ├── main.tf              # Root module configuration
│   ├── variables.tf         # Input variables
│   ├── outputs.tf           # Output values
│   ├── terraform.tfvars     # Variable definitions
│   │
│   ├── backend/             # Terraform State Management
│   │   ├── main.tf          # Azure Storage for remote state
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── network/             # Network Infrastructure
│   │   ├── main.tf          # VNet & Subnets
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── aks/                 # AKS Cluster Definitions
│   │   ├── main.tf          # Test & Production clusters
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── remix-weather/       # Application Infrastructure
│       ├── main.tf          # Azure Container Registry & Redis
│       ├── variables.tf
│       └── outputs.tf
│
├── pulumi-app/              # Remix Weather Application
│   ├── Dockerfile           # Container image configuration
│   ├── package.json         # Node.js dependencies
│   ├── app/                 # Remix application source
│   └── public/              # Static assets
│
└── k8s/                     # Kubernetes Manifests
    └── remix-weather-deployment.yaml    # Application deployment spec

```

## ☁ Azure Resources Provisioned

## Network Infrastructure

- Virtual Network: 10.0.0.0/14 (Canada Central)
- Subnets:
Production: 10.0.0.0/16
Test: 10.1.0.0/16
Development: 10.2.0.0/16
Admin: 10.3.0.0/16

## Compute Resources

- ## AKS Clusters:

Test – 1 node, Kubernetes v1.32.6
Production – 2 nodes, Kubernetes v1.32.6

- Node Size: Standard_B2s
- Auto-scaling: Environment-specific limits enabled

## Container & Storage

- Azure Container Registry: Basic SKU, admin-enabled
- Redis Cache: For caching in both Test & Production
- Storage Account: Terraform state stored in blob storage

## Security & Authentication

- OIDC Integration: GitHub Actions passwordless authentication
- Service Principals: Contributor & Reader roles with federated credentials
- Managed Identities: For AKS authentication

## ⚙️ GitHub Actions Workflows

1️⃣ Terraform Static Analysis

- Trigger: Any branch push
- Actions: terraform fmt, terraform validate, tfsec security scan
- Matrix Testing: Multiple Terraform versions

2️⃣ Infrastructure PR Validation

- Trigger: PR to main
- Actions: tflint, terraform plan with cost estimation
- Output: PR comment with plan details

3️⃣ Infrastructure Deployment

- Trigger: Push to main after PR merge
- Actions: terraform apply with state management
- Resilience: Enhanced locking & retry handling

4️⃣ Docker Build & Push

- Trigger: PR to main affecting pulumi-app/**
- Actions: Build image, push to ACR, security scan
- Tags: Commit SHA, short SHA, latest

5️⃣ AKS Application Deployment

- Trigger:
Test: PR to main with app changes
Production: Push to main with app changes
- Actions: Deploy to respective AKS cluster
- Features: Environment configs & health checks

## 🛠 Prerequisites

- Azure CLI (logged in to subscription)
- Terraform ≥ v1.0
- Docker (for local testing)
- kubectl (Kubernetes CLI)
- Git (version control)

## 🚀 Getting Started

1. Clone the Repository
```
git clone https://github.com/mishsamir/Final-Project-CST8918_Group6.git
cd Final-Project-CST8918_300
```

2. Configure Azure Authentication

Create Service Principals
```
# Contributor role
az ad sp create-for-rbac --name "CST8918-Final-Contributor" \
  --role Contributor \
  --scopes /subscriptions/YOUR_SUBSCRIPTION_ID

# Reader role
az ad sp create-for-rbac --name "CST8918-Final-Reader" \
  --role Reader \
  --scopes /subscriptions/YOUR_SUBSCRIPTION_ID
```

### 🔐 GitHub Secrets

| Secret Name             | Description                                      |
|-------------------------|--------------------------------------------------|
| `AZURE_CLIENT_ID`       | Service Principal Client ID                      |
| `AZURE_TENANT_ID`       | Azure Tenant ID                                  |
| `AZURE_SUBSCRIPTION_ID` | Azure Subscription ID                            |
| `ARM_ACCESS_KEY`        | Storage Account Access Key (Terraform state)     |
| `WEATHER_API_KEY`       | OpenWeatherMap API key *(optional)*              |
