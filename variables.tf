variable "external_ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "instance-type" {
  type    = string
  default = "t3.micro"
  #  validation {
  #    condition     = can(regex("[^t2]", var.instance-type))
  #    error_message = "Instance type cannot be anything other than t2 or t3 type and also not t3a.micro."
  #  }
}

variable "key_name" {
  type    = string
  default = "jenkins"
}

variable "dns-name" {
  type    = string
  default = "alfaco.fr." # e.g "cmcloudlab1234.info."
}

variable "profile" {
  type    = string
  default = "default"
}

variable "region-master" {
  type    = string
  default = "eu-west-3"
}

variable "region-worker" {
  type    = string
  default = "eu-west-1"
}

#How many Jenkins workers to spin up
variable "workers-count" {
  type    = number
  default = 1
}

#webserver-port ALB 
variable "webserver-port" {
  type    = number
  default = 8080
}
