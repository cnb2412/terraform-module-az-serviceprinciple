variable "display_name" {
  type = string
  description = "Displayname for service principle app"
}

variable "owner_upns" {
  type = list(string)
  description = "List of user principal name, i.e. primmary email."
  default = []
}
