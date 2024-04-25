terraform {
  backend "s3" {
    bucket = "group4-kaizen"
    key    = "path/terraform.tfstate"
    region = "us-east-2"
  }
}