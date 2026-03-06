variable "region" {
  description = "Target OCI region (e.g., us-ashburn-1)"
  type        = string
}

variable "compartment_ocid" {
  description = "OCID of the compartment where resources will be created"
  type        = string
}

variable "availability_domain" {
  description = "Target Availability Domain (e.g., Uocm:US-ASHBURN-AD-1)"
  type        = string
}

variable "subnet_id" {
  description = "OCID of the subnet where the instance will be attached"
  type        = string
}

variable "image_id" {
  description = "OCID of the Image intended to be used for the instance (e.g. Ubuntu 22.04 Aarch64)"
  type        = string
}

variable "ssh_public_key" {
  description = "Public SSH Key to access the machine once provisioned"
  type        = string
}

variable "ocpus" {
  description = "Number of OCPUs to hunt for"
  type        = number
  default     = 4
}

variable "memory_in_gbs" {
  description = "Amount of Memory in GBs to hunt for"
  type        = number
  default     = 24
}