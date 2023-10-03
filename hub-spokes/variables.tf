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
    hub  = "prd-promartec-hub-project"
    prod = "prd-promartec-prd-project"
    qa   = "qa-promartec-qa-project"
    dev  = "dev-promartec-dev-project"
  }
}

variable "global_service_project_ids" {
  description = "Service Project ids"
  type        = map(string)
  default = {
    prod_serv_proj_1 = "prd-promartec-service-project1"
    prod_serv_proj_2 = "prd-promartec-service-project2"
    dev_serv_proj_1  = "dev-promartec-service-project1"
    dev_serv_proj_2  = "dev-promartec-service-project2"
    qa_serv_proj_1   = "qa-promartec-service-project1"
    qa_serv_proj_2   = "qa-promartec-service-project2"
  }
}

variable "vpc_subnets_name" {
  description = "subnets and CIDRs"
  type        = map(string)
  default = {
    name-hub-subnet-1 = "hub-subnet-1"
    name-hub-subnet-2 = "hub-subnet-2"

    name-prod-subnet-1 = "prod-subnet-1"
    name-prod-subnet-2 = "prod-subnet-2"

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
  default     = "us-west1"
}

variable "asn" {
  description = "VPC ASNs"
  type        = map(string)
  default = {
    hub  = "64514"
    prod = "64515"
    dev  = "64516"
    qa   = "64517"
  }
}

variable "regions" {
  description = "regions for deployments"
  type        = map(string)
  default = {
    primary   = "us-west1"
    secondary = "us-central1"
  }
}
