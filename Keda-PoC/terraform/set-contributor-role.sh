GROUP_NAME='RG_PIX_2.0'
az ad sp create-for-rbac --role "Contributor" --scope $(az group list --query "[?contains(@.name, '$GROUP_NAME')].id" --output tsv)
