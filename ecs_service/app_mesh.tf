resource "aws_appmesh_route" "route" {
  name                = var.service
  mesh_name           = var.app_mesh_id
  virtual_router_name = aws_appmesh_virtual_router.router.name

  spec {
    tcp_route {
      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.node.name
          weight       = 100
        }
      }
    }
  }
}

resource "aws_appmesh_virtual_router" "router" {
  name      = "${var.environment}-${var.project_name}-${var.service}"
  mesh_name = var.app_mesh_id

  spec {
    listener {
      port_mapping {
        port     = var.container_port
        protocol = "tcp"
      }
    }
  }
}

resource "aws_appmesh_virtual_service" "service" {
  name      = "${var.service}.${var.environment}-${var.project_name}.local"
  mesh_name = var.app_mesh_id

  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.router.name
      }
    }
  }
}

resource "aws_appmesh_virtual_node" "node" {
  name      = "${var.environment}-${var.project_name}-${var.service}"
  mesh_name = var.app_mesh_id

  spec {
    backend {
      virtual_service {
        virtual_service_name = aws_appmesh_virtual_service.service.name
      }
    }

    listener {
      port_mapping {
        port     = var.container_port
        protocol = "tcp"
      }
    }

    service_discovery {
      aws_cloud_map {
        attributes = {
          ECS_SERVICE_NAME = "${var.environment}-${var.project_name}-${var.service}"
        }

        service_name   = var.service
        namespace_name = "${var.environment}-${var.project_name}.local"
      }
    }
  }
}
