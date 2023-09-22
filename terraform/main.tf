terraform {
    backend "gcs" {
        bucket  = "tf-state-bucket115"
        prefix  = "terraform/state"
    }
}

provider "google" {
    credentials = file("key.json")
    project     = "caramel-compass-393820"
    region      = "europe-west1"
}


module "gke-infrastructure" {
    source = "./modules/gke"
    
    project = "caramel-compass-393820"
    region = "europe-west1"
    zone = "europe-west1-b"
    environment = "dev"
}