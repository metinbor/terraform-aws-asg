variable  "vpc_id"  {}
variable "subnets" {
    type = list
}
variable "instance_type"   {}
variable  "asg_max_size"   {}
variable  "region"   {}
variable  "tags" {
    type  =  map
}
variable  "environment" {}
variable  "s3_bucket"  {}
variable "s3_folder_project"  {}
variable "s3_folder_region"  {}
variable "s3_folder_type"  {}
variable "s3_tfstate_file"  {} 

