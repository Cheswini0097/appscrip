

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes"
  default     = "t3.medium"
}
variable "project_name" {
    default = "devopsassignment"
  
}
variable "environment" {
    default = "test"
  
}
variable "private_subnets" {
    type = list(string)
    default = ["subnet-0a9845ac0e7dd5254", "subnet-040e0b5c9635c3562"]
  
}
variable "desired_size" {
    default = 2
  
}
variable "region" {
    default = "us-east-1"
  
}
variable "common_tags" {
    default = {
        project = "devopsassignment"
        environment = "assignment"
    }
  
}
