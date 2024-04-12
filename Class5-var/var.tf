variable region {
  type = string
  description = "Provide region"
}

variable vpc_cidr {
  type = string
  description = "provide vpc cidr block"
}

variable subnet_cidr {
  type = list(object({
    cidr = string
    subnet_name = string
  }))
  
}
