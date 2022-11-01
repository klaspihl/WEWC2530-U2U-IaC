// @description('The Azure region into which the resources should be deployed.')
// param location string = resourceGroup().location

@description('The Azure regions into which the resources should be deployed.')
param locations array = [
  'westeurope'
  'eastus2'
]

// @description('The name of the App Service app.')
// param appServiceAppName string = 'u2u${uniqueString(resourceGroup().id)}'

@description('The name of the environment. This must be dev, test, or prod.')
@allowed([
  'dev'
  'test'
  'prod'
])
param environmentName string = 'dev'

var appServicePlanSkuName = (environmentName == 'dev') ? 'F1' : 'B1'

module app 'Modules/webapp-module.bicep' = [for location in locations: {
  name: 'bicep-lab-${location}'
  params: {
    appServiceAppName: 'u2u-${location}-${uniqueString(resourceGroup().id)}'
    appServicePlanName: 'sp-${environmentName}-${location}-bicep-lab'
    appServicePlanSkuName: appServicePlanSkuName
    location: location
  }
}]

@description('The host name to use the access the website')
output websiteHostNames array = [for index in range(0, length(locations)): app[index].outputs.appServiceAppHostName]
// output websiteHostNames array = [for location in locations: reference(resourceId('Microsoft.Web/sites', 'u2u-${location}-${uniqueString(resourceGroup().id)}'), '2021-02-01').defaultHostName]

var sqlServerName = '${environmentName}-sql-bicep-lab-u2u'
var sqlDatabaseName = 'Employees'

module sql 'Modules/sqlserver-module.bicep' = if( environmentName == 'dev') {
  name: sqlServerName
  params: {
    sqlDatabaseName: sqlDatabaseName
    sqlServerAdministratorLogin: 'u2uadmin'
    sqlServerAdministratorPassword: 'U2U-secretsecret'
    sqlServerName: sqlServerName
  }
}
