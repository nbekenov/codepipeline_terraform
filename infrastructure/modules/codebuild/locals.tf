locals {
  source_location = var.source_type == "CODECOMMIT" ? "https://git-codecommit.${data.aws_region.current.name}.amazonaws.com/v1/repos/${var.source_location}" : var.source_location
}
