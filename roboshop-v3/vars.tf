variable "security_groups" {
  default = [ "sg-0bd976be7cb94bf14" ]
}

variable "zone_id" {
  default = "Z071049823D2ODLIT0YW9"
}

variable "components" {
  default = {
    frontend ={
      name = "frontend"
      instance_type = "t3.micro"
    }
    cart = {
      name = "cart"
      instance_type = "t3.micro"

    }
  }
}