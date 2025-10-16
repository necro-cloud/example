# module "helm" {
#   source = "git::https://github.com/necro-cloud/modules//modules/helm?ref=task/helm-module-upgrades"
# }

# module "cluster-issuer" {
#   source = "git::https://github.com/necro-cloud/modules//modules/cluster-issuer?ref=main"

#   depends_on = [module.helm]
# }

# module "garage" {
#   source                 = "git::https://github.com/necro-cloud/modules//modules/garage?ref=main"
#   cluster_issuer_name    = module.cluster-issuer.cluster-issuer-name
#   cloudflare_token       = var.cloudflare_token
#   cloudflare_email       = var.cloudflare_email
#   domain                 = var.domain
#   replication_namespaces = "postgres"
#   required_buckets       = var.garage_required_buckets
#   required_access_keys   = var.garage_required_access_keys
# }

# module "cnpg" {
#   source                       = "git::https://github.com/necro-cloud/modules//modules/cnpg?ref=main"
#   garage_certificate_authority = module.garage.garage_internal_certificate_secret
#   garage_namespace             = module.garage.garage_namespace
#   garage_configuration         = "walbackups-credentials"
#   cluster_issuer_name          = module.cluster-issuer.cluster-issuer-name
#   backup_bucket_name           = "postgresql"
#   clients = [
#     {
#       namespace          = "cloud"
#       user               = "cloud"
#       database           = "cloud"
#       derRequired        = false
#       privateKeyEncoding = "PKCS1"
#     }
#   ]
#   cloudflare_token = var.cloudflare_token
#   cloudflare_email = var.cloudflare_email
#   domain           = var.domain
#   depends_on       = [module.garage]
# }

# module "keycloak" {
#   source                                     = "git::https://github.com/necro-cloud/modules//modules/keycloak?ref=main"
#   cluster_issuer_name                        = module.cluster-issuer.cluster-issuer-name
#   postgres_namespace                         = module.cnpg.namespace
#   database_server_certificate_authority_name = module.cnpg.server-certificate-authority
#   database_client_certificate_name           = "postgresql-keycloak-client-certificate"
#   cloudflare_token                           = var.cloudflare_token
#   cloudflare_email                           = var.cloudflare_email
#   domain                                     = var.domain
#   database_credentials                       = "credentials-keycloak"
#   realm_settings                             = local.keycloak_realm_settings
#   depends_on                                 = [module.cnpg]
# }

# module "valkey" {
#   source                 = "git::https://github.com/necro-cloud/modules//modules/valkey?ref=main"
#   cluster_issuer_name    = module.cluster-issuer.cluster-issuer-name
#   replication_namespaces = "cloud"
# }
