locals {
  modules_folder_files = [
    "core.tf",
    "eventgrid.tf",
    "function-linux.tf",
    "function-windows.tf",
    "health-probes.tf",
    "identity.tf",
    "keyvault.tf",
    "main.tf",
    "outputs.tf",
    "storage-data.tf",
    "storage-ops.tf",
    "variables.tf",
    "versions.tf"
  ]
}

resource "github_repository_file" "modules_folder" {

  for_each = toset(local.modules_folder_files)

  repository          = var.repository
  branch              = var.branch
  file                = "${var.path}/modules/regional-stamp/${each.key}"
  content             = file("${path.module}/files/modules/regional-stamp/${each.key}.t4")
  commit_message      = "Managed by Terraform"
  commit_author       = var.commit_user.name
  commit_email        = var.commit_user.email
  overwrite_on_create = true
}
