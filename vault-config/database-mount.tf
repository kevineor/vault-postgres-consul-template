locals {
  database_count = 10
}

resource "vault_mount" "db" {
  path = "database"
  type = "database"
}

# default database
module "database1" {
  source        = "./database-mount"
  path          = vault_mount.db.path
  database_name = "postgres"
}

# multiple databases
module "database2" {
  count         = local.database_count
  source        = "./database-mount"
  path          = vault_mount.db.path
  database_name = postgresql_database.my_db[count.index].name
}
