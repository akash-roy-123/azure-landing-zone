variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "management_group_id" {
  description = "Management Group ID"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "organization_name" {
  description = "Organization identifier"
  type        = string
}

variable "enable_policy_assignments" {
  description = "Enable Azure Policy assignments"
  type        = bool
  default     = true
}

variable "enable_blueprints" {
  description = "Enable Azure Blueprints"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)
}

