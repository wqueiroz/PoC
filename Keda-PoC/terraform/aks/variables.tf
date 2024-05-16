variable "resourceGroupLocation" {
  type    = string
}

variable "resourceGroupName" {
  type    = string
}

#variable "vnet_hub_name" {
#  type = string
#}
#
variable "vnet_aks_name" {
  type = string
}

#variable "vnet_hub_id" {
#  type = string
#}

variable "vnet_aks_id" {
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

variable "defaultNodeVmSize" {
  description = "Tamanho da maquina de cada no' do node pool"
  type    = string
}

variable "fileShareQuota" {
  type = number
  description = "Quantidade, em GB, de bytes que o file share pode ocupar"
  default = 96
}

variable "defaultNodeCount" {
  description = "Numero de nos do node pool"
  type    = number
}
variable "environment" {
  type    = string
  default = "PSTI-HMG"
}

variable "ssh_public_key" {
  description = "arquivo contendo a chave publica SSH"
  type    = string
  default = "ssh_keys/id_rsa.pub"
}

variable "global_tags" {
  type = map(string)
  default = {}
}

#variable "global_subnet_address_space" {
#  type = string
#}

variable "aks_subnet_address_space" {
  type = string
}

#variable "agw_subnet_address_space" {
#  type = string
#}

variable "common_tags" {
  type = map(string)
}

variable "sp_client_id" {
  description = "Service principal ID"
  type = string
}

variable "sp_client_password" {
  description = "Senha do service princiapl"
  type = string
}

variable "authenticationKey" {
  description = "chave public SSH"
  type    = string
}

variable "storageAccountName" {
  description = "Storage onde ficam os arquivos de estado do terraform e espaco de volumes do AKS"
  type = string
}

variable "applicationNodeVmSize" {
  description = "Tamanho da maquina de cada no' do node pool de aplicacoes"
  type    = string
}

variable "appNodeVmCount" {
  description = "Qte de nos do AKS"
  type    = number
}

variable "applicationNodePoolName" {
  description = "Nome do node pool de aplicacoes"
  type    = string
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
  description = "Escope da role Contributor no rg RG_PIX_2.0"
  type = string
}

variable "defaultNodePoolMaxCount" {
  description = "numero maximo de nodes no nodepool default"
  type = number
}

