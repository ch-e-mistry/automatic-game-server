output "Counter_Strike_Global_Offensive_server_address" {
  description = "IP address of created cs go server."
  value       = aws_instance.csgo_ansible_instance.public_ip
}