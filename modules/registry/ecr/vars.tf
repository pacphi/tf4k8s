variable "registry_name" {
  description = "Specifies the name of the Container Registry.  This name will be updated to append a unique suffix so as not to collide with a pre-existing registry."
}

variable "region" {
  default = "us-west-2"
  description = "A valid AWS region (e.g., us-east-1).  See https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-regions."
}