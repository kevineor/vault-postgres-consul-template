terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">=2.20.0"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = ">=1.13.0"
    }
  }

}

provider "vault" {

}

provider "postgresql" {
  sslmode = "disable"

}
