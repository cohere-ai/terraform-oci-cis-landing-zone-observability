locals {

  policy_statements = { for key, sc in var.service_connectors_configuration.service_connectors : key => {

    grants = lower(sc.target.kind) == local.TARGET_OBJECT_STORAGE ? [
      <<EOF
          Allow any-user to manage objects in compartment id ${contains(keys(oci_objectstorage_bucket.these), sc.target.bucket_name) ? oci_objectstorage_bucket.these[sc.target.bucket_name].compartment_id : (sc.target.compartment_id != null ? (length(regexall("^ocid1.*$", sc.target.compartment_id) > 0 ? sc.target.compartment_id : var.compartments_dependency[sc.target.compartment_id].id)) : (sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)))} where all {
          request.principal.type='serviceconnector',
          target.bucket.name= '${contains(keys(oci_objectstorage_bucket.these), sc.target.bucket_name) ? oci_objectstorage_bucket.these[sc.target.bucket_name].name : sc.target.bucket_name}',
          request.principal.compartment.id='${sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)}' }
      EOF
      ] : lower(sc.target.kind) == local.TARGET_STREAMING ? [
      <<EOF
          Allow any-user to use stream-push in compartment id ${contains(keys(oci_streaming_stream.these), sc.target.stream_id) ? oci_streaming_stream.these[sc.target.stream_id].compartment_id : (contains(keys(coalesce(var.streams_dependency, {})), sc.target.stream_id) ? var.streams_dependency[sc.target.stream_id].compartment_id : (sc.target.compartment_id != null ? (length(regexall("^ocid1.*$", sc.target.compartment_id) > 0 ? sc.target.compartment_id : var.compartments_dependency[sc.target.compartment_id].id)) : (sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id))))} where all {
          request.principal.type='serviceconnector',
          target.stream.id='${length(regexall("^ocid1.*$", sc.target.stream_id)) > 0 ? sc.target.stream_id : (contains(keys(oci_streaming_stream.these), sc.target.stream_id) ? oci_streaming_stream.these[sc.target.stream_id].id : var.streams_dependency[sc.target.stream_id].id)}',
          request.principal.compartment.id='${sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)}' }
      EOF
      ] : lower(sc.target.kind) == local.TARGET_FUNCTIONS ? [
      <<EOF
          Allow any-user to use fn-function in compartment id ${contains(keys(coalesce(var.functions_dependency, {})), sc.target.function_id) ? var.functions_dependency[sc.target.function_id].compartment_id : (sc.target.compartment_id != null ? (length(regexall("^ocid1.*$", sc.target.compartment_id) > 0 ? sc.target.compartment_id : var.compartments_dependency[sc.target.compartment_id].id)) : (sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)))} where all {
          request.principal.type='serviceconnector',
          request.principal.compartment.id='${sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)}' }
      EOF
      ,
      <<EOF2
          Allow any-user to use fn-function in compartment id ${contains(keys(coalesce(var.functions_dependency, {})), sc.target.function_id) ? var.functions_dependency[sc.target.function_id].compartment_id : (sc.target.compartment_id != null ? (length(regexall("^ocid1.*$", sc.target.compartment_id) > 0 ? sc.target.compartment_id : var.compartments_dependency[sc.target.compartment_id].id)) : (sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)))} where all {
          request.principal.type='serviceconnector',
          request.principal.compartment.id='${sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)}' }
      EOF2
      ] : lower(sc.target.kind) == local.TARGET_LOGGING_ANALYTICS ? [
      <<EOF
          Allow any-user to {LOG_ANALYTICS_LOG_GROUP_UPLOAD_LOGS} in compartment id ${contains(keys(coalesce(var.logs_dependency, {})), sc.target.log_group_id) ? var.logs_dependency[sc.target.log_group_id].compartment_id : (sc.target.compartment_id != null ? (length(regexall("^ocid1.*$", sc.target.compartment_id) > 0 ? sc.target.compartment_id : var.compartments_dependency[sc.target.compartment_id].id)) : (sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)))} where all {
          request.principal.type='serviceconnector',
          target.loganalytics-log-group.id='${length(regexall("^ocid1.*$", sc.target.log_group_id)) > 0 ? sc.target.log_group_id : var.logs_dependency[sc.target.log_group_id].id}',
          request.principal.compartment.id='${sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)}' }
      EOF
      ] : lower(sc.target.kind) == local.TARGET_NOTIFICATIONS ? [
      <<EOF
          Allow any-user to use ons-topics in compartment id ${contains(keys(oci_ons_notification_topic.these), sc.target.topic_id) ? oci_ons_notification_topic.these[sc.target.topic_id].compartment_id : (contains(keys(coalesce(var.topics_dependency, {})), sc.target.topic_id) ? var.topics_dependency[sc.target.topic_id].compartment_id : (sc.target.compartment_id != null ? (length(regexall("^ocid1.*$", sc.target.compartment_id) > 0 ? sc.target.compartment_id : var.compartments_dependency[sc.target.compartment_id].id)) : (sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id))))} where all {
          request.principal.type= 'serviceconnector',
          request.principal.compartment.id='${sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)}' }
      EOF
    ] : []

    /* grants = lower(sc.target.kind) == local.TARGET_OBJECT_STORAGE ? [
      <<EOF
          Allow any-user to manage objects in compartment id ${sc.target.compartment_id != null ? (length(regexall("^ocid1.*$", sc.target.compartment_id)) > 0 ? sc.target.compartment_id : (contains(keys(oci_objectstorage_bucket.these),sc.target_bucket_name) ? oci_objectstorage_bucket.these[sc.target.bucket_name].compartment_id : var.compartments_dependency[sc.target.compartment_id].id)) : sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)} where all {
          request.principal.type='serviceconnector',
          target.bucket.name= '${sc.target.bucket_name != null ? (contains(keys(oci_objectstorage_bucket.these), sc.target.bucket_name) ? oci_objectstorage_bucket.these[sc.target.bucket_name].name : sc.target.bucket_name) : "BUCKET_NAME_REQUIRED"}',
          request.principal.compartment.id='${sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)}' }
      EOF
      ] : lower(sc.target.kind) == local.TARGET_STREAMING ? [
      <<EOF
          Allow any-user to use stream-push in compartment id ${sc.target.compartment_id != null ? (length(regexall("^ocid1.*$", sc.target.compartment_id)) > 0 ? sc.target.compartment_id : (contains(keys(oci_streaming_stream.these),sc.target.stream_id) ? oci_streaming_stream.these[sc.target.stream_id].compartment_id : var.compartments_dependency[sc.target.compartment_id].id)) : sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)} where all {
          request.principal.type='serviceconnector',
          target.stream.id='${sc.target.stream_id != null ? (length(regexall("^ocid1.*$", sc.target.stream_id)) > 0 ? sc.target.stream_id : (contains(keys(oci_streaming_stream.these),sc.target.stream_id) ? oci_streaming_stream.these[sc.target.stream_id].id : var.streams_dependency[sc.target.stream_id].id)) : "STREAM_ID_REQUIRED"}',
          request.principal.compartment.id='${sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)}' }
      EOF
      ] : lower(sc.target.kind) == local.TARGET_FUNCTIONS ? [
      <<EOF
          Allow any-user to use fn-function in compartment id ${sc.target.compartment_id != null ? (length(regexall("^ocid1.*$", sc.target.compartment_id)) > 0 ? sc.target.compartment_id : var.compartments_dependency[sc.target.compartment_id].id) : sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)} where all {
          request.principal.type='serviceconnector',
          request.principal.compartment.id='${sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)}' }
      EOF
      ,
      <<EOF2
          Allow any-user to use fn-invocation in compartment id ${sc.target.compartment_id != null ? (length(regexall("^ocid1.*$", sc.target.compartment_id)) > 0 ? sc.target.compartment_id : var.compartments_dependency[sc.target.compartment_id].id) : sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)} where all {
          request.principal.type='serviceconnector',
          request.principal.compartment.id='${sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)}' }
      EOF2
      ] : lower(sc.target.kind) == local.TARGET_LOGGING_ANALYTICS ? [
      <<EOF
          Allow any-user to {LOG_ANALYTICS_LOG_GROUP_UPLOAD_LOGS} in compartment id ${sc.target.compartment_id != null ? (length(regexall("^ocid1.*$", sc.target.compartment_id)) > 0 ? sc.target.compartment_id : var.compartments_dependency[sc.target.compartment_id].id) : sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)} where all {
          request.principal.type='serviceconnector',
          target.loganalytics-log-group.id='${sc.target.log_group_ocid}',
          request.principal.compartment.id='${sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)}' }
      EOF
      ] : lower(sc.target.kind) == local.TARGET_NOTIFICATIONS ? [
      <<EOF
          Allow any-user to use ons-topics in compartment id ${sc.target.compartment_id != null ? (length(regexall("^ocid1.*$", sc.target.compartment_id)) > 0 ? sc.target.compartment_id : (contains(keys(oci_ons_notification_topic.these),sc.target.topic_id) ? oci_ons_notification_topic.these[sc.target.topic_id].compartment_id : var.compartments_dependency[sc.target.compartment_id].id)) : sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)} where all {
          request.principal.type= 'serviceconnector',
          request.principal.compartment.id='${sc.compartment_id != null ? (length(regexall("^ocid1.*$", sc.compartment_id)) > 0 ? sc.compartment_id : var.compartments_dependency[sc.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)}' }
      EOF
      ] : [] */
  } }
}

#--------------------------------------------------
#--- SCH policy resource:
#--- 1. oci_identity_policy
#--------------------------------------------------
resource "oci_identity_policy" "these" {
  depends_on = [oci_sch_service_connector.these]
  for_each   = var.service_connectors_configuration.service_connectors
  lifecycle {
    precondition {
      condition     = contains(local.targets, lower(each.value.target.kind))
      error_message = "VALIDATION FAILURE : \"${each.value.target.kind}\" value is invalid for \"target kind\" attribute in \"${each.key}\" service connector. Valid values are ${join(", ", local.targets)} (case insensitive)."
    }
  }
  provider = oci.home
  name     = each.value.policy != null ? coalesce(each.value.policy.name, "service-connector-${lower(each.value.target.kind)}-policy") : "service-connector-${lower(each.value.target.kind)}-policy"
  #name           = each.value.policy != null ? (each.value.policy.name != null ? each.value.policy.name : "service-connector-${lower(each.value.target.kind)}-policy") : "service-connector-${lower(each.value.target.kind)}-policy"
  #name           = each.value.target.policy_name != null ? each.value.target.policy_name : "service-connector-${lower(each.value.target.kind)}-policy"
  description = each.value.policy != null ? coalesce(each.value.policy.description, "Policy allowing Service Connector Hub to push data to ${lower(each.value.target.kind)}.") : "Policy allowing Service Connector Hub to push data to ${lower(each.value.target.kind)}."
  #description    = each.value.target.policy_description != null ? each.value.target.policy_description : "Policy allowing Service Connector Hub to push data to ${lower(each.value.target.kind)}."
  compartment_id = each.value.policy != null ? (each.value.policy.compartment_id != null ? (length(regexall("^ocid1.*$", each.value.policy.compartment_id)) > 0 ? each.value.policy.compartment_id : var.compartments_dependency[each.value.policy.compartment_id].id) : (each.value.target.compartment_id != null ? (length(regexall("^ocid1.*$", each.value.target.compartment_id)) > 0 ? each.value.target.compartment_id : var.compartments_dependency[each.value.target.compartment_id].id) : each.value.compartment_id != null ? (length(regexall("^ocid1.*$", each.value.compartment_id)) > 0 ? each.value.compartment_id : var.compartments_dependency[each.value.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id))) : (each.value.target.compartment_id != null ? (length(regexall("^ocid1.*$", each.value.target.compartment_id)) > 0 ? each.value.target.compartment_id : var.compartments_dependency[each.value.target.compartment_id].id) : each.value.compartment_id != null ? (length(regexall("^ocid1.*$", each.value.compartment_id)) > 0 ? each.value.compartment_id : var.compartments_dependency[each.value.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id))
  #compartment_id = each.value.target.compartment_id != null ? (length(regexall("^ocid1.*$", each.value.target.compartment_id)) > 0 ? each.value.target.compartment_id : var.compartments_dependency[each.value.target.compartment_id].id) : each.value.compartment_id != null ? (length(regexall("^ocid1.*$", each.value.compartment_id)) > 0 ? each.value.compartment_id : var.compartments_dependency[each.value.compartment_id].id) : (length(regexall("^ocid1.*$", var.service_connectors_configuration.default_compartment_id)) > 0 ? var.service_connectors_configuration.default_compartment_id : var.compartments_dependency[var.service_connectors_configuration.default_compartment_id].id)
  statements    = local.policy_statements[each.key].grants
  defined_tags  = each.value.defined_tags != null ? each.value.defined_tags : var.service_connectors_configuration.default_defined_tags
  freeform_tags = merge(local.cislz_module_tag, each.value.freeform_tags != null ? each.value.freeform_tags : var.service_connectors_configuration.default_freeform_tags)
}
