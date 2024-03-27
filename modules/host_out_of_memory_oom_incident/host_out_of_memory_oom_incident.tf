resource "shoreline_notebook" "host_out_of_memory_oom_incident" {
  name       = "host_out_of_memory_oom_incident"
  data       = file("${path.module}/data/host_out_of_memory_oom_incident.json")
  depends_on = [shoreline_action.invoke_memory_threshold_check]
}

resource "shoreline_file" "memory_threshold_check" {
  name             = "memory_threshold_check"
  input_file       = "${path.module}/data/memory_threshold_check.sh"
  md5              = filemd5("${path.module}/data/memory_threshold_check.sh")
  description      = "The host may be running too many applications or processes simultaneously, causing excessive memory usage."
  destination_path = "/tmp/memory_threshold_check.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_memory_threshold_check" {
  name        = "invoke_memory_threshold_check"
  description = "The host may be running too many applications or processes simultaneously, causing excessive memory usage."
  command     = "`chmod +x /tmp/memory_threshold_check.sh && /tmp/memory_threshold_check.sh`"
  params      = []
  file_deps   = ["memory_threshold_check"]
  enabled     = true
  depends_on  = [shoreline_file.memory_threshold_check]
}

