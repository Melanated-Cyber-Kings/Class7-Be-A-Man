output "example" {
  value = provider::aws::trim_iam_role_path("arn:aws:iam::031857855861:role/aws-service-role/access-analyzer.amazonaws.com/AWSServiceRoleForAccessAnalyzer")
}