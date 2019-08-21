#!/usr/bin/env fish

echo "Get Docker environment"
eval (dm env)

set base ace-workshop-2019
set id foo

set subId (az account show --query "id" --output tsv)
set tenantId (az account show --query "tenantId" --output tsv)
set rgName $base-$id
set location northeurope
set spName $rgName
set saName (echo $rgName | sed 's/-//g')
set scName terraform-state

echo "Checking if resource group '$rgName' exists"
set rgId (az group show --name $rgName --query "id" --output tsv | string trim)
if test !$status && test "$rgId" != ""
  echo "Resource group already exists!"
else
  echo "Creating resource group '$rgName'.."
  set rgId (az group create \
    --location $location \
    --name $rgName \
    --tags "env=workshop" \
    --query "id" \
    --output tsv)
end

echo "Resource group: $rgId"

echo "--"
echo "Checking if Service Principal '$spName' exists"
set spId (az ad sp list \
  --display-name $spName \
  --query "[].appId" \
  --output tsv || "")
if test "$spId" = ""
  echo "Creating service principal $spName.."

  set sp (az ad sp create-for-rbac \
    --name "http://$spName" \
    --role "contributor" \
    --scopes "$rgId" \
    --query "[appId, password]" \
    --output tsv | tail -n 2 | string split "\n")

  set spId $sp[1]
  set spPass $sp[2]

  #echo "Remove contributor role"
  #az role assignment delete --assignee $spId --role Contributor
else
  echo "Service principal already exists"
  echo "Lets set a new password for it.."
  set spPass (az ad sp credential reset \
    --name $spName \
    --query password \
    --output tsv)
end
echo "Service principal: $spId"

echo "--"
echo "Checking if Storage Account exists.."
set saId (az storage account show --name $saName --output tsv --query id)
if test $status = 0 && test "$saId" != ""
  echo "Storage Account already exists!"
else
  echo "Creating Storage Account.."
  set saId (az storage account create \
    --name "$saName" \
    --resource-group "$rgName" \
    --location "$location" \
    --tags "env=workshop" \
    --output tsv \
    --query id)

  echo "Creating Storage Container.."
  az storage container create --name "$scName" --account-name "$saName"
end
echo "Storage Account: $saId"

echo "Getting Storage Account key.."
set saKey (az storage account keys list \
  --account-name "$saName" \
  --resource-group "$rgName" \
  --query "[?keyName == `key1`].{value:value}" \
  --output tsv)
echo "Storage Account key: $saKey"

echo "--"
echo "ARM_SUBSCRIPTION_ID=$subId"
echo "ARM_TENANT_ID=$tenantId"
echo "--"
echo "ARM_CLIENT_ID=$spId"
echo "ARM_CLIENT_SECRET=$spPass"
echo "--"
echo "AZURE_SA_ID=$saName"
echo "AZURE_SA_KEY=$saKey"
