@description('First part of the resource name')
param nameprefix string

@description('Azure region for resources')
param location string = resourceGroup().location

// First experiment: Disable a VMSS node
module chaos1 '../chaos-experiments/chaos-vmss-disable-node.bicep' = {
  name: '${nameprefix}-chaos-1'
  params: {
    nameprefix: nameprefix
    location: location
  }
}

// Second experiment: Deny access to a Key Vault
module chaos2 '../chaos-experiments/chaos-keyvault-deny.bicep' = {
  name: '${nameprefix}-chaos-2'
  params: {
    nameprefix: nameprefix
    location: location
  }
}


// References to next experiments to be added here. 
