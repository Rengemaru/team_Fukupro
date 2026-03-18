resource "aws_s3_bucket" "frontend" {
  bucket        = "${var.project}-frontend"
  force_destroy = true

  tags = { Name = "${var.project}-frontend" }
}

resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# バケットポリシーはCloudFrontのARNを参照するため、
# aws_s3_bucket内にインライン記述せず必ず別リソースで定義すること。
# インライン記述を試みるとCloudFrontとの循環参照エラーが発生する。
resource "aws_s3_bucket_policy" "frontend" {
  bucket = aws_s3_bucket.frontend.id
  policy = data.aws_iam_policy_document.frontend_s3.json

  depends_on = [aws_cloudfront_distribution.frontend]
}

data "aws_iam_policy_document" "frontend_s3" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.frontend.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.frontend.arn]
    }
  }
}
