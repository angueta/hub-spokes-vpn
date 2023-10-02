##########################################################
##### Required resources for Clod NAT on PRJ-HUB
##########################################################

#### 
resource "google_compute_router" "router-nat-hub" {
  name    = "router-nat-hub"
  region  = var.region
  network = google_compute_network.hub-vpc.self_link
  #network = google_compute_network.vpc-hub.self_link
  project = var.global_project_ids.hub
  #project = google_project.prj-hub.project_id
}

#### Creamos cloud NAT hub
resource "google_compute_router_nat" "nat-hub" {
  name                               = "cloud-nat-hub"
  router = google_compute_router.router-nat-hub
  region  = var.region
  #router                             = google_compute_router.router.name
  #region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  project = var.global_project_ids.hub
  #project = google_project.prj-hub.project_id

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

##########################################################
##### Required resources for Clod NAT on Spokes PRJs
##########################################################

