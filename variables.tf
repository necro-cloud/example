# --------------- DNS SETTINGS VARIABLES --------------- #
variable "cloudflare_token" {
  description = "Token for generating Ingress Certificates to be associated with MinIO Storage Solution"
  type        = string
  nullable    = false
}

variable "cloudflare_email" {
  description = "Email for generating Ingress Certificates to be associated with MinIO Storage Solution"
  type        = string
  nullable    = false
}

variable "domain" {
  description = "Domain for which Ingress Certificate is to be generated for"
  type        = string
  nullable    = false
}

# --------------- SMTP SERVER VARIABLES --------------- #
variable "smtp_host" {
  description = "Host of the SMTP Server to be used for sending mails"
  type        = string
  nullable    = false
}

variable "smtp_port" {
  description = "Port Number of the SMTP Server to be used for sending mails"
  type        = number
  nullable    = false
}

variable "smtp_mail" {
  description = "Mail ID of the SMTP Server to be used for sending mails"
  type        = string
  nullable    = false
}

variable "smtp_username" {
  description = "Username of the SMTP Server to be used for authentication"
  type        = string
  nullable    = false
}

variable "smtp_password" {
  description = "Password of the SMTP Server to be used for authentication"
  type        = string
  nullable    = false
}
