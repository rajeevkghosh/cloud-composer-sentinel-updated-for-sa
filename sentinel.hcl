mock "tfplan/v2" {
  module {
    source = "mock-sa/mock-tfplan-v2.sentinel"
  }
}
module "tfplan-functions" {
    source = "./tfplan-functions.sentinel"
}
module "tfconfig-functions" {
    source = "./tfconfig-functions.sentinel"
}
mock "tfconfig/v2" {
  module {
    source = "mock-sa/mock-tfconfig-v2.sentinel"
  }
}

