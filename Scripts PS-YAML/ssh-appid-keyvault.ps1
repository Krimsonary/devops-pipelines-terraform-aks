### The following are the parameters for the powershell script to create and add to the azure key vault, make changes to the values as required

$keyvaultname = "tera-aks-dev-pipe"
$location = "centralus"
$keyvaultrg = "tera-aks-akv-rg"
$sshkeysecret = "sshteraakskey"
$clientidkvsecretname = "spn-id"
$spnkvsecretname = "spn-secret"
$spAppID = ### Input the App ID in qutations of the Service Principal which can be found under Microsoft Entra ID then App Registrations, select and copy the App App ID.
$spnclientsecret = ### As described in the App registration section needs to be generated before use.
$userobjectid = ### Input your Object ID within quotations, you can find it under Microsoft Entra ID then go to Users then select a user and copy the Object ID.


### Making the Key Vault

New-AzResourceGroup -Name $keyvaultrg -Location $location
New-AzKeyVault -Name $keyvaultname -ResourceGroupName $keyvaultrg -Location $location
Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -UserPrincipalName $userobjectid -PermissionsToSecrets get,set,delete,list


### Creating an ssh key for setting up password-less login between agent nodes.

ssh-keygen  -f ~/.ssh/id_rsa_terraform


### Adding the SSH Key in Azure Key vault secret

$pubkey = cat ~/.ssh/id_rsa_terraform.pub
$Secret = ConvertTo-SecureString -String $pubkey -AsPlainText -Force
Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $sshkeysecret -SecretValue $Secret


### Storing the service principal Client id in Azure KeyVault

$Secret = ConvertTo-SecureString -String $spAppID -AsPlainText -Force
Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $clientidkvsecretname -SecretValue $Secret


### Storing the service principal Secret in Azure KeyVault

$Secret = ConvertTo-SecureString -String $spnclientsecret -AsPlainText -Force
Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $spnkvsecretname -SecretValue $Secret


### Granting access to a Key Vault secret for the service principal using Azure Key Vault access policies

Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -ServicePrincipalName $spAppID -PermissionsToSecrets Get,Set