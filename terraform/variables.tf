variable "project" {
  type        = string
  description = "リソース名のプレフィックス"
  default     = "weather-roguelite"
}

variable "aws_account_id" {
  type        = string
  description = "AWSアカウントID（12桁）"
}

variable "github_org" {
  type        = string
  description = "GitHubユーザー名またはOrg名"
}

variable "github_repo" {
  type        = string
  description = "リポジトリ名"
}

variable "db_username" {
  type        = string
  description = "RDSのDBユーザー名"
  default     = "postgres"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "RDSのDBパスワード（planで非表示）"
}

variable "rails_master_key" {
  type        = string
  sensitive   = true
  description = "backend/config/master.keyの内容（planで非表示）"
}
