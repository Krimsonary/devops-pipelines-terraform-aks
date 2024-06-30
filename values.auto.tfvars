aks_vnet_name = "aksteravnet"

sshkvsecret = "sshteraakskey"

clientidkvsecret = "spn-id"

spnkvsecret = "spn-secret"

vnetcidr = ["10.2.0.0/24"]

subnetcidr = ["10.2.0.0/25"]

keyvault_rg = "tera-aks-akv-rg"

keyvault_name = "tera-aks-dev-pipe"

azure_region = "centralus"

resource_group = "teraakscluster-rg"

cluster_name = "teraakscluster"

dns_name = "teraakscluster"

admin_username = "teraaksuser"

kubernetes_version = "1.21.7"

agent_pools = {
      name            = "pool1"
      count           = 2
      vm_size         = "Standard_D2_v2"
      os_disk_size_gb = "30"
    }
