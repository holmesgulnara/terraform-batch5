terraform {
  backend "s3" {
    bucket = "kaizen-gulya"
    key    = "ohio/terraform.tfstate"
    region = "us-east-2"
  }
}
