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
