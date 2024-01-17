terraform {
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.2.0"
    }
  }
}

provider "mongodbatlas" {
  public_key  = var.mongodbatlas_public_key
  private_key = var.mongodbatlas_private_key
}

data "aws_caller_identity" "current_user" {}

resource "mongodbatlas_cluster" "cluster" {
  project_id = var.project_id
  name       = var.cluster_name

  disk_size_gb                 = 10
  num_shards                   = 1
  replication_factor           = 3
  cloud_backup                 = true
  auto_scaling_disk_gb_enabled = false
  mongo_db_major_version       = "7.0"

  provider_name               = "AWS"
  provider_disk_iops          = 3000
  provider_volume_type        = "STANDARD"
  provider_instance_size_name = var.cluster_size
  provider_region_name        = var.region_mongo
}

resource "mongodbatlas_network_peering" "mongo_peering" {
  project_id             = var.project_id
  accepter_region_name   = var.region_aws
  container_id           = mongodbatlas_cluster.cluster.container_id
  provider_name          = "AWS"
  route_table_cidr_block = var.vpc_cidr
  vpc_id                 = var.vpc_id
  aws_account_id         = data.aws_caller_identity.current_user.account_id
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = mongodbatlas_network_peering.mongo_peering.connection_id
  auto_accept               = true
}
