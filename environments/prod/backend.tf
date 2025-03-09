terraform {
  backend "s3" {
    bucket         = "duy-mock-project"
    key            = "networking/dev/terraform.tfstate"
    region         = "sa-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

