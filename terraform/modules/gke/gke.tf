data "google_client_config" "default" {}


provider "kubernetes" {
    host = "https://${module.gke.endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}


module "gke" {
    source = "terraform-google-modules/kubernetes-engine/google"
    project_id = var.project
    name = "node-app-cluster"
    region = var.region
    zones = [ var.zone ]
    network = "node-app-vpc"
    subnetwork = "node-app-subnetwork"
    ip_range_pods = "node-app-pods-range"
    ip_range_services = "node-app-services-range"
    node_metadata = "EXPOSE"
    identity_namespace = null
}