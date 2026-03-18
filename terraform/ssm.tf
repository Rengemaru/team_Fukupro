resource "aws_ssm_parameter" "rails_master_key" {
  name  = "/${var.project}/RAILS_MASTER_KEY"
  type  = "SecureString"
  value = var.rails_master_key
}

# DATABASE_URLはRDSが作成されてから値が確定する。
# Terraformが自動で依存関係を解決するため、記述上は問題ない。
resource "aws_ssm_parameter" "database_url" {
  name  = "/${var.project}/DATABASE_URL"
  type  = "SecureString"
  value = "postgres://${var.db_username}:${var.db_password}@${aws_db_instance.main.endpoint}/app_production"
}
