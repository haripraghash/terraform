# backend.hcl

    bucket = "hari-tf-remote-backend"
    region = "us-east-1"

     # Replace this with your DynamoDB table name!
    dynamodb_table = "tf-remote-backend-lock"
    encrypt        = true