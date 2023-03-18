variable "internal" {
    type = string
}

variable "load-balancer-type" {
    type = string
}

variable "appname" {
    type = string
}

variable "env" {
    type = string
}

variable "tags" {
    type = map(string)
    default = {}
}

variable "security_groups" {
    type = set(string)
}

variable "subnets" {
    type = list(string)
}

variable "vpc_id" {
  type = string
}
