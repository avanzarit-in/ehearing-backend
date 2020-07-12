terraform {
  required_version = "0.12.24"
  backend "s3" {
    bucket = "dev-globo-tek-infra"
    key    = "development"
    region = "us-east-1"
    profile = "default"
    shared_credentials_file = "~/.aws/credentials"
  }
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}

provider "aws" {
  version = "~> 2.8"
  max_retries = 20
  profile = "default"
  shared_credentials_file = "~/.aws/credentials"
  region="us-east-1"
}

module "cognito-auth" {
  source  = "./../terraform-aws-cognito-auth"

  namespace                      = "legalhear"
  region                         = "us-east-1"
  cognito_identity_pool_name     = "legalhear"
  cognito_identity_pool_provider = "localhost"

  # Optional: Email delivery
  ses_sender_address             = "admin@legalhear.com"
}