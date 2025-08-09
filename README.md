# CST8918 Final Project - Remix Weather App on Azure

A complete Infrastructure as Code (IaC) solution for deploying a Remix Weather application on Azure Kubernetes Service (AKS) using Terraform with automated CI/CD pipelines through GitHub Actions.



##  Team Members
     Nirajan Khadka: https://github.com/khad0062- 
     Samir Mishra : https://github.com/mishsamir  -mishsamir
     Sai Karthick Kalidoss - https://github.com/Saikarthick07 -Saikarthick07

##  Project Overview

This project showcases modern DevOps practices by implementing:

- **Infrastructure as Code** using Terraform
- **Containerized Application** with Docker
- **Kubernetes Orchestration** on Azure AKS
- **CI/CD Automation** with GitHub Actions
- **Multi-Environment Deployment** (Test/Production)
- **Azure Cloud Integration** with OIDC authentication

## Architecture Overview

```
├── .github/workflows/       # GitHub Actions CI/CD Pipelines
│   ├── terraform-static-analysis.yml    # Code quality & security
│   ├── infra-ci-cd.yml                  # PR validation & planning
│   ├── infra-ci-cd-terraformapply.yml   # Infrastructure deployment
│   ├── build-push-weather-app.yml       # Docker build & push
│   └── deploy-remix-to-aks.yml          # AKS application deployment
│
├── infra/                   # Terraform Infrastructure
│   ├── main.tf             # Root module configuration
│   ├── variables.tf        # Input variables
│   ├── outputs.tf          # Output values
│   ├── terraform.tfvars    # Variable values
│   │
│   ├── backend/            # Terraform State Management
│   │   ├── main.tf         # Azure Storage for remote state
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── network/            # Base Network Infrastructure
│   │   ├── main.tf         # VNet with 4 subnets
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── aks/                # Kubernetes Clusters
│   │   ├── main.tf         # Test & Production AKS clusters
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── remix-weather/      # Application Infrastructure
│       ├── main.tf         # Azure Container Registry & Redis
│       ├── variables.tf
│       └── outputs.tf
│
├── pulumi-app/             # Remix Weather Application
│   ├── Dockerfile          # Container configuration
│   ├── package.json        # Node.js dependencies
│   ├── app/                # Remix application code
│   └── public/             # Static assets
│
└── k8s/                    # Kubernetes Manifests
    └── remix-weather-deployment.yaml    # Application deployment
```

##  Azure Resources Created

### Network Infrastructure
- **Virtual Network**: 10.0.0.0/14 address space in Canada Central
- **Subnets**: 
  - Production: 10.0.0.0/16
  - Test: 10.1.0.0/16 
  - Development: 10.2.0.0/16
  - Admin: 10.3.0.0/16

### Compute Resources
- **AKS Clusters**: 
  - Test environment (1 node, Kubernetes v1.32.6)
  - Production environment (2 nodes, Kubernetes v1.32.6)
- **Node Size**: Standard_B2s 
- **Auto-scaling**: Enabled with environment-specific limits

### Container & Storage
- **Azure Container Registry**: Basic SKU with admin access
- **Redis Cache**: For application caching (test & production instances)
- **Storage Account**: Terraform state management with blob storage

### Security & Authentication
- **Azure OIDC Integration**: Passwordless authentication for GitHub Actions
- **Service Principals**: Contributor and Reader roles with federated credentials
- **Managed Identities**: For AKS cluster authentication


### GitHub Actions Workflows
#### 1. Terraform Static Analysis
- **Trigger**: Push to any branch
- **Actions**: `terraform fmt`, `terraform validate`, `tfsec` security scanning
- **Matrix Strategy**: Tests across multiple Terraform versions

#### 2. Infrastructure PR Validation
- **Trigger**: Pull request to main branch
- **Actions**: TFLint validation, terraform plan with cost estimation
- **Features**: PR commenting with plan details

#### 3. Infrastructure Deployment
- **Trigger**: Push to main branch (after PR merge)
- **Actions**: `terraform apply` with automatic state management
- **Features**: Enhanced state lock handling, retry mechanisms

#### 4. Docker Build & Push
- **Trigger**: PR to main with changes to `pulumi-app/**`
- **Actions**: Build Docker image, push to ACR, security scanning
- **Features**: Multi-tag strategy (SHA, short SHA, latest)

#### 5. AKS Application Deployment
- **Trigger**: 
  - **Test Environment**: PR to main with app changes
  - **Production Environment**: Push to main with app changes
- **Actions**: Deploy to respective AKS clusters using existing K8s manifests
- **Features**: Environment-specific configuration, health checks

## 🛠️ Prerequisites

### Required Tools
- **Azure CLI** (authenticated with your subscription)
- **Terraform** >= 1.0
- **Docker** (for local testing)
- **kubectl** (for Kubernetes management)
- **Git** for version control


##  Getting Started

### 1. Clone Repository
```bash
git clone https://github.com/mishsamir/Final-Project-CST8918_Group6.git
cd Final-Project-CST8918_300
```

### 2. Configure Azure Authentication

#### Create Service Principals
```bash
# Create Contributor service principal
az ad sp create-for-rbac --name "CST8918-Final-Contributor" \
  --role Contributor \
  --scopes /subscriptions/YOUR_SUBSCRIPTION_ID

# Create Reader service principal  
az ad sp create-for-rbac --name "CST8918-Final-Reader" \
  --role Reader \
  --scopes /subscriptions/YOUR_SUBSCRIPTION_ID
```

#### Configure GitHub Secrets
Add the following secrets to your GitHub repository:
- `AZURE_CLIENT_ID`: Service principal client ID
- `AZURE_TENANT_ID`: Azure tenant ID
- `AZURE_SUBSCRIPTION_ID`: Azure subscription ID
- `ARM_ACCESS_KEY`: Storage account access key (for Terraform state)
- `WEATHER_API_KEY`: OpenWeatherMap API key (optional)

