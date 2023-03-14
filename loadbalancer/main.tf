resource "aws_lb" "alb" {
  count = var.load-balancer-type == "application" ? 1 : 0
  name               = format ("%s-%s-%s",var.appname,var.env,"application")
  internal           = var.internal
  load_balancer_type = var.load-balancer-type
  security_groups    = ["sg-0b1400261fbab8adb"]
  subnets            = ["subnet-07bdd8637ca469f74","subnet-0ec4d5cb21dcb9916"]
  enable_deletion_protection = true
  
tags = merge (var.tags,{Name= format ("%s-%s-%s",var.appname,var.env,"application")})
 }

resource "aws_lb" "nlb" {
  count = var.load-balancer-type == "network" ? 1:0
  name               = format ("%s-%s-%s",var.appname,var.env,"network")
  internal           = var.internal
  load_balancer_type = var.load-balancer-type
  subnets            = ["subnet-07bdd8637ca469f74","subnet-0ec4d5cb21dcb9916"]
  enable_deletion_protection = true
   
tags = merge (var.tags,{Name= format ("%s-%s-%s",var.appname,var.env,"network")})
}