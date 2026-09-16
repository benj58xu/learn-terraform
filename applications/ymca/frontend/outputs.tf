output "bucket_name" {
  value = aws_s3_bucket.frontend.bucket
}

output "website_url" {
  value = "http://${aws_s3_bucket_website_configuration.frontend.website_endpoint}"
}

output "route53_record" {
  value = var.route53_zone_id != "" ? aws_route53_record.frontend[0].fqdn : "Route53 disabled"
}