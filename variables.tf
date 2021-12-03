variable "vpc_id" {
  description = "vpc_id"
  type        = string
}
variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}
variable "name" {
  description = "name"
  type        = string
}
variable "instance_type" {
  description = "instance_type"
  type        = string
}
variable "ami" {
  description = "ami"
  default     = ""
  type        = string
}
