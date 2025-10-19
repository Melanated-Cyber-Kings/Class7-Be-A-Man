
# Provide output to console for various assets.

# Also can be used to troubleshoot when running code or trying variations to
# your code.

# Provide information on Bastion EC2 Instance.

output "bastion_ip" {
  description = "Provide public IP address of bastion EC2 instance. "
  value       = ["${aws_instance.bastion-evilbox.public_ip}"]
}


output "bastion_public_dns" {
  value = aws_instance.bastion-evilbox.public_dns

}

output "bastion_instance_id" {
  description = "Provide instance ID of bastion EC2 instance."
  value = [
    aws_instance.bastion-evilbox.id
  ]

}

# Provide outputs to terminal of Linux EC2 Instances.
output "private_dns_web-svr-01" {
  description = "Provide linux web server 01 DNS name."
  value       = aws_instance.web-svr-01.private_dns

}


output "private_dns_web-svr-02" {
  description = "Provide linux web server 02 DNS name."
  value       = aws_instance.web-svr-02.private_dns

}

output "private_dns_web-svr-03" {
  description = "Provide linux web server 03 DNS name."
  value       = aws_instance.web-svr-03.private_dns

}

# Test Client IP address information 

/* output "client_ip" {
  description = "Provide client IP address"
  value       = format("%s/32", jsondecode(data.http.ipinfo.body).ip)

} */

output "workstation-external-ip" {
  description = "Provide IP address of local workstation accessing AWS VPC"
  value       = local.workstation-external-cidr

}