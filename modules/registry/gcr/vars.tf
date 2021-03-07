variable "project" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  sensitive = true
}

variable "location" {
  description = "The location of the registry. One of [ asia, eu, us ] or not specified."
}

variable "credentials" {
  description = "Path to service account credentials file in JSON format"
}