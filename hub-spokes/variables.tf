# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "global_project_ids" {
  description = "Project ids"
  type        = map(string)
  default = {
    hub  = "central-hub-401222"
    prod = "onpremise-401222"
    qa   = "qa-pagos"
    dev  = "dev-pagos"
  }
}

variable "global_service_project_ids" {
  description = "Service Project ids"
  type        = map(string)
  default = {
    prod_serv_proj_1 = "onpremise-sp-1"
    prod_serv_proj_2 = "onpremise-sp-2"
    dev_serv_proj_1  = "dev-pagos-sp-1"
    dev_serv_proj_2  = "dev-pagos-sp-2"
    qa_serv_proj_1   = "qa-pagos-sp-1"
    qa_serv_proj_2   = "qa-pagos-sp-2"

  }
}

variable "vpc_subnets_name" {
  description = "subnets and CIDRs"
  type        = map(string)
  default = {
    name-hub-subnet-1 = "hub-subnet-1"
    name-hub-subnet-2 = "hub-subnet-2"

    name-prod-subnet-1 = "onprem-subnet-1"
    name-prod-subnet-2 = "onprem-subnet-2"

    name-dev-subnet-1 = "dev-subnet-1"
    name-dev-subnet-2 = "dev-subnet-2"

    name-qa-subnet-1 = "qa-subnet-1"
    name-qa-subnet-2 = "qa-subnet-2"
  }
}

variable "vpc_subnets_cidr" {
  description = "subnets and CIDRs"
  type        = map(string)
  default = {
    cidr-hub-subnet-1 = "10.239.0.0/24"
    cidr-hub-subnet-2 = "10.239.1.0/24"

    cidr-prod-subnet-1 = "10.239.4.0/24"
    cidr-prod-subnet-2 = "10.239.5.0/24"

    cidr-dev-subnet-1 = "10.239.8.0/24"
    cidr-dev-subnet-2 = "10.239.9.0/24"

    cidr-qa-subnet-1 = "10.239.12.0/24"
    cidr-qa-subnet-2 = "10.239.13.0/24"
  }
}

variable "region" {
  description = "VPC region"
  type        = string
  default     = "southamerica-west1"
}

variable "asn" {
  description = "VPC ASNs"
  type        = map(string)
  default = {
    hub  = "65427"
    prod = "65428"
    dev  = "65429"
    qa   = "65430"
  }
}

variable "regions" {
  description = "regions for deployments"
  type        = map(string)
  default = {
    primary   = "southamerica-west1"
    secondary = "us-central1"
  }
}
