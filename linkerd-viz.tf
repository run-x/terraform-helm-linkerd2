# Use Terraform helm provider to install Linkerd Viz
resource "helm_release" "linkerd_viz" {
  count           = var.viz_enabled ? 1 : 0
  name            = "linkerd-viz"
  repository      = "https://helm.linkerd.io/stable"
  chart           = "linkerd-viz"
  atomic          = true
  cleanup_on_fail = true
  timeout         = 180
  version         = var.chart_version

  set {
    name  = "tap.replicas"
    value = var.high_availability ? 3 : 1
  }

  set {
    name  = "enablePodAntiAffinity"
    value = var.high_availability ? true : false
  }
  depends_on = [
    helm_release.linkerd
  ]
}
