variable "access_key" {
  type        = string
  description = "aws access key"
}

variable "secret_key" {
  type        = string
  description = "aws secret key"
}

variable "token" {
  type        = string
  description = "aws session token"
}

variable "region" {
  type    = string
  default = "eu-west-1"
  description = "aws region to create infrastructure in"
}

variable "num_subnets" {
  type    = number
  default = 2
  description = "number of private and public subnets to create"
}
