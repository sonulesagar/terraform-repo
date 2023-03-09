variable "vpc_cidr_block" {
    type = string
}

variable "public_cidr_block" {
    type = list
}

variable "private_cidr_block" {
    type = list
}

variable "availability_zone" {
    type = list(string)
}

variable "appname" {
    type = string
}

variable "tags" {
    type = map(string)
    default = {}
}

variable "env" {
    type = string
}