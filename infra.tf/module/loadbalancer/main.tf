resource "aws_lb" "alb" {
  count = var.load-balancer-type == "application" ? 1 : 0
  name               = format ("%s-%s-%s",var.appname,var.env,"application")
  internal           = var.internal
  load_balancer_type = var.load-balancer-type
  security_groups    = var.security_groups
  subnets            = var.subnets
  enable_deletion_protection = false
  
  access_logs {
    bucket =aws_s3_bucket.my-bucket.id
    prefix =var.appname
    enabled = true    
  }
  
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

resource "aws_s3_bucket" "my-bucket" {
  bucket = "mybucket-${var.appname}-${var.env}-${random_string.random.id}"
}

resource "random_string" "random" {
  length           = 5
  special          = false
  upper            = false
}

resource "aws_s3_bucket_policy" "log-bucket-policy" {
  bucket = aws_s3_bucket.my-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "${aws_s3_bucket.my-bucket.arn}/*"
      }
    ]
  })
}
