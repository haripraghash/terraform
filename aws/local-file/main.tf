    terraform {
      required_providers {
        local = {
            source = "hashicorp/local"
            version = "~> 2.0"
        }
      }
    }

    resource "local_file" "artofwar" {
      filename = "art_of_war.txt"
      content = <<-EOT
      Sun-Tzu said something
      EOT
    }