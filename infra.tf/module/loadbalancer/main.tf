resource "aws_lb" "alb" {
  count = var.load-balancer-type == "application" ? 1 : 0
  name               = format ("%s-%s-%s",var.appname,var.env,"application")
  internal           = var.internal
  load_balancer_type = var.load-balancer-type
  security_groups    = var.security_groups
  subnets            = var.subnets
  enable_deletion_protection = false
  
tags = merge (var.tags,{Name= format ("%s-%s-%s",var.appname,var.env,"application")})
 }

resource "aws_lb" "nlb" {
  count = var.load-balancer-type == "network" ? 1:0
  name               = format ("%s-%s-%s",var.appname,var.env,"network")
  internal           = var.internal
  load_balancer_type = var.load-balancer-type
  subnets            = var.subnets
  enable_deletion_protection = false
   
tags = merge (var.tags,{Name= format ("%s-%s-%s",var.appname,var.env,"network")})
}
