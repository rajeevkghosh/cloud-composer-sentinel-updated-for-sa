module "tfplan-functions" {
  source = "../../tfplan-functions.sentinel"
}

mock "tfplan/v2" {
  module {
    source = "mock-tfplan-composer-private-null.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}