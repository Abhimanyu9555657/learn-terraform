data "aws_ami_ids" "ami" {
  most_recent = true
  name_regex       = "Centos-8-Devops-Practice"
  owners           = ["973714476881"]
}

output "ami" {
  value = "data.aws_ami_ids.ami"
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.id
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-0bd976be7cb94bf14"]
}