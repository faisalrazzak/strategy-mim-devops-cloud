# Introduction

Implementing Azure Key Vault as a downstream certificate service is recommended if: 

* There is an increasing need to install enterprise policy compliant certificates to native Azure services like Azure Front Door, Azure application gateways, WebApps, etc.
* **(or)** Azure Platform team has the ability to use CI/CD tools like ADO, Jenkins to provision certificates to Infrastructure as a Service or 3rd party vendor integrations available in Azure.
* **(or)** There is a enterprise policy decision to manage all secrets (including certificates) in Azure Key Vault. 


![Strategy for an Azure Key Vault using a push integration model](resources/images/akv.png)

This technical document outlines (1) the procedure to integrate Venafi's TPP with Azure Key Vault using push integration model. (2) provides guidance on roles played by InfoSec, Platform and Development & Deployment teams. (3) integration with native Azure services like application gateways and front door.

\newpage

# Procedure

Following steps are required to configure integration between Venafi’s Trust Protection Platform & Azure Key Vault.

1.	Creating a client authentication certificate in TPP. 
2.	Registering an App in Azure Active Directory. 
3.	Configure the App authentication with the client certificate for OAUTH client credential flow.
4.	Configure API permissions on the App.
5.	Create an Azure KV in a Resource Group (in Hub or Spoke VNET).
6.	Assign roles & access policies to the Azure KV.

Following steps are required to provision a certificate from Venafi’s Trust Protection Platform to Azure Key Vault. 

1.	Create certificate Request
2.	Approve certificate Request
3.	Install certificate to Azure Key Vault.

Following steps should be following to configure the certificate to Azure Application Gateway.

1.	Run PowerShell script to configure certificate with Azure Application Gateway. 


\newpage

# Assigned Roles


## Platform Team as Certificate Owners

| Tasks\Teams     | InfoSec     | Platform Team     | Development & Deployment Team    |
| --------------- |:-----------:|:-----------------:|:--------------------------------:|
| Creating a client authentication certificate in TPP | R | I |  |
| Registering an App in Azure Active Directory | I | R |  |
| Configure the App authentication with the client certificate | C | R |  |
| Configure API permissions on the App |  | R |  |
| Create an Azure KV in a Resource Group (in Hub vNET) | I | R |  |
| Assign roles & access policies to the Azure KV |  | R |  |
| Create certificate Request | C/I | R |  |
| Approve certificate Request | R | I |  |
| Install certificate to Azure Key Vault | R | I |  |
| Run PowerShell script to configure certificate with Azure Application Gateway | I | R |  |



<br>

Identifier: 

R &rarr; Responsible for performing the task <br>
A &rarr; Accountable for the task <br>
C &rarr; Consulted for the task <br>
I &rarr; Informed of the task <br>

<br>

## Development & Deployment Team as Certificate Owners

| Tasks\Teams     | InfoSec     | Platform Team     | Development & Deployment Team    |
| --------------- |:-----------:|:-----------------:|:--------------------------------:|
| Creating a client authentication certificate in TPP | R | I |  |
| Registering an App in Azure Active Directory | I | R |  |
| Configure the App authentication with the client certificate | C | R |  |
| Configure API permissions on the App |  | R |  |
| Create an Azure KV in a Resource Group (in spoke vNET) | I | C | R |
| Assign roles & access policies to the Azure KV |  | R/A | C/R |
| Create certificate Request | C/I |  | R |
| Approve certificate Request | R |  | I |
| Install certificate to Azure Key Vault | R |  | I |
| Run PowerShell script to configure certificate with Azure Application Gateway | I | R/A | C/R |


<br>

Identifier: 

R &rarr; Responsible for performing the task <br>
A &rarr; Accountable for the task <br>
C &rarr; Consulted for the task <br>
I &rarr; Informed of the task <br>

\newpage

<br>

# Procedure Details

## Creating a client authentication certificate in TPP

1. Create a certificate object in TPP & Renew the certificate object. From Microsoft identity platform, there is no defined criteria on the kind of certificate needed. Essentially, it is being used as a public/private keypair. 

![client authentication certificate](resources/images/1.png)

## Registering an App in Azure Active Directory

1. Login to [Azure Portal](https://portal.azure.com)
2. Browse to Azure Active Directory
3. Browse to **App registration**
4. Click on **New registration** 

![New Registration](resources/images/2.png)

5. Give the App a sample name (forexample, **VenafiAppAuth**) & click **Register**

![Register App](resources/images/3.png)

## Configure the App authentication with the client certificate

1. Download the client authentication certificate from TPP. 

![Download client authentication certificate](resources/images/4.png)

2. Select **PEM** as the download format and click **Download**

![PEM certificate](resources/images/5.png)

3. Login to [Azure Portal](https://portal.azure.com)
4. Browse to the registered application
5. Click on **Certificates & secrets**. This is where app is configured to use OAUTH client authorization flow for authentication.

![App Authentication](resources/images/6.png)

6. Under **Certificates** frame, click on **Upload certificate** & upload the client authentication certificate.

![Upload certificate](resources/images/7.png)

## Configure API permissions on the App

1. Login to [Azure Portal](https://portal.azure.com)
2. Browse to Azure Active Directory
3. Click on **API permissions**

![APP API permissions](resources/images/8.png)

4. Add following permissions from Microsoft APIs
   1. Azure Key Vault (Type: Delegated)
   2. Azure Service Management (Type: Delegated)
   3. Microsoft Graph (Type: Delegated)

![APP API permissions assigned](resources/images/9.png)

## Create an Azure KV in a Resource Group

1. Login to [Azure Portal](https://portal.azure.com)
2. Create Azure Key Vault. This document shows a manual procedure to deploy AKV, however, enterprises will generally use ARM templates or IaC tools to provision AKV along with other required services.

![APP API permissions assigned](resources/images/10.png)

## Assign roles & access policies to the Azure KV 

An application service principle can access a KV either using RBAC or using access policies. 

### Access Policies to Azure KV

1. Browse to the created Azure KV & click **Access Control (IAM)**

![KV Access Control](resources/images/11.png)

2. Assign **Key Vault Contributor" role to the App "VenafiAppAuth". In this documentation, the scope of the role is assigned at resource level, however, it may also be assigned at Resource Group level (if multiple KVs exist in 1 Resource Group).

![KV Access Control - KV Contributor](resources/images/12.png)

3. Browse to **Access policies**

![KV Access Policies](resources/images/13.png)

4. Assign **GET** secret permissions to "VenafiAppAuth"

![Secret Permissions](resources/images/14.png)

5. Assign **GET, UPDATE, LIST, CREATE, IMPORT** certificate permissions to "VenafiAppAuth.

![Certificate Permissions](resources/images/15.png)

6. Click **SAVE**

![Save Access Policies](resources/images/16.png)

### Role based access control (RBAC)

1. Browse to the created Azure KV & click **Access policies**

![KV Access Policies](resources/images/13.png)

2. Select **Azure role-based access control** & click **SAVE**

![Azure role-based access control](resources/images/17.png)

3. Now you can create Custom Roles at the subscription or resource group level. 
   1. [AKV RBAC role for provisioning](resources/policies/KV-Provisioning-Role.json)
   2. [AKV RBAC role for discovery](resources/policies/KV-Discovery-Role.json)
4. Click **Access Control (IAM)** on created Azure KV.

![KV Access Control](resources/images/11.png)

5. Assign custom roles to the App "VenafiAppAuth".

![Azure role-based access control - Custom Roles](resources/images/18.png)

## Create Certificate Request

Before provisioning a certificate from TPP to Azure Key Vault, following information related to certificate request is needed. 

1.	Common Name and SANs
2.	Name of Azure Key Vault
3.	Application (client) ID of the Registered App in Azure Active Directory.

## Configure TPP to provision certificate to Azure Key Vault

1. Create a certificate credential in TPP using client authentication certificate. 

![Certificate Credential in TPP](resources/images/19.png)

2. Create Device, Azure Key Vault application & certificate objects in TPP. 
3. At Application level, configure: 
   1. Application (client) ID.
   2. Certificate Credential created earlier.
   3. Name of Azure Key Vault
   4. Assign a name to the certificate
   5. Set "Private Key Exportable" to "Yes"

![Azure application in TPP](resources/images/20.png)

4. At the certificate object level, configure following properties & renew the object.
   1. Common Name
   2. SANs
   3. Management Type to "Provisioning".

![Azure certificate in TPP](resources/images/21.png)

## Run PowerShell script to configure certificate with Azure Application Gateway


This PowerShell script can be triggered from any CI/CD pipeline tool. For example, Azure DevOps, Jenkins, etc.

<br>


<code>
$AppGW = Get-AzApplicationGateway -Name "ApplicationGateway01" -ResourceGroupName "ResourceGroup01"
$secret = Get-AzKeyVaultCertificate -VaultName "keyvault01" -Name "sslCert01"
$secretId = $secret.SecretId.Replace($secret.Version, "") # https://<keyvaultname>.vault.azure.net/secrets/
$AppGW = Add-AzApplicationGatewaySslCertificate -ApplicationGateway $AppGW -Name "Cert01" -KeyVaultSecretId $secretId
</code>

<br>

<br>

More details can be found at [link](https://docs.microsoft.com/en-us/powershell/module/az.network/add-azapplicationgatewaysslcertificate)
