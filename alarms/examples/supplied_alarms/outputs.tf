# Copyright (c) 2023 Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

output "alarms" {
  value = module.supplied_alarms.alarms
}

output "topics" {
  value = module.supplied_alarms.topics
}
