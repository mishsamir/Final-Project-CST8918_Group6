# CST8918 Final Project - Remix Weather App on Azure

This project demonstrates a complete Infrastructure as Code (IaC) solution for deploying a Remix Weather application on Azure Kubernetes Service (AKS) using Terraform.

## 🏗️ Architecture Overview

```
├── app/                     # Remix Weather Application
│   ├── Dockerfile          # Container configuration
│   ├── package.json        # Node.js dependencies
│   └── README.md           # App-specific documentation
│
└── infra/                  # Terraform Infrastructure
    ├── main.tf             # Root module
    ├── variables.tf        # Root variables
    ├── outputs.tf          # Root outputs
    ├── terraform.tfvars    # Variable values
    │
    ├── backend/            # Terraform State Management
    │   ├── main.tf         # Storage Account & Container
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── network/            # Base Network Infrastructure
    │   ├── main.tf         # VNet with 4 subnets
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── aks/                # Kubernetes Clusters
    │   ├── main.tf         # Test & Prod AKS clusters
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── remix-weather/      # Application Infrastructure
        ├── main.tf         # ACR + dedicated AKS cluster
        ├── variables.tf
        └── outputs.tf
```

## 🚀 Azure Resources Created

### Network Infrastructure
- **Virtual Network**: 10.0.0.0/14 address space
- **Subnets**: 
  - Production: 10.0.0.0/16
  - Test: 10.1.0.0/16 
  - Development: 10.2.0.0/16
  - Admin: 10.3.0.0/16

### Compute Resources
- **AKS Clusters**: 
  - Test environment (1 node, auto-scaling 1-1)
  - Production environment (1 node, auto-scaling 1-3)
  - Remix app dedicated cluster (1 node)
- **Node Size**: Standard_B2s (Azure for Students compatible)
- **Kubernetes Version**: 1.30.0

### Container Registry
- **Azure Container Registry**: Basic SKU with admin access enabled
- **Purpose**: Store Docker images for the Remix Weather application

### Backend Storage
- **Storage Account**: For Terraform state management
- **Container**: Private blob storage for .tfstate files

## 🎯 Azure for Students Compatible

This project is specifically designed for Azure for Students subscriptions:

- **Region**: Canada Central (policy compliant)
- **SKUs**: Basic/Standard tiers only
- **Cost-optimized**: Minimal node counts and sizes
- **Tagging**: Required ProjectName tags included
- **Public IP Policy**: Uses standard load balancers without policy conflicts

## 📋 Prerequisites

1. **Azure CLI** installed and authenticated
2. **Terraform** >= 1.0 installed
3. **Docker** (for building application images)
5. **Git** for version control

## 🚀 Deployment Instructions

### 1. Clone and Setup
```bash
git clone <repository-url>
cd cst8918-final-project
```

### 2. Deploy Infrastructure
```bash
cd infra

# Initialize Terraform
terraform init

# Review the deployment plan
terraform plan

# Deploy to Azure
terraform apply
```

### 3. Build and Deploy Application
```bash
cd ../app

# Get ACR login server from Terraform output
ACR_NAME=$(cd ../infra && terraform output -raw acr_name)

# Login to Azure Container Registry
az acr login --name $ACR_NAME

# Build and push Docker image
docker build -t $ACR_NAME.azurecr.io/remix-weather:latest .
docker push $ACR_NAME.azurecr.io/remix-weather:latest
```

### 4. Deploy to Kubernetes
```bash
# Get AKS credentials
az aks get-credentials --resource-group <resource-group> --name <aks-cluster-name>

# Deploy application (create your Kubernetes manifests)
kubectl apply -f k8s/
```

## 🔧 Configuration

### Key Variables (terraform.tfvars)
```hcl
location      = "Canada Central"  # Required for Azure for Students
project_name  = "cst8918"         # Used for resource naming
group_number  = "01"              # Your group identifier
environment   = "dev"             # Environment tag
```

### Environment-Specific Resources
- **Test Environment**: 1 node AKS cluster, basic configurations
- **Prod Environment**: 1-3 node auto-scaling AKS cluster
- **Shared Resources**: ACR, Virtual Network, Backend Storage

## 📊 Outputs

After deployment, Terraform provides:
- AKS cluster information (names, FQDNs, IDs)
- ACR login server and name
- Network resource details
- Backend storage information

## 🔒 Security Features

- Resource groups with proper tagging
- Private storage containers
- RBAC-enabled AKS clusters
- Managed identities for AKS
- TLS 1.2 minimum for all services

## 🧹 Cleanup

To destroy all resources:
```bash
cd infra
terraform destroy
```

## 👥 Team Information

- **Course**: CST8918 - DevOps Infrastructure
- **Project**: Final Project - Remix Weather App
- **Azure Subscription**: Azure for Students
- **Region**: Canada Central

## 📚 Learning Objectives Demonstrated

1.  Infrastructure as Code with Terraform
2.  Modular architecture design
3.  Azure Kubernetes Service deployment
4.  Container registry management
5.  Multi-environment setup (test/prod)
6.  Azure policy compliance
7. Git branching and version control
8.  Documentation and best practices

---

**Note**: This project follows Azure for Students subscription limitations and policies. All resources are configured for cost optimization and compliance with educational account restrictions.
