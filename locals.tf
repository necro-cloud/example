locals {
  keycloak_realm_settings = {
    application_name = "cloud"
    smtp_host        = var.smtp_host
    smtp_port        = var.smtp_port
    smtp_mail        = var.smtp_mail
    smtp_username    = var.smtp_username
    smtp_password    = var.smtp_password
  }
}
