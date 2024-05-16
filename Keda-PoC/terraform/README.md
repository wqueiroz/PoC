# Introdução
Projeto para criar o aks do PSTI de Producao

# Getting Started
Para se utilizar desse projeto é necessario instalar:
1.	terraform [download](https://www.terraform.io/downloads)
2.	Azure CLI (para o login) [download](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli)  
3.  (OPCIONAL) - Baixar a imagem de docker docker.io/eduard0claudi0/terramorfm:1.3.4 . Esta imagem ja tem o terraform (1.3.4), o Azure-cli e o jq.  

# Build / Execution
Efetue o login no azure atrav'es do Azure-cli  
> az login 

Copie o codigo fornecido e complete o processo via browser

Edite os arquivos de variaveis alterando a  
conta do service principal gerado quando da criacao  
da storage account para o state do terraform
Sao 4 os arquivos de variaveis:
- aks/variables.tf  
- kafka-vm/variables.tf  
- network/variables.tf  
- ./variables.tf  
  
Ajuste, nos mesmos arquivos, o resource group criado para o trabalho  
Esse resource group foi criado quando da execucao do  
terraform p/ criacao da storage account para o state do terraform.  
  
Execute:  
- terraform init
