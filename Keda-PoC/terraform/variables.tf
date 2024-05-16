variable "resourceGroupName" {
  description = "Nome do resource Group onde os recursos desse bloco serao criados"
  type    = string
  default = "rg-keda-poc"
}

variable "storageAccountName" {
  description = "Nome do storage account onde armazenar os  state files"
  type = string
}

variable "tsStateContainerName" {
  description = "Nome do container blob onde armazenar os  state files"
  type    = string
  default = "terraform-state-files"
}

variable "environment" {
  description = "Ambiente onde os recursos estarao alocados"
  type    = string
  default = "PoC"
}

variable "aks_subnet_address_space" {
  type = string
}

variable "aksClusterName" {
  description = "Nome do cluster AKS"
  type    = string
}

variable "defaultNodePoolName" {
  description = "Nome do node pool"
  type    = string
}

variable "applicationNodePoolName" {
  description = "Nome do node pool de aplicacoes"
  type    = string
}

variable "authenticationKey" {
  description = "chave public SSH"
  type    = string
}

variable "vnet_aks_address_space" {
  type = string
}

variable "ssh_public_key" {
  description = "Chave de acesso SSH"
  type    = string
  default = "ssh_keys/id_rsa.pub"
}

variable "global_tags" {
  description = "Tags extras"
  type = map(string)
  default = {}
}

variable "aks_service_principal_client_id" {
  description = "Service Principal"
  type    = string
  default = "584cb691-7b82-4b0b-a099-7ac3d730554c"
}

variable "aks_service_principal_client_secret" {
  description = "Senha do service principal"
  type    = string
  default = "1ty8Q~rP5zvJjUYIOql7HO9_~cLt4OQShSfdmcrX"
}

variable "sp_client_id" {
  description = "Service principal ID"
  type = string
  default = "584cb691-7b82-4b0b-a099-7ac3d730554c"
}

variable "sp_client_password" {
  description = "Senha do service princiapl"
  type = string
  default = "1ty8Q~rP5zvJjUYIOql7HO9_~cLt4OQShSfdmcrX"
}

variable "vmSize" {
  description = "Tamanho da m'aquina virtual do kafka"
  type    = string
  default = "Standard_D8s_v5"
}

variable "defaultNodeCount" {
  description = "Qte de nos do AKS"
  type    = number
  default = 2
}

variable "defaultNodeVmSize" {
  description = "Tamanho da maquina de cada no' do node pool"
  type    = string
  default = "Standard_F4" # CPU=4 / Mem=8GB / Disco/64GB / Rede=high
}

variable "applicationNodeVmSize" {
  description = "Tamanho da maquina de cada no' do node pool de aplicacoes"
  type    = string
  default = "Standard_F4"
}

variable "appNodeVmCount" {
  description = "Qte de nos do AKS"
  type    = number
  default = 3
}

variable "enableNodePoolAutoScale" {
  description = "Determina se o nodepool tem (ou nao) crescimento automatico"
  type = bool
}

variable "appNodePoolMinCount" {
  description = "determina o numero minimo de nos no pool"
  type = number
}

variable "appNodePoolMaxCount" {
  description = "determina o numero maximo de nos no pool"
  type = number
}

variable "roleContributorScopeRGPIX" {
  description = "Escopo da role Contributor no rg RG_PIX_2.0"
  type = string
}

variable "vnet_aks_name" {
  description = "nome da vnet do aks"
  type = string
}

variable "defaultNodePoolMaxCount" {
  description = "numero maximo de nodes no nodepool default"
  type = number
}
