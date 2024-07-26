@description('First part of the resource name')
param nameprefix string

@description('Azure region for resources')
param location string = resourceGroup().location

var experimentName = '${nameprefix}chaos-keyvault-deny'
var chaosKvSelectorId = guid('${nameprefix}-chaos-kv-selector-id')

resource keyvault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: '${nameprefix}kv'
}

resource chaoskvtarget 'Microsoft.Chaos/targets@2022-10-01-preview' = {
  name: 'Microsoft-KeyVault'
  location: location
  scope: keyvault
  properties: {}

  // capability: kv (deny access)
  resource chaoskvcapability 'capabilities' = {
    name: 'DenyAccess-1.0'
  }
}

// chaos experiment: kv
resource chaoskvexperiment 'Microsoft.Chaos/experiments@2022-10-01-preview' = {
  name: experimentName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    selectors: [
      {
        type: 'List'
        id: chaosKvSelectorId
        targets: [
          {
            id: chaoskvtarget.id
            type: 'ChaosTarget'
          }
        ]
      }
    ]
    startOnCreation: false
    steps: [
      {
        name: 'step1'
        branches: [
          {
            name: 'branch1'
            actions: [
              {
                name: 'urn:csci:microsoft:keyVault:denyAccess/1.0'
                type: 'continuous'
                selectorId: chaosKvSelectorId
                duration: 'PT5M'
                parameters: []
              }
            ]
          }
        ]
      }
    ]
  }
}
