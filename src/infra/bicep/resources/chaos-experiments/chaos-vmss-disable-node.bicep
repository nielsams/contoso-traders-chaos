@description('First part of the resource name')
param nameprefix string

@description('Azure region for resources')
param location string = resourceGroup().location

var contributorRoleId = 'b24988ac-6180-42a0-ab88-20f7382dd24c'
var chaosName = '${nameprefix}-chaos-disable-vmss-node'

// TODO
