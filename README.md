# AWS Production-Style ALB Architecture with Terraform

A hands-on AWS infrastructure project built using **Terraform**, focused on path-based application routing, high availability, private EC2 infrastructure, monitoring, alerting, and automatic scaling.

The project demonstrates how AWS networking, load balancing, compute, monitoring, and scaling can be integrated into a single cloud architecture and managed as Infrastructure as Code.

---

## 🏗️ Architecture

The architecture uses an **internet-facing Application Load Balancer (ALB)** as the single entry point for three application services.

Traffic is routed based on the request path:

| Request Path | Application |
|---|---|
| `/` | Homepage |
| `/images` | Images |
| `/register` | Registration |

Each application runs on EC2 instances managed through its own Auto Scaling Group.

The EC2 instances are deployed in private subnets across multiple Availability Zones.

<img width="1536" height="1024" alt="ChatGPT Image Aug 11, 2026 at 11_58_57 PM" src="https://github.com/user-attachments/assets/70c8108f-5bbe-48b0-98b5-949608f9b0a2" />


---

## ☁️ AWS Services Used

- **Amazon VPC** – Network isolation and subnet architecture
- **Internet Gateway** – Internet connectivity for public resources
- **NAT Gateway** – Outbound internet access for private EC2 instances
- **Application Load Balancer** – Internet-facing traffic distribution
- **Target Groups** – Routing traffic to individual applications
- **EC2** – Application compute
- **Auto Scaling Groups** – Automatic compute scaling
- **CloudWatch** – Infrastructure and application monitoring
- **CloudWatch Alarms** – Health and performance alerting
- **Amazon SNS** – Email notifications
- **Nginx** – Web server running on EC2
- **Terraform** – Infrastructure as Code

---

# 🔀 Path-Based Routing

The Application Load Balancer routes requests according to their URL path.

```text
                         Internet
                            |
                            v
                  Application Load Balancer
                            |
             +--------------+--------------+
             |              |              |
             v              v              v
             /           /images       /register
             |              |              |
             v              v              v
       Homepage TG     Images TG      Register TG
             |              |              |
             v              v              v
          Home ASG       Images ASG    Register ASG
             |              |              |
             v              v              v
           EC2s           EC2s           EC2s
```

This allows three different application services to be accessed through a single ALB while keeping their backend compute resources separated.

# 🌐 Network Architecture
The infrastructure is deployed inside an Amazon VPC.
The network is divided into public and private subnets.

# Public Subnets
The public subnets host the internet-facing Application Load Balancer.
The Internet Gateway provides connectivity between the public subnet and the internet.

# Private Subnets
The application EC2 instances are deployed in private subnets.
The EC2 instances do not have public IP addresses.

Private instances can access the internet for required outbound operations through a NAT Gateway.

```
Internet
   |
   v
Internet Gateway
   |
   v
Public Subnets
   |
   v
Application Load Balancer
   |
   +-----------------------------+
   |              |              |
   v              v              v
Private         Private        Private
Subnet          Subnet         Subnet
   |              |              |
 Home ASG      Images ASG    Register ASG
   |              |              |
  EC2s           EC2s          EC2s
   |
   +----------> NAT Gateway
```

# ⚖️ High Availability

The application infrastructure is distributed across multiple Availability Zones.
Each application has its own Auto Scaling Group and Target Group.

                    Application Load Balancer
                              |
          +-------------------+-------------------+
          |                   |                   |
        AZ-A                AZ-B                AZ-C
          |                   |                   |
      Private              Private             Private
      Subnet               Subnet              Subnet
          |                   |                   |
       EC2s                 EC2s                 EC2s

Distributing compute resources across Availability Zones improves application availability and reduces dependency on a single Availability Zone.

# 📈 Auto Scaling
Each application has an independent Auto Scaling Group.
The project uses Target Tracking Scaling based on average EC2 CPU utilization.

The configured target is:

Average CPU Utilization = 70%
The Auto Scaling Groups can automatically adjust capacity based on workload.

                  Auto Scaling Group
                          |
                  Target Tracking
                          |
                    CPU Target 70%
                       /       \
                      /         \
               Scale Out      Scale In
                  |                |
              Add EC2          Remove EC2
        
The three Auto Scaling Groups are:
Homepage ASG
Images ASG
Register ASG
Each ASG has its own scaling policy.

# 📊 Monitoring
Amazon CloudWatch is used to monitor the infrastructure.
The current monitoring configuration includes:

Application Load Balancer
HTTP 5XX responses
Target Groups
Homepage target health
Images target health
Register target health
EC2 / Auto Scaling Groups
CPU utilization
CloudWatch provides visibility into the health and performance of the infrastructure.

# 🔔 Alerting with SNS

CloudWatch alarms are connected to an Amazon SNS topic for email notifications.

              CloudWatch Metric
                     |
                     v
              CloudWatch Alarm
                     |
                     v
                    SNS
                     |
                     v
              Email Notification
              
The SNS email subscription has been confirmed.
This allows important infrastructure events to generate notifications automatically.

# 🚦 Health Checks
Each Target Group has a configured health-check endpoint.
Homepage  → /
Images    → /images
Register  → /register
The ALB uses these health checks to determine whether backend instances are available to receive traffic.
Note: The /images and /register endpoints currently return HTTP 301 during the ALB health check, which is a known configuration issue being kept for later improvement. The application routes themselves are working correctly.

# 🏗️ Infrastructure as Code
The complete infrastructure is managed using Terraform.
Terraform is used to define and manage:

VPC
Subnets
Internet Gateway
NAT Gateway
Route Tables
Security Groups
Application Load Balancer
Target Groups
Listener Rules
Launch Templates
EC2 instances through Auto Scaling Groups
CloudWatch alarms
SNS
Auto Scaling policies
Typical Terraform workflow:
terraform init
terraform validate
terraform plan
terraform apply
To destroy the infrastructure:
terraform plan -destroy
terraform destroy


# 📁 Project Structure

Production-ALB/
│
├── autoscaling.tf
├── aws_lb.tf
├── data.tf
├── igw.tf
├── launch_template.tf
├── listener.tf
├── locals.tf
├── monitoring.tf
├── nat_gateway.tf
├── output.tf
├── provider.tf
├── route_table.tf
├── scaling.tf
├── security_groups.tf
├── subnet.tf
├── target_group.tf
├── variables.tf
├── vpc.tf
│
├── userdata/
│   ├── home.sh
│   ├── images.sh
│   └── register.sh
│
├── .gitignore
├── .terraform.lock.hcl
└── README.md
Terraform state files and local Terraform working directories are excluded from version control.

# 🔐 Security

The architecture follows basic network security principles:
EC2 instances are deployed without public IP addresses
Application traffic enters through the ALB
Backend EC2 instances are isolated in private subnets
Security Groups control traffic between the ALB and EC2 instances
NAT Gateway provides controlled outbound internet connectivity
The infrastructure is managed through version-controlled Terraform configuration

# 🧪 Testing

The following components have been tested:
ALB connectivity
Homepage routing
/images routing
/register routing
Target Group configuration
EC2 application availability
CloudWatch alarms
SNS topic
SNS email subscription
Target Tracking Auto Scaling configuration

# 🎯 Project Objectives

The main objective of this project is to gain practical experience designing and managing AWS infrastructure using Terraform.

The project focuses on:

AWS networking
Public and private subnet architecture
Application Load Balancing
Path-based routing
High availability
Auto Scaling
Infrastructure monitoring
CloudWatch alarms
SNS notifications
Infrastructure as Code

# 🚀 Future Improvements
Planned improvements include:
Complete scale-out and scale-in testing
Improve ALB health-check configuration
Further Terraform modularization
Introduce CI/CD for infrastructure deployment
Introduce Terraform remote state management
Add additional observability
Further security hardening

# 🛠️ Technology Stack
AWS
Terraform
Linux
Nginx
EC2
Application Load Balancer
Auto Scaling
VPC
CloudWatch
SNS
Git
Bash


Build → Automate → Monitor → Scale → Improve
