# # Create an AWS Application Load Balancer (ALB)
# resource "aws_lb" "waf_alb" {
#   name               = "waf-alb"
#   internal           = false
#   load_balancer_type = "application"

#   # Define the subnets and security group for the ALB
#   subnets = module.vpc.private_subnets
#   #   security_groups = ["sg-0123456789abcdef"]
# }

# # Create a listener on the ALB
# resource "aws_lb_listener" "waf_alb_listener" {
#   load_balancer_arn = aws_lb.waf_alb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   # Define the default action for the listener
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.waf_alb_target_group.arn
#   }

#   # Associate the Web ACL with the ALB listener
#   #   dynamic "web_acl" {
#   #     for_each = var.associations

#   #     content {
#   #       web_acl_arn  = aws_wafv2_web_acl.waf_web_acl.arn
#   #       resource_arn = aws_lb_listener.waf_alb_listener.arn
#   #       action       = web_acl.value.action
#   #     }
#   #   }
# }

# # Define the AWS WAFv2 Web ACL
# resource "aws_wafv2_web_acl" "waf_web_acl" {
#   name        = "waf-web-acl"
#   scope       = "REGIONAL"
#   description = "Example Web ACL"

#   # Define the rules for the Web ACL
#   default_action {
#     block {}
#   }

#   rule {
#     name     = "waf-rule"
#     priority = 1

#     action {
#       block {}
#     }

#     statement {
#       rate_based_statement {
#         aggregate_key_type = "IP"
#         limit              = 100
#         scope_down_statement {
#           not_statement {
#             statement {
#               ip_set_reference_statement {
#                 arn = aws_wafv2_ip_set.waf_ip_set.arn
#               }
#             }
#           }
#         }
#       }
#     }
#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "waf-rule-metric"
#       sampled_requests_enabled   = true
#     }
#   }

#   visibility_config {
#     cloudwatch_metrics_enabled = true
#     metric_name                = "waf-metric"
#     sampled_requests_enabled   = true
#   }
# }

# # Define the AWS WAFv2 IP Set
# resource "aws_wafv2_ip_set" "waf_ip_set" {
#   name        = "waf-ip-set"
#   description = "IP addresses to ignore during rate limiting"
#   scope       = "REGIONAL"


#   # Define the IP addresses to include in the set
#   addresses          = ["10.0.0.0/24", "192.168.1.0/24"]
#   ip_address_version = "IPV4"
# }


# # Create a target group for the EKS cluster
# resource "aws_lb_target_group" "waf_alb_target_group" {
#   name     = "waf-alb-target-group"
#   port     = 80
#   protocol = "HTTP"

#   # Define the health check for the target group
#   health_check {
#     path = "/health"
#   }

#   # Associate the target group with the EKS cluster
#   vpc_id = module.vpc.vpc_id
# }

# # Create a WAFv2 Web ACL Association
# resource "aws_wafv2_web_acl_association" "waf_web_acl_assoc" {
#   for_each = var.associations

#   web_acl_arn  = aws_wafv2_web_acl.waf_web_acl.arn
#   resource_arn = aws_lb.waf_alb.arn
#   #   action       = each.value.action
# }
