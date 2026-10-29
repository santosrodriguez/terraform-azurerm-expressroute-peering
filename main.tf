locals {
  peering_type = "AzurePrivatePeering"
}

resource "azurerm_express_route_circuit_peering" "this" {
  peering_type                  = local.peering_type
  express_route_circuit_name    = var.express_route_circuit_name
  resource_group_name           = var.resource_group_name
  peer_asn                      = var.peer_asn
  primary_peer_address_prefix   = var.primary_peer_address_prefix
  secondary_peer_address_prefix = var.secondary_peer_address_prefix
  vlan_id                       = var.vlan_id
}
