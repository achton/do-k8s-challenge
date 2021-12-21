resource "digitalocean_kubernetes_cluster" "achtonml-cluster" {
  name    = "achtonml-cluster"
  region  = var.do_region
  # list versions with `doctl kubernetes options versions`
  version = var.cluster_version

  auto_upgrade = true

  tags = ["k8s-challenge"]

  # This default node pool is mandatory
  node_pool {
    name       = "default-pool"
    size       = "s-2vcpu-2gb" # minimum size, list available options with `doctl compute size list`
    node_count = 1
    labels     = {}
    tags       = []
 }
}

# Another node pool for applications
resource "digitalocean_kubernetes_node_pool" "app" {
  cluster_id = digitalocean_kubernetes_cluster.achtonml-cluster.id

  name = "app-pool"
  size = "c-4" # bigger instances
  tags = ["applications"]

  auto_scale = true
  min_nodes  = 2
  max_nodes  = 6
  labels = {
    service  = "apps"
  }
}
