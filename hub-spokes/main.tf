/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# [START cloudvpn_ha_gcp_to_gcp]
resource "google_compute_ha_vpn_gateway" "ha-vpn-hub" {
  project = var.global_project_ids.hub
  region  = var.region
  name    = "ha-vpn-hub"
  network = google_compute_network.hub-vpc.id
}

resource "google_compute_ha_vpn_gateway" "ha-vpn-prod" {
  project = var.global_project_ids.prod
  region  = var.region
  name    = "ha-vpn-prod"
  network = google_compute_network.prod-vpc.id
}

resource "google_compute_ha_vpn_gateway" "ha-vpn-dev" {
  project = var.global_project_ids.dev
  region  = var.region
  name    = "ha-vpn-dev"
  network = google_compute_network.dev-vpc.id
}

resource "google_compute_ha_vpn_gateway" "ha-vpn-qa" {
  project = var.global_project_ids.qa
  region  = var.region
  name    = "ha-vpn-qa"
  network = google_compute_network.qa-vpc.id
}

# [START VPC CREATION]
resource "google_compute_network" "hub-vpc" {
  project                 = var.global_project_ids.hub
  name                    = "hub-vpc"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
  mtu                     = 1500
}

resource "google_compute_network" "prod-vpc" {
  project                 = var.global_project_ids.prod
  name                    = "prod-vpc"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
  mtu                     = 1500
}

resource "google_compute_network" "dev-vpc" {
  project                 = var.global_project_ids.dev
  name                    = "dev-vpc"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
  mtu                     = 1500
}

resource "google_compute_network" "qa-vpc" {
  project                 = var.global_project_ids.qa
  name                    = "qa-vpc"
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
  mtu                     = 1500
}

# [START HUB-VPC SUBNETS CREATION]
resource "google_compute_subnetwork" "hub-vpc_subnet1" {
  project       = var.global_project_ids.hub
  name          = var.vpc_subnets_name.name-hub-subnet-1
  ip_cidr_range = var.vpc_subnets_cidr.cidr-hub-subnet-1
  region        = var.region
  network       = google_compute_network.hub-vpc.id
}

resource "google_compute_subnetwork" "hub-vpc_subnet2" {
  project       = var.global_project_ids.hub
  name          = var.vpc_subnets_name.name-hub-subnet-2
  ip_cidr_range = var.vpc_subnets_cidr.cidr-hub-subnet-2
  region        = "us-central1"
  network       = google_compute_network.hub-vpc.id
}

# [START PROD-VPC SUBNETS CREATION]
resource "google_compute_subnetwork" "prod-vpc_subnet1" {
  project       = var.global_project_ids.prod
  name          = var.vpc_subnets_name.name-prod-subnet-1
  ip_cidr_range = var.vpc_subnets_cidr.cidr-prod-subnet-1
  region        = var.region
  network       = google_compute_network.prod-vpc.id
}

resource "google_compute_subnetwork" "prod-vpc_subnet2" {
  project       = var.global_project_ids.prod
  name          = var.vpc_subnets_name.name-prod-subnet-2
  ip_cidr_range = var.vpc_subnets_cidr.cidr-prod-subnet-2
  region        = "us-central1"
  network       = google_compute_network.prod-vpc.id
}

# [START DEV-VPC SUBNETS CREATION]
resource "google_compute_subnetwork" "dev-vpc_subnet1" {
  project       = var.global_project_ids.dev
  name          = var.vpc_subnets_name.name-dev-subnet-1
  ip_cidr_range = var.vpc_subnets_cidr.cidr-dev-subnet-1
  region        = var.region
  network       = google_compute_network.dev-vpc.id
}

resource "google_compute_subnetwork" "dev-vpc_subnet2" {
  project       = var.global_project_ids.dev
  name          = var.vpc_subnets_name.name-dev-subnet-2
  ip_cidr_range = var.vpc_subnets_cidr.cidr-dev-subnet-2
  region        = "us-central1"
  network       = google_compute_network.dev-vpc.id
}

# [START QA-VPC SUBNETS CREATION]
resource "google_compute_subnetwork" "qa-vpc_subnet1" {
  project       = var.global_project_ids.qa
  name          = var.vpc_subnets_name.name-qa-subnet-1
  ip_cidr_range = var.vpc_subnets_cidr.cidr-qa-subnet-1
  region        = var.region
  network       = google_compute_network.qa-vpc.id
}

resource "google_compute_subnetwork" "qa-vpc_subnet2" {
  project       = var.global_project_ids.qa
  name          = var.vpc_subnets_name.name-qa-subnet-2
  ip_cidr_range = var.vpc_subnets_cidr.cidr-qa-subnet-2
  region        = "us-central1"
  network       = google_compute_network.qa-vpc.id
}


# [START CLOUD ROUTER CREATION]
resource "google_compute_router" "router1" {
  project = var.global_project_ids.hub
  name    = "cr-hub"
  region  = var.region
  network = google_compute_network.hub-vpc.name
  bgp {
    asn               = var.asn.hub
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
    advertised_ip_ranges {
      range = "10.239.0.0/20"
    }
  }

}

resource "google_compute_router" "router2" {
  project = var.global_project_ids.prod
  name    = "cr-prod"
  region  = var.region
  network = google_compute_network.prod-vpc.name
  bgp {
    asn = var.asn.prod
  }
}

resource "google_compute_router" "router3" {
  project = var.global_project_ids.dev
  name    = "cr-dev"
  region  = var.region
  network = google_compute_network.dev-vpc.name
  bgp {
    asn = var.asn.dev
  }
}

resource "google_compute_router" "router4" {
  project = var.global_project_ids.qa
  name    = "cr-qa"
  region  = var.region
  network = google_compute_network.qa-vpc.name
  bgp {
    asn = var.asn.qa
  }
}

# [START IPSEC TUNNELS CREATION]
# [START IPSEC HUB-VPC TUNNELS CREATION]
resource "google_compute_vpn_tunnel" "tunnel1" {
  project               = var.global_project_ids.hub
  name                  = "vpn-hub-prod-1"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha-vpn-hub.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha-vpn-prod.id
  shared_secret         = "a secret message"
  router                = google_compute_router.router1.id
  vpn_gateway_interface = 0
}

resource "google_compute_vpn_tunnel" "tunnel2" {
  project               = var.global_project_ids.hub
  name                  = "vpn-hub-prod-2"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha-vpn-hub.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha-vpn-prod.id
  shared_secret         = "a secret message"
  router                = google_compute_router.router1.id
  vpn_gateway_interface = 1
}

resource "google_compute_vpn_tunnel" "tunnel5" {
  project               = var.global_project_ids.hub
  name                  = "vpn-hub-dev-1"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha-vpn-hub.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha-vpn-dev.id
  shared_secret         = "a secret message"
  router                = google_compute_router.router1.id
  vpn_gateway_interface = 0
}

resource "google_compute_vpn_tunnel" "tunnel6" {
  project               = var.global_project_ids.hub
  name                  = "vpn-hub-dev-2"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha-vpn-hub.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha-vpn-dev.id
  shared_secret         = "a secret message"
  router                = google_compute_router.router1.id
  vpn_gateway_interface = 1
}

resource "google_compute_vpn_tunnel" "tunnel9" {
  project               = var.global_project_ids.hub
  name                  = "vpn-hub-qa-1"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha-vpn-hub.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha-vpn-qa.id
  shared_secret         = "a secret message"
  router                = google_compute_router.router1.id
  vpn_gateway_interface = 0
}

resource "google_compute_vpn_tunnel" "tunnel10" {
  project               = var.global_project_ids.hub
  name                  = "vpn-hub-qa-2"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha-vpn-hub.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha-vpn-qa.id
  shared_secret         = "a secret message"
  router                = google_compute_router.router1.id
  vpn_gateway_interface = 1
}

# [START IPSEC PROD-VPC TUNNELS CREATION]
resource "google_compute_vpn_tunnel" "tunnel3" {
  project               = var.global_project_ids.prod
  name                  = "vpn-prod-hub-1"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha-vpn-prod.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha-vpn-hub.id
  shared_secret         = "a secret message"
  router                = google_compute_router.router2.id
  vpn_gateway_interface = 0
}

resource "google_compute_vpn_tunnel" "tunnel4" {
  project               = var.global_project_ids.prod
  name                  = "vpn-prod-hub-2"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha-vpn-prod.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha-vpn-hub.id
  shared_secret         = "a secret message"
  router                = google_compute_router.router2.id
  vpn_gateway_interface = 1
}

# [START IPSEC DEV-VPC TUNNELS CREATION]
resource "google_compute_vpn_tunnel" "tunnel7" {
  project               = var.global_project_ids.dev
  name                  = "vpn-dev-hub-1"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha-vpn-dev.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha-vpn-hub.id
  shared_secret         = "a secret message"
  router                = google_compute_router.router3.id
  vpn_gateway_interface = 0
}

resource "google_compute_vpn_tunnel" "tunnel8" {
  project               = var.global_project_ids.dev
  name                  = "vpn-dev-hub-2"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha-vpn-dev.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha-vpn-hub.id
  shared_secret         = "a secret message"
  router                = google_compute_router.router3.id
  vpn_gateway_interface = 1
}

# [START IPSEC QA-VPC TUNNELS CREATION]
resource "google_compute_vpn_tunnel" "tunnel11" {
  project               = var.global_project_ids.qa
  name                  = "vpn-qa-hub-1"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha-vpn-qa.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha-vpn-hub.id
  shared_secret         = "a secret message"
  router                = google_compute_router.router4.id
  vpn_gateway_interface = 0
}

resource "google_compute_vpn_tunnel" "tunnel12" {
  project               = var.global_project_ids.qa
  name                  = "vpn-qa-hub-2"
  region                = var.region
  vpn_gateway           = google_compute_ha_vpn_gateway.ha-vpn-qa.id
  peer_gcp_gateway      = google_compute_ha_vpn_gateway.ha-vpn-hub.id
  shared_secret         = "a secret message"
  router                = google_compute_router.router4.id
  vpn_gateway_interface = 1
}

# [START BGP SESSIONS CREATION]
# [START BGP SESSIONS HUB-PROD CREATION]
resource "google_compute_router_interface" "router1_interface1" {
  project    = var.global_project_ids.hub
  name       = "router1-interface1"
  router     = google_compute_router.router1.name
  region     = var.region
  ip_range   = "169.254.0.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel1.name
}

resource "google_compute_router_peer" "router1_peer1" {
  project                   = var.global_project_ids.hub
  name                      = "bgp-hub-prod-1"
  router                    = google_compute_router.router1.name
  region                    = var.region
  peer_ip_address           = "169.254.0.2"
  peer_asn                  = var.asn.prod
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router1_interface1.name
}

resource "google_compute_router_interface" "router1_interface2" {
  project    = var.global_project_ids.hub
  name       = "router1-interface2"
  router     = google_compute_router.router1.name
  region     = var.region
  ip_range   = "169.254.1.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel2.name
}

resource "google_compute_router_peer" "router1_peer2" {
  project                   = var.global_project_ids.hub
  name                      = "bgp-hub-prod-2"
  router                    = google_compute_router.router1.name
  region                    = var.region
  peer_ip_address           = "169.254.1.2"
  peer_asn                  = var.asn.prod
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router1_interface2.name
}

# [START BGP SESSIONS HUB-DEV CREATION]
resource "google_compute_router_interface" "router1_interface3" {
  project    = var.global_project_ids.hub
  name       = "router1-interface3"
  router     = google_compute_router.router1.name
  region     = var.region
  ip_range   = "169.254.2.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel5.name
}

resource "google_compute_router_peer" "router1_peer3" {
  project                   = var.global_project_ids.hub
  name                      = "bgp-hub-dev-1"
  router                    = google_compute_router.router1.name
  region                    = var.region
  peer_ip_address           = "169.254.2.2"
  peer_asn                  = var.asn.dev
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router1_interface3.name
}

resource "google_compute_router_interface" "router1_interface4" {
  project    = var.global_project_ids.hub
  name       = "router1-interface4"
  router     = google_compute_router.router1.name
  region     = var.region
  ip_range   = "169.254.3.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel6.name
}

resource "google_compute_router_peer" "router1_peer4" {
  project                   = var.global_project_ids.hub
  name                      = "bgp-hub-dev-2"
  router                    = google_compute_router.router1.name
  region                    = var.region
  peer_ip_address           = "169.254.3.2"
  peer_asn                  = var.asn.dev
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router1_interface4.name
}

# [START BGP SESSIONS HUB-QA CREATION]
resource "google_compute_router_interface" "router1_interface5" {
  project    = var.global_project_ids.hub
  name       = "router1-interface5"
  router     = google_compute_router.router1.name
  region     = var.region
  ip_range   = "169.254.4.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel9.name
}

resource "google_compute_router_peer" "router1_peer5" {
  project                   = var.global_project_ids.hub
  name                      = "bgp-hub-qa-1"
  router                    = google_compute_router.router1.name
  region                    = var.region
  peer_ip_address           = "169.254.4.2"
  peer_asn                  = var.asn.qa
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router1_interface5.name
}

resource "google_compute_router_interface" "router1_interface6" {
  project    = var.global_project_ids.hub
  name       = "router1-interface6"
  router     = google_compute_router.router1.name
  region     = var.region
  ip_range   = "169.254.5.1/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel10.name
}

resource "google_compute_router_peer" "router1_peer6" {
  project                   = var.global_project_ids.hub
  name                      = "bgp-hub-qa-2"
  router                    = google_compute_router.router1.name
  region                    = var.region
  peer_ip_address           = "169.254.5.2"
  peer_asn                  = var.asn.qa
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router1_interface6.name
}

# [START BGP SESSIONS PROD-HUB CREATION]
resource "google_compute_router_interface" "router2_interface1" {
  project    = var.global_project_ids.prod
  name       = "router2-interface1"
  router     = google_compute_router.router2.name
  region     = var.region
  ip_range   = "169.254.0.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel3.name
}

resource "google_compute_router_peer" "router2_peer1" {
  project                   = var.global_project_ids.prod
  name                      = "bgp-prod-hub-1"
  router                    = google_compute_router.router2.name
  region                    = var.region
  peer_ip_address           = "169.254.0.1"
  peer_asn                  = var.asn.hub
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router2_interface1.name
}

resource "google_compute_router_interface" "router2_interface2" {
  project    = var.global_project_ids.prod
  name       = "router2-interface2"
  router     = google_compute_router.router2.name
  region     = var.region
  ip_range   = "169.254.1.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel4.name
}

resource "google_compute_router_peer" "router2_peer2" {
  project                   = var.global_project_ids.prod
  name                      = "bgp-prod-hub-2"
  router                    = google_compute_router.router2.name
  region                    = var.region
  peer_ip_address           = "169.254.1.1"
  peer_asn                  = var.asn.hub
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router2_interface2.name
}

# [START BGP SESSIONS DEV-HUB CREATION]
resource "google_compute_router_interface" "router3_interface1" {
  project    = var.global_project_ids.dev
  name       = "router3-interface1"
  router     = google_compute_router.router3.name
  region     = var.region
  ip_range   = "169.254.2.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel7.name
}

resource "google_compute_router_peer" "router3_peer1" {
  project                   = var.global_project_ids.dev
  name                      = "bgp-dev-hub-1"
  router                    = google_compute_router.router3.name
  region                    = var.region
  peer_ip_address           = "169.254.2.1"
  peer_asn                  = var.asn.hub
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router3_interface1.name
}

resource "google_compute_router_interface" "router3_interface2" {
  project    = var.global_project_ids.dev
  name       = "router3-interface2"
  router     = google_compute_router.router3.name
  region     = var.region
  ip_range   = "169.254.3.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel8.name
}

resource "google_compute_router_peer" "router3_peer2" {
  project                   = var.global_project_ids.dev
  name                      = "bgp-dev-hub-2"
  router                    = google_compute_router.router3.name
  region                    = var.region
  peer_ip_address           = "169.254.3.1"
  peer_asn                  = var.asn.hub
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router3_interface2.name
}

# [START BGP SESSIONS QA-HUB CREATION]
resource "google_compute_router_interface" "router4_interface1" {
  project    = var.global_project_ids.qa
  name       = "router4-interface1"
  router     = google_compute_router.router4.name
  region     = var.region
  ip_range   = "169.254.4.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel11.name
}

resource "google_compute_router_peer" "router4_peer1" {
  project                   = var.global_project_ids.qa
  name                      = "bgp-qa-hub-1"
  router                    = google_compute_router.router4.name
  region                    = var.region
  peer_ip_address           = "169.254.4.1"
  peer_asn                  = var.asn.hub
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router4_interface1.name
}

resource "google_compute_router_interface" "router4_interface2" {
  project    = var.global_project_ids.qa
  name       = "router4-interface2"
  router     = google_compute_router.router4.name
  region     = var.region
  ip_range   = "169.254.5.2/30"
  vpn_tunnel = google_compute_vpn_tunnel.tunnel12.name
}

resource "google_compute_router_peer" "router4_peer2" {
  project                   = var.global_project_ids.qa
  name                      = "bgp-qa-hub-2"
  router                    = google_compute_router.router4.name
  region                    = var.region
  peer_ip_address           = "169.254.5.1"
  peer_asn                  = var.asn.hub
  advertised_route_priority = 100
  interface                 = google_compute_router_interface.router4_interface2.name
}
# [END cloudvpn_ha_gcp_to_gcp]
## FIREWALLS RULES HUB VPC
module "landing-firewall-hub" {
  source     = "../modules/net-vpc-firewall"
  project_id = var.global_project_ids.hub
  network    = google_compute_network.hub-vpc.name
  default_rules_config = {
    admin_ranges = values(var.vpc_subnets_cidr)
  }
}

## FIREWALLS RULES PROD VPC
module "landing-firewall-prod" {
  source     = "../modules/net-vpc-firewall"
  project_id = var.global_project_ids.prod
  network    = google_compute_network.prod-vpc.name
  default_rules_config = {
    admin_ranges = values(var.vpc_subnets_cidr)
  }
}

## FIREWALLS RULES DEV VPC
module "landing-firewall-dev" {
  source     = "../modules/net-vpc-firewall"
  project_id = var.global_project_ids.dev
  network    = google_compute_network.dev-vpc.name
  default_rules_config = {
    admin_ranges = values(var.vpc_subnets_cidr)
  }
}

## FIREWALLS RULES QA VPC
module "landing-firewall-qa" {
  source     = "../modules/net-vpc-firewall"
  project_id = var.global_project_ids.qa
  network    = google_compute_network.qa-vpc.name
  default_rules_config = {
    admin_ranges = values(var.vpc_subnets_cidr)
  }
}

###############################
###############################
### shared vpc starts #########
###############################
###############################

# Enable A Shared VPC in the host project PROD
resource "google_compute_shared_vpc_host_project" "host_prod" {
  project = var.global_project_ids.prod # Replace this with your host project ID in quotes
}

# To attach a first service project with host project 
resource "google_compute_shared_vpc_service_project" "service1_prod" {
  host_project    = google_compute_shared_vpc_host_project.host_prod.project
  service_project = var.global_service_project_ids.prod_serv_proj_1 # Replace this with your service project ID in quotes
}

#To attach another secon service project with host project 
resource "google_compute_shared_vpc_service_project" "service2_prod" {
  host_project    = google_compute_shared_vpc_host_project.host_prod.project
  service_project = var.global_service_project_ids.prod_serv_proj_2 # Replace this with your service project ID in quotes
}

##############################\
# Enable A Shared VPC in the host project DEV
resource "google_compute_shared_vpc_host_project" "host_dev" {
  project = var.global_project_ids.dev # Replace this with your host project ID in quotes
}

# To attach a first service project with host project 
resource "google_compute_shared_vpc_service_project" "service1_dev" {
  host_project    = google_compute_shared_vpc_host_project.host_dev.project
  service_project = var.global_service_project_ids.dev_serv_proj_1 # Replace this with your service project ID in quotes
}

#To attach another secon service project with host project 
resource "google_compute_shared_vpc_service_project" "service2_dev" {
  host_project    = google_compute_shared_vpc_host_project.host_dev.project
  service_project = var.global_service_project_ids.dev_serv_proj_2 # Replace this with your service project ID in quotes
}

##############################\
# Enable A Shared VPC in the host project QA
resource "google_compute_shared_vpc_host_project" "host_qa" {
  project = var.global_project_ids.qa # Replace this with your host project ID in quotes
}

# To attach a first service project with host project 
resource "google_compute_shared_vpc_service_project" "service1_qa" {
  host_project    = google_compute_shared_vpc_host_project.host_qa.project
  service_project = var.global_service_project_ids.qa_serv_proj_1 # Replace this with your service project ID in quotes
}

#To attach another secon service project with host project 
resource "google_compute_shared_vpc_service_project" "service2_qa" {
  host_project    = google_compute_shared_vpc_host_project.host_qa.project
  service_project = var.global_service_project_ids.qa_serv_proj_2 # Replace this with your service project ID in quotes
}


###==========================================================#####


# Create VMs in Service Project PROD-SERV-PROJ-1
resource "google_compute_instance" "vm_machine1" {
  project      = var.global_service_project_ids.prod_serv_proj_1
  zone         = "us-west1-a"
  name         = "my-demo-vm-1"
  machine_type = "e2-medium"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.prod-vpc_subnet1.self_link
    #data.google_compute_subnetwork.subnet.self_link

  }
}

## Create a VM in Service Project DEV-SERV-PROJ-1

resource "google_compute_instance" "vm_machine2" {
  project      = var.global_service_project_ids.dev_serv_proj_1
  zone         = "us-west1-a"
  name         = "my-demo-vm-2"
  machine_type = "e2-medium"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.dev-vpc_subnet1.self_link

  }
}

## Create a VM in Service Project QA-SERV-PROJ-1

resource "google_compute_instance" "vm_machine3" {
  project      = var.global_service_project_ids.qa_serv_proj_1
  zone         = "us-west1-a"
  name         = "my-demo-vm-3"
  machine_type = "e2-medium"
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.qa-vpc_subnet1.self_link

  }
}

##########################################################
##### Required resources for Clod NAT on PRJ-HUB
##########################################################

#### 
resource "google_compute_router" "router-nat-hub" {
  name    = "router-nat-hub"
  region  = var.region
  network = google_compute_network.hub-vpc.self_link
  project = var.global_project_ids.hub
}

#### Creamos cloud NAT hub
resource "google_compute_router_nat" "nat-hub" {
  name                               = "cloud-nat-hub"
  router = google_compute_router.router-nat-hub.name
  region  = var.region
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
