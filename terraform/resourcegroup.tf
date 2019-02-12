resource "aws_resourcegroups_group" "resg-backend" {
    name = "backend-${var.env}"
    description = "Resources built for the backend - ${var.env}."
    
    resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": ["AWS::AllSupported"],
  "TagFilters": [
    {
      "Key": "Creator",
      "Values": ["backend"]
    },
    {
      "Key": "Environment",
      "Values": ["${var.env}"]
    }
  ]
}
JSON
  }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
