metadata description = 'Deploys a virtual network and application subnet.'

@description('Azure region for the network resources.')
param location string

@description('Name of the virtual network.')
param vnetName string

@description('Virtual network address space.')
param vnetAddressPrefix string

@description('Name of the application subnet.')
param subnetName string

@description('Application subnet address range.')
param subnetAddressPrefix string

@description('Tags applied to the virtual network.')
param tags object

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2025-01-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    enableDdosProtection: false
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
        }
      }
    ]
  }
}

output vnetName string = virtualNetwork.name
output vnetId string = virtualNetwork.id
output subnetName string = subnetName
output subnetId string = resourceId(
  'Microsoft.Network/virtualNetworks/subnets',
  virtualNetwork.name,
  subnetName
)
