# ==============================================================================
# ESSENTIAL LOCAL VALUES FOR INFRASTRUCTURE
# ==============================================================================

# Data sources
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}

# Core infrastructure locals
locals {
  region   = "us-east-1"
  env      = "dev"
  eks_name = "security"
  zone1    = data.aws_availability_zones.available.names[0]
  zone2    = data.aws_availability_zones.available.names[1]
}

# ==============================================================================
# JSONENCODE FUNCTION DEMONSTRATION
# ==============================================================================

locals {
  # Basic jsonencode test
  basic_test = jsonencode({
    test    = "success"
    account = data.aws_caller_identity.current.account_id
    region  = local.region
  })

  # EKS AMI security data
  eks_ami_security = jsonencode({
    source_ami = {
      id    = data.aws_ami.eks_optimized.id
      name  = data.aws_ami.eks_optimized.name
      owner = data.aws_ami.eks_optimized.owners[0]
    }
    security_attributes = {
      encrypted = true
      trusted   = data.aws_ami.eks_optimized.owners[0] == "amazon"
    }
  })

  # Assignment demonstration 1: Basic jsonencode
  jsonencode_demo_1 = jsonencode({
    function    = "jsonencode"
    assignment  = "Terraform Functions"
    student     = "Your Name"
    timestamp   = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
    status      = "working with AWS data sources"
  })

  # Assignment demonstration 2: Using AWS data sources
  jsonencode_demo_2 = jsonencode({
    aws_environment = {
      account_id    = data.aws_caller_identity.current.account_id
      account_arn   = data.aws_caller_identity.current.arn
      region        = data.aws_region.current.name
      available_azs = data.aws_availability_zones.available.names
    }
    assignment_info = {
      terraform_function = "jsonencode"
      purpose           = "encode values as JSON strings"
      documentation     = "https://developer.hashicorp.com/terraform/language/functions/jsonencode"
    }
  })

  # Assignment demonstration 3: Complex security finding template
  jsonencode_demo_3 = jsonencode({
    security_finding = {
      schema_version = "2024-01-01"
      findings = [
        {
          id          = "TF-JSONENCODE-001"
          severity    = "INFO"
          title       = "Terraform jsonencode Function Working"
          description = "Successfully demonstrated jsonencode with AWS data sources"
          resources = [
            {
              type = "AWS::Account"
              id   = data.aws_caller_identity.current.account_id
            },
            {
              type = "AWS::Region"
              id   = data.aws_region.current.name
            }
          ]
        }
      ]
    }
  })

  # OPA Policy Template for Kubernetes Security
  opa_policy_template = jsonencode({
    apiVersion = "templates.gatekeeper.sh/v1beta1"
    kind       = "ConstraintTemplate"
    metadata = {
      name = "k8srequiredsecuritylabels"
    }
    spec = {
      crd = {
        spec = {
          names = {
            kind = "K8sRequiredSecurityLabels"
          }
        }
      }
      targets = [
        {
          target = "admission.k8s.gatekeeper.sh"
          rego = <<REGO
package k8srequiredsecuritylabels
violation[{"msg": msg}] {
  not input.review.object.metadata.labels["security-tier"]
  msg := "All pods must have a security-tier label"
}
REGO
        }
      ]
    }
  })

  # Security Policy Bundle for Multi-Cloud Platform
  security_policy_bundle = jsonencode({
    version = "1.0"
    policies = {
      kubernetes = {
        opa_policies = [
          {
            name = "require-security-labels"
            description = "All K8s resources must have security labels"
          }
        ]
      }
    }
  })
}

# Outputs
output "basic_test_output" {
  value = local.basic_test
}

output "eks_ami_output" {
  value = local.eks_ami_security
}

output "infrastructure_locals" {
  value = {
    region   = local.region
    env      = local.env
    eks_name = local.eks_name
    zone1    = local.zone1
    zone2    = local.zone2
  }
}

output "jsonencode_basic_demo" {
  description = "Basic jsonencode demonstration for assignment"
  value       = local.jsonencode_demo_1
}

output "jsonencode_aws_data_demo" {
  description = "jsonencode with AWS data sources for assignment"
  value       = local.jsonencode_demo_2
}

output "jsonencode_complex_demo" {
  description = "Complex security finding using jsonencode"
  value       = local.jsonencode_demo_3
}

output "opa_policy_template" {
  description = "OPA Gatekeeper policy template for K8s security"
  value       = local.opa_policy_template
}

output "security_policy_bundle" {
  description = "Complete security policy bundle for multi-cloud platform"
  value       = local.security_policy_bundle
}

output "assignment_success" {
  value = "JSONENCODE FUNCTION ASSIGNMENT READY FOR SUBMISSION"
}
