output "alb_dns_name" {
  description = "ALBのDNS名（VITE_API_BASE_URLに登録）"
  value       = aws_lb.main.dns_name
}

output "cloudfront_domain" {
  description = "CloudFrontのドメイン名（タスク定義のenvironmentに自動設定済み）"
  value       = aws_cloudfront_distribution.frontend.domain_name
}

output "ecr_repository_url" {
  description = "ECRリポジトリのURL（ECR_REPOSITORYに登録）"
  value       = aws_ecr_repository.api.repository_url
}

output "s3_bucket_name" {
  description = "フロント用S3バケット名（S3_BUCKET_NAMEに登録）"
  value       = aws_s3_bucket.frontend.bucket
}

output "cloudfront_distribution_id" {
  description = "CloudFrontのディストリビューションID（CLOUDFRONT_DISTRIBUTION_IDに登録）"
  value       = aws_cloudfront_distribution.frontend.id
}

output "ecs_subnet_id" {
  description = "ECSタスク用サブネットID（SUBNET_IDに登録）"
  value       = aws_subnet.public_1.id
}

output "ecs_security_group_id" {
  description = "ECSタスク用セキュリティグループID（SECURITY_GROUP_IDに登録）"
  value       = aws_security_group.ecs.id
}
