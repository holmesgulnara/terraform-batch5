variable region {
  type = string
  description = "Provide region"
}

variable vpc_cidr {
  type = string
  description = "provide vpc cidr block"
}

variable subnet1_cidr {
  type = string
  description = "provide subnet1 cidr block"
}

variable subnet2_cidr {
  type = string
  description = "provide subnet2 cidr block"
}

variable subnet3_cidr {
  type = string
  description = "provide subnet3 cidr block"
}

variable subnet1_name {
  type = string
  description = "Provide subnet1 name"
}

variable subnet2_name {
  type = string
  description = "Provide subnet2 name"
}

variable subnet3_name {
  type = string
  description = "Provide subnet3 name"
}

variable ip_on_launch {
    type = bool  
}

variable "ports" {
  description = "Provide list of  ports"
  type = list(object({
    from_port = number
    to_port   = number
  }))
}

# variable "enable_blue_env" {
#   description = "Enable blue environment"
#   type        = bool
#   default     = true
# }

variable key_name {
  type = string
  description = "Provide key name"
}

variable load_balancer_name {
    type = string
    description = "Provide LB name"
}

variable load_balancer_type {
  type = string
  description = "Provide LB type"
}

variable lb_listener_port {
    type = number
    description = "Provide LB listener port"
}

variable lb_listener_protocol {
    type = string
    description = "Provide LB listener Protocol"
}

data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20240329.0-x86_64-gp2"]
  }

  owners = ["137112412989"] # Canonical
}

variable lb_tg_ports {
  type = list
  description = "Provide LB TG ports"
}

variable lb_tg_protocol {
  type = list
  description = "Provide LB TG protocol"
}

variable instance_type {
    type = string
    description = "Provide Instance type"
}