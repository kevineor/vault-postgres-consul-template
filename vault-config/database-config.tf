resource "postgresql_database" "my_db" {
  count = local.database_count
  name  = "postgres_${count.index}"
  owner = "postgres"
}
