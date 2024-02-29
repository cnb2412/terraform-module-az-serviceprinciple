variable "display_name" {
  type = string
  description = "Displayname for service principle app"
}

variable "owner_upns" {
  type = list(string)
  description = "List of user principal name, i.e. primmary email."
  default = []
}

variable "description" {
    type = string
    default = ""
    description = "Description of the Serivce Principle. Default empty string"
}

variable "account_enabled" {
    type = bool
    default = true
    description = "Whether or not the service principal account is enabled. Defaults to true"
}
