
# wise-cow
Wise cow is a fun web app that shows random quotes inside a cow-style animation
=======
# Wisecow Application - Kubernetes Deployment

A containerized web application that serves random fortune quotes with cowsay, deployed on Kubernetes with TLS support.

## 🚀 Features

- Random fortune quotes displayed with ASCII cow art
- Containerized with Docker
- Kubernetes deployment with high availability
- Automated CI/CD pipeline with GitHub Actions
- Secure TLS/HTTPS communication

## 📋 Prerequisites

- Docker
- Kubernetes cluster (Minikube/Kind)
- kubectl CLI
- GitHub account
- Docker Hub account

## 🏗️ Architecture
GitHub → GitHub Actions → Docker Hub → Kubernetes Cluster
├── Deployment (2 replicas)
├── Service (NodePort)
└── Ingress (TLS)

## 🛠️ Local Development

### Build and Run with Docker

Build image
docker build -t wisecow:v1 .

Run container
docker run -d -p 4499:4499 wisecow:v1

Test
curl http://localhost:4499

text

## ☸️ Kubernetes Deployment

### Setup Kubernetes Cluster

Using Minikube
minikube start --driver=docker
minikube addons enable ingress

text

### Deploy Application

Apply manifests
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

Verify deployment
kubectl get pods
kubectl get svc

text

### Setup TLS

Generate self-signed certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048
-out wisecow-tls.crt
-keyout wisecow-tls.key
-subj "/CN=wisecow.local/O=wisecow"

Create Kubernetes secret
kubectl create secret tls wisecow-tls-secret
--cert=wisecow-tls.crt
--key=wisecow-tls.key

Apply ingress
kubectl apply -f k8s/ingress.yaml

Add to /etc/hosts
echo "$(minikube ip) wisecow.local" | sudo tee -a /etc/hosts

Access via HTTPS
curl -k https://wisecow.local

text

## 🔄 CI/CD Pipeline

The GitHub Actions workflow automatically:
1. Builds Docker image on every push to main
2. Pushes image to Docker Hub
3. Tags with commit SHA and 'latest'

## 📁 Project Structure

wisecow/
├── .github/
│ └── workflows/
│ └── docker-build-push.yaml
├── k8s/
│ ├── deployment.yaml
│ ├── service.yaml
│ └── ingress.yaml
├── Dockerfile
├── wisecow.sh
├── README.md
└── .gitignore

text

## 🧪 Testing

Check deployment status
kubectl get all

View logs
kubectl logs -l app=wisecow

Test service
kubectl port-forward svc/wisecow-service 8080:80
curl http://localhost:8080

text

## 🔧 Troubleshooting

**Pods not starting:**
kubectl describe pod <pod-name>
kubectl logs <pod-name>

text

**Service not accessible:**
kubectl get svc
minikube service wisecow-service --url
