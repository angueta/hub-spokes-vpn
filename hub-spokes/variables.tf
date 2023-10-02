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
    hub  = "hub-project-397918"
    prod = "prod-project-397918"
    qa   = "qa-project-397918"
    dev  = "dev-project-397918"
  }
}

variable "global_service_project_ids" {
  description = "Service Project ids"
  type        = map(string)
  default = {
    prod_serv_proj_1 = "prod-service-project1-398201"
    prod_serv_proj_2 = "prod-service-project2-398201"
    dev_serv_proj_1  = "dev-service-project1-398201"
    dev_serv_proj_2  = "dev-service-project2-398201"
    qa_serv_proj_1   = "qa-service-project1"
    qa_serv_proj_2   = "qa-service-project2"
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
    cidr-hub-subnet-1 = "10.0.1.0/24"
    cidr-hub-subnet-2 = "10.0.2.0/24"

    cidr-prod-subnet-1 = "192.168.1.0/24"
    cidr-prod-subnet-2 = "192.168.2.0/24"

    cidr-dev-subnet-1 = "192.168.101.0/24"
    cidr-dev-subnet-2 = "192.168.102.0/24"

    cidr-qa-subnet-1 = "192.168.201.0/24"
    cidr-qa-subnet-2 = "192.168.202.0/24"
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

