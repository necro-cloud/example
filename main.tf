module "helm" {
  source = "git::https://github.com/necro-cloud/modules//modules/helm?ref=main"
}

module "cluster-issuer" {
  source = "git::https://github.com/necro-cloud/modules//modules/cluster-issuer?ref=main"

  depends_on = [module.helm]
}

module "garage" {
  source              = "git::https://github.com/necro-cloud/modules//modules/garage?ref=feature/23/garage"
  cloudflare_token    = var.cloudflare_token
  cloudflare_email    = var.cloudflare_email
  domain              = var.domain
  cluster_issuer_name = module.cluster-issuer.cluster-issuer-name
  users               = ["cloud"]
  buckets             = ["cloud"]
}

module "minio" {
  source              = "git::https://github.com/necro-cloud/modules//modules/minio?ref=main"
  cloudflare_token    = var.cloudflare_token
  cloudflare_email    = var.cloudflare_email
  domain              = var.domain
  cluster_issuer_name = module.cluster-issuer.cluster-issuer-name
  operator_namespace  = module.helm.minio-operator-namespace
  users               = ["cloud"]
  buckets             = ["cloud"]
}

module "cnpg" {
  source                            = "git::https://github.com/necro-cloud/modules//modules/cnpg?ref=main"
  minio_certificate_authority       = module.minio.certificate-authority-name
  minio_namespace                   = module.minio.namespace
  cluster_issuer_name               = module.cluster-issuer.cluster-issuer-name
  postgres_user_minio_configuration = module.minio.postgres-user-minio-configuration
  backup_bucket_name                = module.minio.postgres-backup-bucket
  clients = [
    {
      namespace          = "cloud"
      user               = "cloud"
      database           = "cloud"
      derRequired        = false
      privateKeyEncoding = "PKCS1"
    }
  ]

  depends_on = [module.minio]
}

module "keycloak" {
  source                                     = "git::https://github.com/necro-cloud/modules//modules/keycloak?ref=main"
  cluster_issuer_name                        = module.cluster-issuer.cluster-issuer-name
  postgres_namespace                         = module.cnpg.namespace
  database_server_certificate_authority_name = module.cnpg.server-certificate-authority
  database_client_certificate_name           = "postgresql-keycloak-client-certificate"
  cloudflare_token                           = var.cloudflare_token
  cloudflare_email                           = var.cloudflare_email
  domain                                     = var.domain
  database_credentials                       = "credentials-keycloak"
  realm_settings                             = local.keycloak_realm_settings

  depends_on = [module.cnpg]
}

module "valkey" {
  source                 = "git::https://github.com/necro-cloud/modules//modules/valkey?ref=main"
  cluster_issuer_name    = module.cluster-issuer.cluster-issuer-name
  replication_namespaces = "cloud"
}
