## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | < 1.3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | n/a |
| <a name="provider_oci.home"></a> [oci.home](#provider\_oci.home) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_identity_policy.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy) | resource |
| [oci_logging_log.bucket](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/logging_log) | resource |
| [oci_logging_log_group.bucket](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/logging_log_group) | resource |
| [oci_objectstorage_bucket.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/objectstorage_bucket) | resource |
| [oci_ons_notification_topic.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/ons_notification_topic) | resource |
| [oci_ons_subscription.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/ons_subscription) | resource |
| [oci_sch_service_connector.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/sch_service_connector) | resource |
| [oci_streaming_stream.these](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/streaming_stream) | resource |
| [oci_objectstorage_namespace.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/objectstorage_namespace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_output"></a> [enable\_output](#input\_enable\_output) | Whether Terraform should enable module output. | `bool` | `true` | no |
| <a name="input_module_name"></a> [module\_name](#input\_module\_name) | The module name. | `string` | `"service-connectors"` | no |
| <a name="input_service_connectors_configuration"></a> [service\_connectors\_configuration](#input\_service\_connectors\_configuration) | Service Connectors configuration settings, defining all aspects to manage service connectors and related resources in OCI. Please see the comments within each attribute for details. | <pre>object({<br>    default_compartment_ocid = string, # the default compartment where all resources are defined. It's overriden by the compartment_ocid attribute within each object.<br>    default_defined_tags   = optional(map(string)), # the default defined tags. It's overriden by the defined_tags attribute within each object.<br>    default_freeform_tags  = optional(map(string)), # the default freeform tags. It's overriden by the frreform_tags attribute within each object.<br><br>    service_connectors = map(object({<br>      display_name = string # the service connector name.<br>      compartment_ocid = optional(string) # the compartment ocid where the service connector is created.<br>      description = optional(string) # the service connector description. Defaults to display_name if not defined.<br>      activate = optional(bool) # whether the service connector is active. Default is false.<br>      defined_tags = optional(map(string)) # the service connector defined_tags. Default to default_defined_tags if undefined.<br>      freeform_tags = optional(map(string)) # the service connector freeform_tags. Default to default_freeform_tags if undefined.<br><br>      source = object({<br>        kind = string # Supported sources: "logging" and "streaming".<br>        audit_logs = optional(list(object({ # the audit logs<br>          cmp_ocid = string # the compartment ocid. Use "ALL" to include all audit logs in the tenancy.<br>        })))<br>        non_audit_logs = optional(list(object({ # all logs that are not audit logs. Includes bucket logs, flow logs, custom logs, etc.<br>          cmp_ocid = string # the compartment ocid.<br>          log_group_ocid = optional(string) # the log group ocid.<br>          log_ocid = optional(string) # the log ocid.<br>        })))<br>        stream_ocid = optional(string) # The existing stream ocid (only applicable if kind = "streaming").<br>      })<br><br>      log_rule_filter = optional(string) # A condition for filtering log data (only applicable if source kind = "logging").<br>      <br>      target = object({ # the target<br>        kind = string, # supported targets: "objectstorage", "streaming", "functions", "logginganalytics", "notifications".<br>        bucket_name = optional(string), # the existing bucket name (only applicable if kind is "objectstorage").<br>        bucket_key = optional(string), # the corresponding bucket key as defined in the buckets map object (only applicable if kind is "objectstorage"). <br>        bucket_batch_rollover_size_in_mbs = optional(number), # the bucket batch rollover size in megabytes (only applicable if kind is "objectstorage"). <br>        bucket_batch_rollover_time_in_ms = optional(number), # the bucket batch rollover time in milliseconds (only applicable if kind is "objectstorage"). <br>        bucket_object_name_prefix = optional(string), # the prefix of objects eventually created in the bucket (only applicable if kind is "objectstorage").<br>        stream_ocid = optional(string) # the existing stream ocid (only applicable if kind is "streaming").<br>        stream_key = optional(string) # the corresponding stream key as defined in the streams map object (only applicable if kind is "streaming"). <br>        topic_ocid = optional(string) # the existing topic ocid (only applicable if kind is "notifications").<br>        topic_key = optional(string) # the corresponding topic key as defined in the topics map object (only applicable if kind is "notifications").<br>        function_ocid = optional(string) # the existing function ocid (only applicable if kind is "functions").<br>        log_group_ocid = optional(string) # the existing log group ocid (only applicable if kind is "logginganalytics").<br>        compartment_ocid = optional(string), # the target resource compartment ocid. Required when using an existing target resource (bucket_name, stream_ocid, function_ocid, or log_group_ocid).<br>        policy_name = optional(string) # the policy name allowing service connector to push data to target.<br>        policy_description = optional(string) # the policy description.<br>      })<br>    }))  <br><br>    buckets = optional(map(object({ # the buckets to manage.<br>      name = string, # the bucket name<br>      compartment_ocid = optional(string), # the compartment where the stream is created. default_compartment_ocid is used if this is not defined.<br>      cis_level = optional(string), # the cis_level. Default is "1". Drives bucket versioning and encryption. cis_level = "1": no versioning, encryption with Oracle managed key. cis_level = "2": versioning enabled, encryption with customer managed key.<br>      kms_key_ocid = optional(string), # the customer managed key ocid. Required if cis_level = "2".<br>      defined_tags = optional(map(string)), # bucket defined_tags. default_defined_tags is used if this is not defined.<br>      freeform_tags = optional(map(string)) # bucket freeform_tags. default_freeform_tags is used if this is not defined.<br>    })))<br><br>    streams = optional(map(object({ # the streams to manage.<br>      name = string # the stream name<br>      compartment_ocid = optional(string) # the compartment where the stream is created. default_compartment_ocid is used if this is not defined.<br>      num_partitions = optional(number) # the number of stream partitions. Default is 1.  <br>      log_retention_in_hours = optional(number) # for how long to keep messages in the stream. Default is 24 hours.<br>      defined_tags = optional(map(string)) # stream defined_tags. default_defined_tags is used if this is not defined.<br>      freeform_tags = optional(map(string)) # stream freeform_tags. default_freeform_tags is used if this is not defined.<br>    })))<br><br>    topics = optional(map(object({ # the topics to manage in this configuration.<br>      name = string # topic name<br>      compartment_ocid = optional(string) # the compartment where the topic is created. default_compartment_ocid is used if undefined.<br>      description = optional(string) # topic description. Defaults to topic name if undefined.<br>      subscriptions = optional(list(object({<br>        compartment_ocid = optional(string) # the compartment where the subscription is created. The topic compartment_ocid is used if undefined.<br>        protocol = string # valid values (case insensitive): EMAIL, CUSTOM_HTTPS, PAGERDUTY, SLACK, ORACLE_FUNCTIONS, SMS<br>        values = list(string) # list of endpoint values, specific to each protocol.<br>        defined_tags = optional(map(string)) # subscription defined_tags. The topic defined_tags is used if undefined.<br>        freeform_tags = optional(map(string)) # subscription freeform_tags. The topic freeform_tags is used if undefined.<br>      })))<br>      defined_tags = optional(map(string)) # topic defined_tags. default_defined_tags is used if undefined.<br>      freeform_tags = optional(map(string)) # topic freeform_tags. default_freeform_tags is used if undefined.<br>    })))<br><br>  })</pre> | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | The tenancy ocid | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_connector_buckets"></a> [service\_connector\_buckets](#output\_service\_connector\_buckets) | The service connector buckets. |
| <a name="output_service_connector_policies"></a> [service\_connector\_policies](#output\_service\_connector\_policies) | The service connector policies. |
| <a name="output_service_connector_streams"></a> [service\_connector\_streams](#output\_service\_connector\_streams) | The service connector streams. |
| <a name="output_service_connector_topics"></a> [service\_connector\_topics](#output\_service\_connector\_topics) | The service connector topics. |
| <a name="output_service_connectors"></a> [service\_connectors](#output\_service\_connectors) | The service connectors. |