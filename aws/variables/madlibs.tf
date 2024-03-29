terraform {
  required_version = ">= 1.0.0"
  required_providers {
   random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    } 
  }
}

variable "words" {
  description = "A word pool to use with madlibs"
  type = object({
      nouns = list(string)
      adjectives = list(string)
      verbs = list(string)
      adverbs = list(string)
      numbers = list(number)
  })

  validation {
    condition = length(var.words.nouns) >= 5
    error_message = "Nouns must contain atleast 5 words."
  }
}

locals {
  uppercase_words = {for k,v in var.words : k => [for s in v : upper(s)]}
}
resource "random_shuffle" "random_nouns" {
  input = local.uppercase_words["nouns"]
}

resource "random_shuffle" "random_adjectives" {
  input = local.uppercase_words["adjectives"]
}
 
resource "random_shuffle" "random_verbs" {
  input = local.uppercase_words["verbs"]
}
 
resource "random_shuffle" "random_adverbs" {
  input = local.uppercase_words["adverbs"]
}
 
resource "random_shuffle" "random_numbers" {
  input = var.words["numbers"]
}

output "mad_libs" {
  value = templatefile("${path.module}/templates/alice.tpl",
    {
      nouns      = random_shuffle.random_nouns.result
      adjectives = random_shuffle.random_adjectives.result
      verbs      = random_shuffle.random_verbs.result
      adverbs    = random_shuffle.random_adverbs.result
      numbers    = random_shuffle.random_numbers.result
  })
}


