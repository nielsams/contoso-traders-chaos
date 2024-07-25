@description('First part of the resource name')
param nameprefix string

@description('Azure region for resources')
param location string = resourceGroup().location

@description('Set zone redundancy for all resources')
param zoneRedundant bool = false

@description('Log Analytics workspace ID for diagnostic settings')
param logAnalyticsId string


resource imagedata 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: '${nameprefix}imgstor'
  location: location
  sku: {
    name: zoneRedundant ? 'Standard_ZRS' : 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

resource imageStoreDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'metrics-to-loganalytics'
  scope: imagedata
  properties: {
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    workspaceId: logAnalyticsId
  }
}

resource uidata 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: '${nameprefix}uistor'
  location: location
  sku: {
    name: zoneRedundant ? 'Standard_ZRS' : 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

resource uiStoreDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'metrics-to-loganalytics'
  scope: uidata
  properties: {
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    workspaceId: logAnalyticsId
  }
}

output staticImageWebsiteUrl string = replace(replace(imagedata.properties.primaryEndpoints.web, 'https://',''), '/', '')
output staticUIWebsiteUrl string = replace(replace(uidata.properties.primaryEndpoints.web, 'https://',''), '/', '')
output imageStorageAccountName string = imagedata.name
output uiStorageAccountName string = uidata.name
