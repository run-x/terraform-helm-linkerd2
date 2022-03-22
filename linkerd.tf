# Use Terraform helm provider to install Linkerd 
resource "helm_release" "linkerd" {
  chart      = "linkerd2"
  name       = "linkerd"
  repository = "https://helm.linkerd.io/stable"
  version    = var.chart_version

  set_sensitive {
    name  = "identityTrustAnchorsPEM"
    value = tls_self_signed_cert.trustanchor_cert.cert_pem
  }

  set_sensitive {
    name  = "identity.issuer.crtExpiry"
    value = tls_locally_signed_cert.issuer_cert.validity_end_time
  }

  set_sensitive {
    name  = "identity.issuer.tls.crtPEM"
    value = tls_locally_signed_cert.issuer_cert.cert_pem
  }

  set_sensitive {
    name  = "identity.issuer.tls.keyPEM"
    value = tls_private_key.issuer_key.private_key_pem
  }

  values = concat(
    [var.high_availability ? file("${path.module}/values-ha.yaml") : ""],
    length(var.values) == 0 ? [] : var.values
  )
}
