resource "google_vmwareengine_external_access_rule" "vmwareengine_external_access_rules" {
  for_each = var.vmwareengine_external_access_rules

  action            = each.value.action
  destination_ports = each.value.destination_ports
  ip_protocol       = each.value.ip_protocol
  name              = each.value.name
  parent            = each.value.parent
  priority          = each.value.priority
  source_ports      = each.value.source_ports
  deletion_policy   = each.value.deletion_policy
  description       = each.value.description

  dynamic "destination_ip_ranges" {
    for_each = each.value.destination_ip_ranges
    content {
      external_address = destination_ip_ranges.value.external_address
      ip_address_range = destination_ip_ranges.value.ip_address_range
    }
  }

  dynamic "source_ip_ranges" {
    for_each = each.value.source_ip_ranges
    content {
      ip_address       = source_ip_ranges.value.ip_address
      ip_address_range = source_ip_ranges.value.ip_address_range
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

