resource "google_compute_network" "node-app-vpc" {
    name = "node-app-vpc"
    auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "node-app-subnetwork" {
    name = "node-app-subnetwork"
    ip_cidr_range = "10.2.0.0/16"
    region = var.region
    network = google_compute_network.node-app-vpc.name
    secondary_ip_range {
        range_name    = "node-app-services-range"
        ip_cidr_range = "192.168.1.0/24"
    }
    secondary_ip_range {
        range_name    = "node-app-pods-range"
        ip_cidr_range = "192.168.64.0/22"
    }
}


#Terraform doesn't see the subnetwork without the sleep function =P
resource "time_sleep" "sleep_180" {
    depends_on = [ google_compute_subnetwork.node-app-subnetwork ]
    create_duration = "180s"
}


resource "google_compute_firewall" "ssh-rule" {
  name = "terraform-ssh"
  network = google_compute_network.node-app-vpc.name
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  target_tags = ["allow-ssh"]
  source_ranges = ["0.0.0.0/0"]
}


resource "google_compute_firewall" "http-rule" {
  name = "terraform-http"
  network = google_compute_network.node-app-vpc.name
  allow {
    protocol = "tcp"
    ports = ["80"]
  }
  target_tags = ["allow-http"]
  source_ranges = ["0.0.0.0/0"]
}
