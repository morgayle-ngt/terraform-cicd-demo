# output "instance" {
#     value = aws_instance.myapp-server.instance.public_ip
# }
output "ec2_public_ip" {
    value = module.myapp-server.instance.public_ip
}