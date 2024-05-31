# Copyright (c) 2023 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

output "events" {
  description = "The events."
  value       = var.enable_output ? oci_events_rule.these : null
}

output "topics" {
  description = "The topics."
  value       = var.enable_output ? oci_ons_notification_topic.these : null
}

output "subscriptions" {
  description = "The subscriptions."
  value       = var.enable_output ? oci_ons_subscription.these : null
}

output "streams" {
  description = "The streams."
  value       = var.enable_output ? oci_streaming_stream.these : null
}
