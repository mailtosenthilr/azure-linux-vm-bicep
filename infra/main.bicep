targetScope = 'resourceGroup'

@description('Azure region used for the lab resources.')
param location string

@description('Deployment environment such as lab, dev, test, or prod.')
param environment string

@description('Name of the virtual network.')
param vnetName string

@description('Address space assigned to the virtual network.')
param vnetAddressPrefix string

@description('Name of the application subnet.')
param subnetName string

@description('Address prefix assigned to the application subnet.')
param subnetAddressPrefix string

@description('Required organizational tags.')
param tags object

@description('Name of the private network interface.')
param nicName string

var existingSubnetNsgName = 'vnet-iac-westus2-lab01-snet-app-nsg-westus2'

resource existingSubnetNsg 'Microsoft.Network/networkSecurityGroups@2025-01-01' existing = {
  name: existingSubnetNsgName
}

module network './modules/network.bicep' = {
  name: 'deploy-network-${environment}'
  params: {
    vnetName: vnetName
    location: location
    vnetAddressPrefix: vnetAddressPrefix
    subnetName: subnetName
    subnetAddressPrefix: subnetAddressPrefix
    subnetNsgId: existingSubnetNsg.id
    tags: tags
  }
}

module nic './modules/nic.bicep' = {
  name: 'deploy-nic-${environment}'
  params: {
    nicName: nicName
    location: location
    subnetId: network.outputs.subnetId
    tags: tags
  }
}
output deployedVnetId string = network.outputs.vnetId
output deployedVnetName string = network.outputs.vnetName
output deployedSubnetId string = network.outputs.subnetId
output preservedSubnetNsgId string = existingSubnetNsg.id
output deployedNicId string = nic.outputs.nicId
output deployedNicName string = nic.outputs.nicName
