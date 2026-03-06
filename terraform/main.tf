data "oci_core_instances" "existing_instances" {
  compartment_id = var.compartment_ocid
  display_name   = "ampere-free-hunter"
}

resource "oci_core_instance" "ampere" {
  # If an instance named ampere-free-hunter exists, count will be 0, skipping creation!
  count = length(data.oci_core_instances.existing_instances.instances) == 0 ? 1 : 0

  availability_domain = var.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "ampere-free-hunter"

  shape = "VM.Standard.A1.Flex"

  shape_config {
    ocpus         = var.ocpus
    memory_in_gbs = var.memory_in_gbs
  }

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = var.image_id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }
}