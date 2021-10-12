terraform {
  backend "s3" {                                                      
    bucket         = "team-rocket-ytu4qsvk6ww6-state-bucket"          
    key            = "jesse/james"                                    
    region         = "us-west-2"                                      
    encrypt        = true                                             
    role_arn       = "arn:aws:iam::302268709798:role/team-rocket-ytu4qsvk6ww6-tf-assume-role"                                          
    dynamodb_table = "team-rocket-ytu4qsvk6ww6-state-lock"            
  }
  required_version = ">= 0.15"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
} 

resource "null_resource" "motto" {
  triggers = {
    "always" = timestamp()
  }

  provisioner "local-exec" {
    command = "echo gotta catch em all"
  }
}