variable "express_route_circuit_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "peer_asn" {
  type = number
}

variable "primary_peer_address_prefix" {
  type = string
}

variable "secondary_peer_address_prefix" {
  type = string
}

variable "vlan_id" {
  type = number
}
