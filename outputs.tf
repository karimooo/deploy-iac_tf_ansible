output "amiId-eu-west-3" {
  value = data.aws_ssm_parameter.linuxAmi.value
}

output "amiId-eu-west-1" {
  value = data.aws_ssm_parameter.linuxAmiIreland.value
}
output "Jenkins-Main-Node-Public-IP" {
  value = aws_instance.jenkins-master.public_ip
}
output "Jenkins-Main-Node-Private-IP" {
  value = aws_instance.jenkins-master.private_ip
}
output "Jenkins-Worker-Public-IPs" {
  value = {
    for instance in aws_instance.jenkins-worker-ireland :
    instance.id => instance.public_ip
  }
}
output "Jenkins-Worker-Private-IPs" {
  value = {
    for instance in aws_instance.jenkins-worker-ireland :
    instance.id => instance.private_ip
  }
}

#LB DNS name to outputs.tf
output "LB-DNS-NAME" {
  value = aws_lb.application-lb.dns_name
}

output "url" {
  value = aws_route53_record.jenkins.fqdn
}
