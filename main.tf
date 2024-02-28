data "azuread_user" "owners" {
  for_each = toset(var.owner_upns)
  user_principal_name = each.value
}

resource "azuread_application" "myapp" {
  display_name = var.display_name
  owners       = try(data.azuread_user.owners[*].object_id, [])
}

# resource "azuread_service_principal" "az_sp" {
#   application_id               = azuread_application.az_devoops_cnb2412_app.application_id
#   app_role_assignment_required = false
#   owners                       = [data.azuread_client_config.current.object_id]
#   description = "Used by az DevOps Projekt for AZ base iac config. Created by terraform-az-bootstarp"
# }

# resource "azuread_service_principal_password" "az_sp_pwd" {
#     service_principal_id = azuread_service_principal.az_sp.object_id
#     display_name = "Az-DevOps_secret"
#     # end_date = "2023-10-01T01:02:03Z"
# }
