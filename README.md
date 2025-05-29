# appscrip

This repository contains infrastructure-as-code and Kubernetes deployment manifests for an application, managed with Terraform and delivered using ArgoCD.

## Table of Contents

- [Project Overview](#project-overview)
- [Directory Structure](#directory-structure)
- [Prerequisites](#prerequisites)
- [Setup & Installation](#setup--installation)
- [Usage](#usage)

## Project Overview

This project provides:
- Infrastructure provisioning using Terraform.
- Kubernetes manifests for deployment, service, and ingress.
- ArgoCD configuration for GitOps-based application delivery.

## Directory Structure

```
.
├── argocd/       # ArgoCD application manifest
├── manifest/     # Kubernetes manifests (Deployment, Service, Ingress)
├── terraform/    # Terraform IaC for cloud infrastructure
└── .gitignore
```

- **argocd/application.yaml**: Defines ArgoCD application and deployment configuration.
- **manifest/deployment.yaml**: Kubernetes Deployment manifest.
- **manifest/service.yaml**: Kubernetes Service manifest.
- **manifest/ingress.yaml**: Kubernetes Ingress manifest.
- **terraform/**: Contains Terraform modules and configuration files.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Access to a Kubernetes cluster
- [ArgoCD](https://argo-cd.readthedocs.io/en/stable/getting_started/)

## Setup & Installation

### 1. Infrastructure Provisioning with Terraform

```sh
cd terraform/
terraform init
terraform plan
terraform apply
```

This will provision the necessary cloud infrastructure as defined in the Terraform configuration.

### 2. Deploying to Kubernetes

Apply the Kubernetes manifests:

```sh
kubectl apply -f manifest/deployment.yaml
kubectl apply -f manifest/service.yaml
kubectl apply -f manifest/ingress.yaml
```

### 3. ArgoCD Application Deployment

Apply the ArgoCD application manifest:

```sh
kubectl apply -f argocd/application.yaml
```

This will register the application with ArgoCD for continuous deployment.

## Usage

- Infrastructure is managed via Terraform.
- Application is deployed to the Kubernetes cluster using the manifests and managed by ArgoCD.
- Ingress provides external access to the deployed application.


