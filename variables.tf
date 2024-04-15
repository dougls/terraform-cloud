variable "awsAcademyRole" {
  default = "arn:aws:iam::241088372735:role/LabRole"
}

variable "subnetA" {
  default = "subnet-07602af85b7b1c946"
}

variable "subnetB" {
  default = "subnet-00c83d7f026e8b29c"
}

variable "subnetC" {
  default = "subnet-09270b32bae1426ff"
}

variable "securityGroupId" {
  default = "sg-0cba58547c3ae2528"
}

variable "principalArn" {
  default = "arn:aws:iam::241088372735:role/voclabs"
}