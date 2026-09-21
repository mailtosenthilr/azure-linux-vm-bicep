targetScope = 'resourceGroup'

metadata description = 'Orchestrates the Azure Linux VM lab infrastructure.'

@description('Azure region for the lab resources.')
param location string

@description('Deployment environment.')
param environment string

@description('Virtual network name.')
param vnetName string

@description('Virtual network address space.')
param vnetAddressPrefix string

@description('Application subnet name.')
param subnetName string

@description('Application subnet address range.')
param subnetAddressPrefix string

@description('Common tags applied to supported resources.')
param tags object

module network './modules/network.bicep' = {
  name: 'deploy-network-${environment}'
  params: {
    location: location
    vnetName: vnetName
    vnetAddressPrefix: vnetAddressPrefix
    subnetName: subnetName
    subnetAddressPrefix: subnetAddressPrefix
    tags: tags
  }
}

output virtualNetworkName string = network.outputs.vnetName
output virtualNetworkId string = network.outputs.vnetId
output applicationSubnetName string = network.outputs.subnetName
output applicationSubnetId string = network.outputs.subnetId
