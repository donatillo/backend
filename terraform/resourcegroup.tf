resource "aws_resourcegroups_group" "resg-backend-devl" {
    name = "backend-devl"
    description = "Resources built for the backend - devl."
    
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
      "Values": ["devl"]
    }
  ]
}
JSON
  }
}

resource "aws_resourcegroups_group" "resg-backend-master" {
    name = "backend-master"
    description = "Resources built for the backend - master."
    
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
      "Values": ["master"]
    }
  ]
}
JSON
  }
}

# vim:ts=4:sw=4:sts=4:expandtab:syntax=conf
