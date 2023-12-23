### Project Overview
The Coworking Space Service provides APIs for managing access to coworking spaces, facilitating token generation and validation through a microservices architecture.

 ## Setting up Postgresql
Add the Bitnami repository to Helm and install PostgreSQ using the following commands:
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install coworking-service-db bitnami/postgresql

Connect to the Postgresql service and Execute SQL scripts to create tables and seed data:
Get-Content 1_create_tables.sql | psql --host 127.0.0.1 -U postgres -d postgres -p 5432
Get-Content 2_seed_users.sql | psql --host 127.0.0.1 -U postgres -d postgres -p 5432
Get-Content 3_seed_tokens.sql | psql --host 127.0.0.1 -U postgres -d postgres -p 5432

### Application Deployment Process
The deployment process involves automatically building the Flask application into a Docker image using AWS CodeBuild upon code commits to GitHub, followed by pushing the image to AWS ECR. The buildspec.yml file defines a three-phase AWS CodeBuild process for logging into ECR, building and tagging a Docker image of the Coworking app, and then pushing it to an AWS ECR repository. 

Kubernetes then can pull this image from ECR to deploy the service in an AWS EKS cluster with the following commands:

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

The deployment.yaml file defines a Kubernetes deployment for the analytics app, specifying two replicas with container configurations, including an ECR-hosted image and environment variables sourced from a ConfigMap, a Secret, and a direct value assignment. The service.yaml file configures a Kubernetes service for the analytics app, creating a LoadBalancer to route external TCP traffic on port 80 to the target port 5153 of pods labeled with app: analytics.
 
 ### Configuration Management
Environment variables are managed using Kubernetes ConfigMaps and Secrets, ensuring secure and dynamic configuration of the application.

kubectl create secret generic db-secret --from-literal=DB_PASSWORD=xxx
kubectl create configmap db-config --from-literal=DB_USERNAME=postgres --from-literal=DB_HOST=127.0.0.1 --from-literal=DB_PORT=5432 --from-literal=DB_NAME=postgres

### Monitoring and Logging
The application uses AWS CloudWatch for real-time monitoring and logging, accessible via the AWS Management Console.

### Versioning and Repository Structure
The GitHub repository allows versioning with automated build and deployment triggered by code commits.

## Overview of used technlogies and infrstructure in this Repo
Python
Flask
PostgreSQL
Docker
AWS CodeBuild
AWS Elastic Container Registry (ECR)
Amazon Elastic Kubernetes Service (EKS)
Kubernetes
Helm
AWS CloudWatch
GitHub
PowerShell 




