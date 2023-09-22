data "google_client_config" "default" {}


provider "kubernetes" {
    host = "https://${module.gke.endpoint}"
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
    source = "terraform-google-modules/kubernetes-engine/google"
    project_id = ""
    name = "node-app-cluster"
    region = "europe-west1"
    zones = ["europe-west1-b"]
    network = "node-app-vpc"
    subnetwork = "node-app-subnetwork"
    ip_range_pods = "node-app-pods-range"
    ip_range_services = "node-app-services-range"
    node_metadata = "EXPOSE"
    identity_namespace = null
    node_pools = [
        {
            name = "workers"
            min_count = 2
            max_count = 5
            auto_upgrade = true
            machine_type = "n1-standard-1"
        }
    ]
    node_pools_tags = {
        all = [ "allow-ssh", "allow-http"]
    }
}
