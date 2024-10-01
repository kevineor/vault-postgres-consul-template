resource "vault_database_secret_backend_connection" "postgres" {
  backend       = var.path
  name          = "${var.database_name}_connection"
  allowed_roles = ["${var.database_name}_dev", "${var.database_name}_prod"]

  postgresql {
    connection_url = "postgresql://{{username}}:{{password}}@localhost:5435/${var.database_name}"
    username       = "postgres"
    password       = "postgres"
  }
}

resource "vault_database_secret_backend_role" "role_dev" {
  backend = var.path
  name    = "${var.database_name}_dev"
  db_name = vault_database_secret_backend_connection.postgres.name
  creation_statements = [
    "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';",
    "GRANT ALL ON ALL TABLES IN SCHEMA public TO \"{{name}}\";",
    "GRANT CREATE ON SCHEMA public TO \"{{name}}\";",
  ]
}

resource "vault_database_secret_backend_role" "role_prod" {
  backend             = var.path
  name                = "${var.database_name}_prod"
  db_name             = vault_database_secret_backend_connection.postgres.name
  creation_statements = ["CREATE ROLE \"{{name}}\" WITH SUPERUSER LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"]
}

variable "path" {

}

variable "database_name" {

}
