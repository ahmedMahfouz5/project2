# CloudForge - AWS Infrastructure-as-Code

A comprehensive Terraform-based Infrastructure-as-Code (IaC) solution for deploying and managing scalable AWS infrastructure with Jenkins CI/CD integration.

## 🎯 Project Overview

CloudForge is a production-ready Terraform project that automates the deployment of a complete AWS infrastructure stack including networking, security, compute resources, and databases. It leverages Jenkins for continuous integration and continuous deployment (CI/CD) pipelines.

## 📋 Features

- **VPC & Networking**: Multi-AZ VPC setup with public and private subnets
- **Security Groups**: Isolated security policies for EC2 and database access
- **Compute**: EC2 instance provisioning with customizable AMI and instance types
- **Load Balancing**: Application Load Balancer (ALB) with target group routing
- **Database**: RDS database deployment with configurable parameters
- **CI/CD Integration**: Jenkins pipeline for automated Terraform workflows
- **Modular Architecture**: Organized Terraform modules for easy maintenance and reusability

## 🏗️ Architecture

```
CloudForge Infrastructure Stack
├── Networking Module
│   └── VPC, Subnets, Route Tables, IGW
├── Security Module
│   └── Security Groups for EC2 and RDS
├── Compute Module
│   └── EC2 Instances with templates
├── Load Balancing Module
│   └── ALB and Target Groups
└── Database Module
    └── RDS Instance Configuration
```

## 📁 Project Structure

```
project2/
├── infra/                      # Terraform configuration root
│   ├── main.tf                 # Main module definitions
│   ├── variables.tf            # Input variables
│   ├── terraform.tfvars        # Variable values
│   ├── provider.tf             # AWS provider configuration
│   ├── compute/                # EC2 compute module
│   ├── security-groups/        # Security group module
│   ├── networking/             # VPC and networking module
│   ├── load-balancer/          # ALB module
│   ├── lb-target-group/        # Target group module
│   ├── rds/                    # Database module
│   ├── template/               # Bootstrap scripts and templates
│   └── README.md              # Infrastructure documentation
├── Jenkinsfile                 # CI/CD pipeline definition
└── README.md                   # This file
```

## 🚀 Getting Started

### Prerequisites

- **Terraform** >= 1.0
- **AWS Account** with appropriate IAM permissions
- **Jenkins** (for CI/CD automation)
- **AWS CLI** configured with credentials

### Installation

1. Clone the repository:
```bash
git clone https://github.com/ahmedMahfouz5/project2.git
cd project2
```

2. Navigate to the infrastructure directory:
```bash
cd infra
```

3. Initialize Terraform:
```bash
terraform init
```

### Configuration

1. Edit `terraform.tfvars` to customize your deployment:
```hcl
vpc_cidr              = "10.0.0.0/16"
vpc_name              = "production-vpc"
cidr_public_subnet    = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet   = ["10.0.10.0/24", "10.0.11.0/24"]
us_availability_zone  = ["us-east-1a", "us-east-1b"]
ec2_ami_id            = "ami-XXXXXXXXX"  # Amazon Linux 2023
instance_type         = "t3.micro"
public_key            = "ssh-rsa XXXXXX"
```

### Deployment

#### Manual Deployment

```bash
# Plan the infrastructure changes
terraform plan

# Apply the configuration
terraform apply
```

#### Jenkins CI/CD Pipeline

The project includes a Jenkins pipeline (`Jenkinsfile`) for automated deployments:

1. **Terraform Plan**: Review proposed infrastructure changes
2. **Terraform Apply**: Deploy infrastructure to AWS
3. **Terraform Destroy**: Tear down resources (if needed)

Configure Jenkins parameters:
- `PLAN_TERRAFORM`: Execute terraform plan
- `APPLY_TERRAFORM`: Execute terraform apply
- `DESTROY_TERRAFORM`: Execute terraform destroy

## 📊 Terraform Variables

| Variable | Type | Description |
|----------|------|-------------|
| `vpc_cidr` | string | VPC CIDR block |
| `vpc_name` | string | VPC name/tag |
| `cidr_public_subnet` | list(string) | Public subnet CIDR blocks |
| `cidr_private_subnet` | list(string) | Private subnet CIDR blocks |
| `us_availability_zone` | list(string) | Availability zones |
| `ec2_ami_id` | string | AMI ID for EC2 instances |
| `instance_type` | string | EC2 instance type (e.g., t3.micro) |
| `public_key` | string | SSH public key for EC2 access |

## 🔒 Security Considerations

- Security groups are configured to restrict access:
  - SSH (port 22), HTTPS (443), HTTP (80) for EC2
  - Jenkins access on port 8080
  - Database access restricted to private subnets
- RDS database deployed in private subnets
- Public subnets contain load balancers and frontend resources
- Sensitive data should be managed via environment variables or AWS Secrets Manager

## 📝 Modules Documentation

For detailed information about each module, see:
- [Infrastructure README](./infra/README.md)

## 🔄 CI/CD Workflow

The Jenkins pipeline automates:
1. Repository cloning
2. Terraform initialization
3. Plan generation and review
4. Infrastructure provisioning
5. Resource destruction (on-demand)

## 🛠️ Troubleshooting

### Common Issues

**State Lock Error**: If Terraform state is locked, manually unlock:
```bash
terraform force-unlock <LOCK_ID>
```

**AWS Credentials Error**: Ensure AWS credentials are configured:
```bash
aws configure
```

**Terraform Plan Failures**: Validate configuration:
```bash
terraform validate
```

## 📚 Useful Commands

```bash
# Validate Terraform configuration
terraform validate

# Format Terraform files
terraform fmt -recursive

# Destroy all resources
terraform destroy

# View current state
terraform show

# List resources in state
terraform state list
```

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Test thoroughly
4. Submit a pull request

## 📄 License

This project is open source and available under the MIT License.

## 👨‍💼 Author

Ahmed Mahfouz (@ahmedMahfouz5)

## 📞 Support

For issues, feature requests, or questions, please open a GitHub issue or contact the project maintainer.

---

**Last Updated**: 2026-06-21