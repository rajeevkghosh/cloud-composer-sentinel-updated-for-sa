module "tfplan-functions" {
  source = "../../tfplan-functions.sentinel"
}

mock "tfplan/v2" {
  module {
    source = "mock-tfplan-composer-env-version-fail.sentinel"
  }
}

test {
  rules = {
    main = false
  }
}