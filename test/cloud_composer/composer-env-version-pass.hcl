module "tfplan-functions" {
  source = "../../tfplan-functions.sentinel"
}

mock "tfplan/v2" {
  module {
    source = "mock-tfplan-composer-env-version-pass.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}