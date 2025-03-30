output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "application_urls" {
  description = "URLs to access the application components"
  value = {
    frontend   = "http://${aws_instance.app_server.public_ip}:8080"
    api        = "http://${aws_instance.app_server.public_ip}:5000"
    phpmyadmin = "http://${aws_instance.app_server.public_ip}:8081"
  }
}