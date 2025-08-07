output "clusters" {
  description = "Information about the AKS clusters"
  value = {
    for k, cluster in azurerm_kubernetes_cluster.aks : k => {
      name = cluster.name
      id   = cluster.id
      fqdn = cluster.fqdn
    }
  }
}
