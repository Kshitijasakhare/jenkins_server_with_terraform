terraform {
  backend "s3" {
    bucket = "1347kshitija"
    region = "ap-south-1"
    key    = "fold1/terraform.tfstate"
    dynamodb_table="project"
  }
}