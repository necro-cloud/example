terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.36.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.0-pre2"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.3"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }

  backend "kubernetes" {
    secret_suffix = "deployment"
  }
}

provider "kubernetes" {
}

provider "helm" {
}

provider "null" {
}

provider "random" {
}
