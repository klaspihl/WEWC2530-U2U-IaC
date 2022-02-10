<#
.SYNOPSIS
    Collection of commandlets used in U2U course on 'Infrastructure as Code with Terraform, ARM Templates & Bicep'
    2022-02-10
#>
#region connect to Azure and subscription
Connect-AzAccount
Set-AzContext -Subscription (Read-Host -Prompt "Subscription")
$ResourceGroup = 'klpih-u2u'
#endregion connect to Azure and subscription

#region Deploy SQL server
Test-AzResourceGroupDeployment -ResourceGroupName $ResourceGroup -TemplateFile .\sqltemplate.json -TemplateParameterFile .\sqlparam.json
Get-AzResourceGroupDeploymentWhatIfResult -ResourceGroupName $ResourceGroup -TemplateFile .\sqltemplate.json -TemplateParameterFile .\sqlparam.json -ResultFormat FullResourcePayloads
New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroup -TemplateFile .\sqltemplate.json -TemplateParameterFile .\sqlparam.json -Name DeploySQL1
#endregion Deploy SQL server

#region Deploy databases on server
Test-AzResourceGroupDeployment -ResourceGroupName $ResourceGroup -TemplateFile .\sqldbtemplate.json -TemplateParameterFile .\sqldbparam.json
Get-AzResourceGroupDeploymentWhatIfResult -ResourceGroupName $ResourceGroup -TemplateFile .\sqldbtemplate.json -TemplateParameterFile .\sqldbparam.json -ResultFormat FullResourcePayloads
New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroup -TemplateFile .\sqldbtemplate.json -TemplateParameterFile .\sqldbparam.json -Name DeploySQLDB1
#endregion Deploy databases on server

#region Deploy database server and databases by linked ARM templates
Test-AzResourceGroupDeployment -ResourceGroupName $ResourceGroup -TemplateFile .\sqlmain.json
Get-AzResourceGroupDeploymentWhatIfResult -ResourceGroupName $ResourceGroup -TemplateFile .\sqlmain.json -ResultFormat FullResourcePayloads
New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroup -TemplateFile .\sqlmain.json -Name DeploySQLDB1
#endregion Deploy database server and databases by linked ARM templates