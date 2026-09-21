@description('Name of the network interface.')
param nicName string

@description('Azure region for the network interface.')
param location string

@description('Resource ID of the subnet.')
param subnetId string

@description('Required organizational tags.')
param tags object

resource nic 'Microsoft.Network/networkInterfaces@2025-01-01' = {
  name: nicName
  location: location
  tags: tags
  properties: {
    enableAcceleratedNetworking: false
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetId
          }
        }
      }
    ]
  }
}

output nicId string = nic.id
output nicName string = nic.name
output privateIpAddress string = nic.properties.ipConfigurations[0].properties.privateIPAddress
