variable "ami" {
  default = "ami-03265a0778a880afb"
}

variable "security_groups" {
  default = [ "sg-0bd976be7cb94bf14" ]
}

variable "instance_type" {
  default = "t3.small"
}

variable "zone_id" {
  default = "Z071049823D2ODLIT0YW9"
}

variable "components" {
  default = {
    frontend = { name = "frontend"}
    catalogue = { name = "catalogue"}
    mongodb = { name = "mongobd"}
    user = { name = "user"}
    redis = { name = "redis"}
    cart = { name = "cart"}
    mysql = { name = "mysql"}
    shipping = { name = "shipping"}
    payment = { name = "payment"}
    rabbitmq = { name = "rabbitmq"}
  }
}

resource "aws_instance" "instance" {
  for_each = var.components
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = var.security_groups

  tags = {
    Name = lookup(each.value, "name", null)
  }
}

resource "aws_route53_record" "records" {
  for_each = var.components
  zone_id = var.zone_id
  name    = "${lookup(each.value, "name", null)}.rdevops57online.com"
  type    = "A"
  ttl     = 30
  records = [lookup(lookup(aws_instance.instance, each.key, null), "private_ip",null) ]
}


