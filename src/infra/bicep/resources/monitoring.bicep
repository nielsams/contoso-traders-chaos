@description('First part of the resource name')
param nameprefix string

@description('Azure region for resources')
param location string = resourceGroup().location

var logAnalyticsWorkspaceName = '${nameprefix}logs'

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    
  }
}

output logAnalyticsWorkspaceId string = logAnalyticsWorkspace.id
