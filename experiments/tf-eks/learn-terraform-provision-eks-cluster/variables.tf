variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Cluster Name"
  type        = string
  default     = "dev-workloads"
}

# Define the associations variable
variable "associations" {
  type = map(object({
    action = string
  }))

  default = {
    "alb-listener" = {
      action = "ALLOW"
    }
  }
}