# Configure the Alicloud Provider
provider "alicloud" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# data "alicloud_instance_types" "types_ds" {
#   cpu_core_count = 1
#   memory_size    = 2
#   instance_type_family = "ecs.n4"
#   is_outdated = "true"
# }
#ecs.n4.small

data "alicloud_images" "default" {
  name_regex  = "^ali"
  most_recent = true
  owners      = "system"
}

# Create a web server
resource "alicloud_instance" "csgoserver" {
  image_id              = "${data.alicloud_images.default.images.0.id}"
  internet_charge_type  = "PayByBandwidth"

  instance_type        = "ecs.n4.small"
  system_disk_category = "cloud_efficiency"
  security_groups      = ["${alicloud_security_group.default.id}"]
  instance_name        = "monkey"
  vswitch_id           = "vsw-gw8gaarf3rhvsid4jryvg"
  instance_charge_type = "PostPaid"
  spot_strategy        = "NoSpot"
  is_outdated          = "true"
  io_optimized         = "optimized"
}

# Create security group
resource "alicloud_security_group" "default" {
  name        = "hahaha"
  description = "default"
  vpc_id      = "vpc-gw85ylk9fo8rnf8c0cpp1"
}