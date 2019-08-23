TF_VAR_azure_subscription_id=${azure_subscription_id}
TF_VAR_azure_tenant_id=${azure_tenant_id}

TF_VAR_azure_resource_group=${ws_resource_group}
TF_VAR_azure_location=${azure_location}

TF_VAR_azure_client_id=${ws_sp_client_id}
TF_VAR_azure_client_secret=${ws_sp_client_secret}

TF_VAR_storage_account_name=${ws_storage_account}
TF_VAR_storage_container_name=${ws_storage_container}
TF_VAR_storage_access_key=${ws_access_key}

TF_VAR_aks_ingress_ip_name=${ws_public_ip_name}
TF_VAR_aks_ingress_ip=${ws_public_ip_ip}
TF_VAR_aks_ingress_dns_name=${ws_public_dns_name}.${ws_public_dns_zone}
