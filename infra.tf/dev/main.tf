provider "aws" {
  profile = "sagar"
  region  = "us-west-2"
}
module "vpc" {
  source             = "../module/vpc/"
  env                = "dev"
  appname            = "terraform"
  vpc_cidr_block     = "192.168.0.0/16"
  public_cidr_block  = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  private_cidr_block = ["192.168.4.0/24", "192.168.5.0/24", "192.168.6.0/24"]
  availability_zone  = ["us-west-2a", "us-west-2b", "us-west-2c"]
  tags = {
    Owner = "dev-team"
  }
}

module "loadbalancer" {
  source             = "../module/loadbalancer/"
  env                = "dev"
  appname            = "terraform"
  internal           = "false"
  load-balancer-type = "application"
  subnets            = module.vpc.public_sub_id
  security_groups    = [module.vpc.security_groups]
  vpc_id             = module.vpc.vpc_id

  tags = {
    Owner = "dev-team"
  }
}
