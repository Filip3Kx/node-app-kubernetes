terraform {
    backend "gcs" {
        bucket  = "terraform-2115"
        prefix  = "terraform/state"
    }
}

provider "google" {
    credentials = file("key.json")
    project     = "node-app-399813"
    region      = "europe-west1"
}


module "gke-infrastructure" {
    source = "./modules/gke"
    project = "node-app-399813"
    region = "europe-west1"
    zone = "europe-west1-b"
    environment = "dev"
}