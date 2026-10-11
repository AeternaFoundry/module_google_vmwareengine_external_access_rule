variable "vmwareengine_external_access_rules" {
  description = <<EOT
Map of vmwareengine_external_access_rules, attributes below
Required:
    - action
    - destination_ports
    - ip_protocol
    - name
    - parent
    - priority
    - source_ports
    - destination_ip_ranges (block):
        - external_address (optional)
        - ip_address_range (optional)
    - source_ip_ranges (block):
        - ip_address (optional)
        - ip_address_range (optional)
Optional:
    - deletion_policy
    - description
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    action            = string
    destination_ports = list(string)
    ip_protocol       = string
    name              = string
    parent            = string
    priority          = number
    source_ports      = list(string)
    deletion_policy   = optional(string)
    description       = optional(string)
    destination_ip_ranges = list(object({
      external_address = optional(string)
      ip_address_range = optional(string)
    }))
    source_ip_ranges = list(object({
      ip_address       = optional(string)
      ip_address_range = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.vmwareengine_external_access_rules : (
        length(v.destination_ip_ranges) >= 1
      )
    ])
    error_message = "Each destination_ip_ranges list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.vmwareengine_external_access_rules : (
        length(v.source_ip_ranges) >= 1
      )
    ])
    error_message = "Each source_ip_ranges list must contain at least 1 items"
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

