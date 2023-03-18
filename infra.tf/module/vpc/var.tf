variable "vpc_cidr_block" {
    type = string
}

variable "public_cidr_block" {
    type = list(any)
}

variable "private_cidr_block" {
    type = list(any)
}

variable "availability_zone" {
    type = list(string)
}

variable "appname" {
    type = string
}

variable "tags" {
    type = map(string)
}

variable "env" {
    type = string
}

