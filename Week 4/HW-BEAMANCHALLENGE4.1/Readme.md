# AWS VPC with Bastion Host and Web Servers

A Terraform project that creates a secure VPC infrastructure with a bastion host and multiple web servers across different availability zones.

## Architecture Overview

- **1 VPC** with CIDR 10.32.0.0/16
- **1 Public Subnet** in eu-west-1a (for bastion host)
- **3 Private Subnets** in eu-west-1a, eu-west-1b, eu-west-1c
- **1 Bastion Host** (Ubuntu) in public subnet
- **3 Web Servers** - one in each private subnet/AZ
- Each web server runs nginx with unique content

## Prerequisites

- AWS account with appropriate permissions
- Terraform installed
- AWS CLI configured (optional, but recommended)

## Quick Start

### 1. Clone the Repository
```bash
git clone <my-repo-url>
cd <project-directory>
```

### 2. Create an AWS Key Pair

**Via AWS Console:**
1. Navigate to AWS Console → EC2 → Key Pairs
2. Click "Create key pair"
3. Name: `my-project-key` (or any preferred name)
4. Key pair type: RSA
5. Private key file format: .pem
6. Click "Create key pair"
7. Save the downloaded `.pem` file securely

**Via AWS CLI:**
```bash
aws ec2 create-key-pair --key-name "my-project-key" --query 'KeyMaterial' --output text > my-project-key.pem
chmod 400 my-project-key.pem
```

### 3. Configure Your Key

Edit `key.tf` and update the key name to match what you created:

```hcl
data "aws_key_pair" "example" {
  key_name = "my-project-key"  # Change to your actual key pair name
}
```

### 4. Deploy the Infrastructure

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

## Verification

After deployment completes (5-10 minutes), verify all instances are running:

```bash
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query 'Reservations[].Instances[].[InstanceId,State.Name,PrivateIpAddress,PublicIpAddress,Tags[?Key==`Name`].Value[0]]' --output table
```

You should see 4 running instances:
- `bastion-host` (with Public IP)
- `app-server-1` (private IP only)
- `app-server-2` (private IP only) 
- `app-server-3` (private IP only)

## Testing Connectivity (Optional)

```bash
# Get bastion public IP
BASTION_IP=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=bastion-host" "Name=instance-state-name,Values=running" --query 'Reservations[].Instances[].PublicIpAddress' --output text)

# SSH to bastion
ssh -i my-project-key.pem ubuntu@$BASTION_IP
```

## Customization

### Change AWS Region
Edit `0-Auth.tf`:
```hcl
provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}
```

## Clean Up

To avoid ongoing charges, destroy all resources when finished:

```bash
terraform destroy -auto-approve
```

## Project Structure

```
.
├── 0-Auth.tf                 # AWS provider configuration
├── 1-VPC.tf                  # VPC creation
├── 2-Subnets.tf              # Public and private subnets
├── 3-IGW.tf                  # Internet Gateway
├── 4-NAT.tf                  # NAT Gateway
├── 5-Route.tf                # Route tables
├── 6-SG01-All.tf             # Security groups
├── 11-Key.tf                 # Key pair reference (only file to modify)
├── 14-bastion.tf             # Bastion host configuration
├── 15-servers.tf             # Web servers with unique content
└── 16-data-sources.tf        # AMI data sources
```

## Notes

- Only one modification required: update the key name in `key.tf`
- Web servers automatically install nginx with unique Star Wars planet content
- Private servers are only accessible via the bastion host for security
- Deployment typically takes 5-10 minutes
- Remember to run `terraform destroy` when finished to avoid unnecessary charges

## Security

- Bastion host acts as the only entry point to private instances
- Private subnets have no direct internet access
- Security groups restrict access to necessary ports only
