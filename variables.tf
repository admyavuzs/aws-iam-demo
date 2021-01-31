variable "user_list_dev" {
  description = "List of IAM users to add to the group."
  type        = list(string)
  default     = ["Eugune", "Milo", "Abigail", "Aidan"]
}

variable "user_list_ops" {
  description = "List of IAM users to add to the group."
  type        = list(string)
  default     = ["Santiago", "Felix", "Morgan"]
}

variable "group_name_dev" {
  description = "The name of the group to be created."
  type        = string
  default     = "Developers"
}

variable "group_name_ops" {
  description = "The name of the group to be created."
  type        = string
  default     = "Ops"
}

variable "allowed_roles" {
  description = "The roles that this group is allowed to assume."
  type        = list(string)
  default     = ["ReadOnly"]
}
