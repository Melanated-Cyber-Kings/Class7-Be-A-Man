# Class 7 Week 6 Be A Man Challenge

## 📋 Assignment Overview

This project demonstrates the use of Terraform's `trim_iam_role_path` function.

### Assignment Requirements Completed

✅ **Function Explored**: `trim_iam_role_path` - trims the path prefix from an IAM role Amazon Resource Name (ARN)  
✅ **Data Manipulation**: This function can be used when services require role ARNs to be passed without a path  
✅ **Output Blocks**: Created multiple outputs displaying JSON results in CLI  
✅ **Terraform Console**: Used interactive console to explore and test the function  
✅ **AWS Data Sources**: Integrated AWS provider data sources as function arguments  
✅ **GitHub Repository**: Includes all code, configurations, and documentation

## 🛠️ Function Demonstration: `trim_iam_role_path`

### What is trim_iam_role_path?
The `trim_iam_role_path` trims the path prefix from an IAM role Amazon Resource Name (ARN). This function can be used when services require role ARNs to be passed without a path.

### Code Examples
# result: arn:aws:iam::444455556666:role/example
output "example" {
  value = provider::aws::trim_iam_role_path("arn:aws:iam::444455556666:role/with/path/example")
}