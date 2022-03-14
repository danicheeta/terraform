variable "project" {
  default     = "tower"
  description = "Project name"
}

variable "region" {
  default     = "eu-central-1"
  description = "AWS region"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "AWS VPC CIDR"
}

variable "public_subnets_cidr" {
  type        = list(any)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  description = "AWS Public Subnets"
}

variable "private_subnets_cidr" {
  type        = list(any)
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  description = "AWS Private Subnets"
}
