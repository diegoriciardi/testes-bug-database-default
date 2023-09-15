output "s3-id" {
  value = data.aws_s3_bucket.selected.id
}

output "s3-arn" {
  value = data.aws_s3_bucket.selected.arn
}

output "s3-bucket_domain_name" {
  value = data.aws_s3_bucket.selected.bucket_domain_name
}

output "s3-bucket_regional_domain_name" {
  value = data.aws_s3_bucket.selected.bucket_regional_domain_name
}

output "s3-hosted_zone_id" {
  value = data.aws_s3_bucket.selected.hosted_zone_id
}

output "s3-region" {
  value = data.aws_s3_bucket.selected.region
}

output "s3-website_endpoint" {
  value = data.aws_s3_bucket.selected.website_endpoint
}

output "s3-website_domain" {
  value = data.aws_s3_bucket.selected.website_domain
}

#output "glue-id" {
#    value = data.aws_glue_catalog_table.dbdefault.id
#}