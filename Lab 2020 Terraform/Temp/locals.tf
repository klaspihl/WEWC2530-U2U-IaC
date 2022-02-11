locals {
  Tag =   merge(
      var.default_tags,
      map(
        "StartDate", formatdate("YYYY-MM-DD hh:mm", timestamp())
        )
      )
    lifecycle {
      ignore_changes = [
        tags["StartDate"]
      ]
    }
}

