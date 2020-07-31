// Calculate timeouts
locals {
  default_timeout = 60
  default_count   = 8
  # TODO: #3 Actually, build timeout may be less than a summ of step timeouts dure to parallelizm.
  # Nevertheless, GCP produces an error. So, let's count and add 15% to the sum.
  build_timeout = ceil((local.default_timeout * local.default_count + length(var.terratest_regions) * var.terratest_timeout) * 1.15)
}