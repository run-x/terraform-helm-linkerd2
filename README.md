# terraform-helm-linkerd2

[![](https://img.shields.io/github/license/run-x/terraform-helm-linkerd2)](https://github.com/run-x/terraform-helm-linkerd2)
![](https://img.shields.io/github/v/tag/run-x/terraform-helm-linkerd2)
![](https://img.shields.io/github/issues/run-x/terraform-helm-linkerd2)
[![](https://img.shields.io/github/languages/code-size/run-x/terraform-helm-linkerd2)](https://github.com/run-x/terraform-helm-linkerd2)
[![](https://img.shields.io/github/repo-size/run-x/terraform-helm-linkerd2)](https://github.com/run-x/terraform-helm-linkerd2)
![](https://img.shields.io/github/languages/top/run-x/terraform-helm-linkerd2?color=green&logo=terraform&logoColor=blue)
![](https://img.shields.io/github/commit-activity/m/run-x/terraform-helm-linkerd2)
![](https://img.shields.io/github/last-commit/run-x/terraform-helm-linkerd2)

Install Linkerd2 using Terraform
- Install Linkerd2 using Helm
- Configure Control Plane TLS Credentials ([this](https://linkerd.io/2.11/tasks/manually-rotating-control-plane-tls-credentials/#))
- Optional: Configure High Availability
- Optional: Install Linkerd2 Viz using Helm

## Usage

```terraform
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# install linkerd2 in high availability (HA) mode with Linkerd Viz 
module "linkerd2" {
  source  = "run-x/linkerd2/helm"
  version = "0.1.1"

  high_availability = true
  viz_enabled       = true
  values            = ["enablePodAntiAffinity: false"]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.linkerd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.linkerd_viz](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [tls_cert_request.issuer_req](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.issuer_cert](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.issuer_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.trustanchor_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.trustanchor_cert](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cert_validity_period_hours"></a> [cert\_validity\_period\_hours](#input\_cert\_validity\_period\_hours) | The number of hours after initial issuing that the certificate will become invalid. | `number` | `8760` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Specify the exact Linkerd chart version to install. If this is not specified, the latest version is installed. | `string` | `null` | no |
| <a name="input_high_availability"></a> [high\_availability](#input\_high\_availability) | Install Linkerd in high availability (HA) mode | `bool` | `false` | no |
| <a name="input_values"></a> [values](#input\_values) | List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options. Example: ["enablePodAntiAffinity: false"] | `list(string)` | `[]` | no |
| <a name="input_viz_enabled"></a> [viz\_enabled](#input\_viz\_enabled) | Install Linkerd-Viz: extension contains observability and visualization components | `bool` | `false` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

# Credits
- [Automating Linkerd installation on Kubernetes in Terraform](https://www.devopsfu.com/automating-linkerd-installation-in-terraform/)
- [Azure-Terraform/terraform-helm-linkerd](https://github.com/Azure-Terraform/terraform-helm-linkerd)
