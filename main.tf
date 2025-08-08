module "helm" {
  source = "git::https://github.com/necro-cloud/modules//modules/helm?ref=main"
}

module "cluster-issuer" {
  source = "git::https://github.com/necro-cloud/modules//modules/cluster-issuer?ref=main"

  depends_on = [module.helm]
}

module "garage" {
  source                 = "git::https://github.com/necro-cloud/modules//modules/garage?ref=feature/23/garage"
  cluster_issuer_name    = module.cluster-issuer.cluster-issuer-name
  cloudflare_token       = var.cloudflare_token
  cloudflare_email       = var.cloudflare_email
  domain                 = var.domain
  replication_namespaces = "postgres"
  required_buckets       = var.garage_required_buckets
  required_access_keys   = var.garage_required_access_keys
}

# module "cnpg" {
#   source                            = "git::https://github.com/necro-cloud/modules//modules/cnpg?ref=feature/23/garage"
#   minio_certificate_authority       = module.minio.certificate-authority-name
#   minio_namespace                   = module.minio.namespace
#   cluster_issuer_name               = module.cluster-issuer.cluster-issuer-name
#   postgres_user_minio_configuration = module.minio.postgres-user-minio-configuration
#   backup_bucket_name                = module.minio.postgres-backup-bucket
#   clients = [
#     {
#       namespace          = "cloud"
#       user               = "cloud"
#       database           = "cloud"
#       derRequired        = false
#       privateKeyEncoding = "PKCS1"
#     }
#   ]

#   depends_on = [module.minio, module.garage]
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

#   depends_on = [module.cnpg]
# }

# module "valkey" {
#   source                 = "git::https://github.com/necro-cloud/modules//modules/valkey?ref=main"
#   cluster_issuer_name    = module.cluster-issuer.cluster-issuer-name
#   replication_namespaces = "cloud"
# }
