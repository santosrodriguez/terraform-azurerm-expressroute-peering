# ExpressRoute Circuit Peering

## Overview

This Terraform module creates an Azure ExpressRoute circuit peering configuration using the `azurerm_express_route_circuit_peering` resource. It configures Azure private peering for an existing ExpressRoute circuit.

## What This Module Deploys

- One `azurerm_express_route_circuit_peering` resource.
- Azure Private Peering using the fixed peering type `AzurePrivatePeering`.
- Primary and secondary peer address prefixes.
- Peer ASN configuration.
- VLAN ID assignment for the peering.

## Requirements

| Requirement | Details |
|---|---|
| Required Terraform version | Not explicitly defined. |
| Required providers | `azurerm` is used by the module resources. |
| Required provider versions | Not explicitly defined. |
| Azure prerequisites | An existing ExpressRoute circuit must already exist. |
| Required permissions or role assumptions | Not explicitly defined. Permissions must allow managing ExpressRoute circuit peerings in the target resource group. |

## Required Parameters

| Name | Type | Description |
|---|---|---|
| `express_route_circuit_name` | `string` | Name of the existing Azure ExpressRoute circuit. |
| `resource_group_name` | `string` | Name of the resource group containing the ExpressRoute circuit. |
| `peer_asn` | `number` | Peer ASN used for the ExpressRoute circuit peering. |
| `primary_peer_address_prefix` | `string` | Primary peer address prefix for the peering. |
| `secondary_peer_address_prefix` | `string` | Secondary peer address prefix for the peering. |
| `vlan_id` | `number` | VLAN ID used for the ExpressRoute circuit peering. |

## Optional Parameters

| Name | Type | Default | Description |
|---|---|---|---|

This module does not currently define any optional parameters.

## Default Parameter Values

| Parameter | Default Value | Purpose |
|---|---|---|
| `local.peering_type` | `"AzurePrivatePeering"` | Sets the ExpressRoute peering type to Azure Private Peering. |

## Minimum Required Example

```hcl
module "express_route_private_peering" {
  source = "./modules/express-route-private-peering"

  express_route_circuit_name    = "er-circuit-dev-eastus-001"
  resource_group_name           = "rg-network-dev-eastus-001"
  peer_asn                      = 65010
  primary_peer_address_prefix   = "10.10.0.0/30"
  secondary_peer_address_prefix = "10.10.0.4/30"
  vlan_id                       = 200
}
```

## Full Example

```hcl
module "express_route_private_peering" {
  source = "./modules/express-route-private-peering"

  express_route_circuit_name    = "er-circuit-prod-eastus-001"
  resource_group_name           = "rg-network-prod-eastus-001"
  peer_asn                      = 65020
  primary_peer_address_prefix   = "10.20.0.0/30"
  secondary_peer_address_prefix = "10.20.0.4/30"
  vlan_id                       = 300
}
```

## Outputs

| Name | Description |
|---|---|

This module does not currently define any outputs.

## Best Practices

- Use a consistent naming convention for the existing ExpressRoute circuit and resource group.
- Separate environments such as `dev`, `test`, and `prod` by using different ExpressRoute circuits, resource groups, or Terraform states.
- Store Terraform state remotely, such as in an Azure Storage Account, to support collaboration and state locking.
- Coordinate `peer_asn`, `primary_peer_address_prefix`, `secondary_peer_address_prefix`, and `vlan_id` values with your network or connectivity provider before deployment.
- Ensure the primary and secondary peer address prefixes do not overlap with other network ranges.
- Manage access to this module through Azure RBAC so only authorized platform or network engineers can update ExpressRoute peering.
- Use Azure governance controls such as resource group organization, naming standards, and policy assignments around the ExpressRoute circuit and networking resources.

## Notes

- The module sets `peering_type` through a local value named `local.peering_type`.
- The peering type is fixed to `"AzurePrivatePeering"` and is not configurable through a variable.
- The module creates exactly one `azurerm_express_route_circuit_peering` resource named `azurerm_express_route_circuit_peering.this`.
- The module does not define `count`, `for_each`, conditional logic, or dynamic blocks.
- The module does not create the ExpressRoute circuit itself. The circuit must already exist.
- The module does not define tags because `azurerm_express_route_circuit_peering` in this code does not configure tagging.
- The module does not define provider configuration, required provider versions, Terraform version constraints, or outputs.
