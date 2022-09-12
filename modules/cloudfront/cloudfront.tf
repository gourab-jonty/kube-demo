resource "aws_cloudfront_distribution" "cloudfront" {
  origin {
    domain_name = var.domain_name
    origin_id   = local.origin_id
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  is_ipv6_enabled = true
  enabled         = true
  comment         = var.comment
  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = ["RU"]
    }
  }

  #aliases = "${var.aliases}"
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.origin_id

    forwarded_values {
      query_string = true

      cookies {
        forward           = "all"
        whitelisted_names = []
      }
      headers = ["Access-Control-Request-Headers", "Access-Control-Request-Method", "CloudFront-Forwarded-Proto", "Host", "Origin"]
    }

    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }
  viewer_certificate {
    cloudfront_default_certificate = true
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1"
  }
}
