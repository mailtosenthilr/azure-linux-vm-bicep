using '../main.bicep'

param location = 'westus2'
param environment = 'lab'

param vnetName = 'vnet-iac-westus2-lab01'
param vnetAddressPrefix = '10.20.0.0/16'

param subnetName = 'snet-app'
param subnetAddressPrefix = '10.20.1.0/24'

param nicName = 'nic-linux-iac-amer-lab01'

param tags = {
  Tower: 'INFRA'
  'Created By': 'Senthilkumar Ranganathan'
  'Created On': '17-Sep-2026'
  Customer: 'Lumen'
  'Email-ID': 'v-seranganat@microsoft.com'
  Offering: 'INFRA'
  Purpose: 'Cross Skilling'
  Region: 'AMER'
  Environment: 'Lab'
  ManagedBy: 'Bicep'
}
