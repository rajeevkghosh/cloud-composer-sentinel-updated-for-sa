
provider "google" {

  access_token = var.access_token
  project = "sublime-lyceum-343813"
  #credentials = file("../composer-sa.json")

}
resource "google_composer_environment" "test" {
  name   = "wf-us-dev-cmp-app01-res123"
  region = "us-central1"

  config {
    software_config {
      image_version = "composer-2-airflow-2"
      airflow_config_overrides = {
        webserver-rbac_user_registration_role = "Viewer"
      }
    }

    encryption_config {
      kms_key_name = data.google_kms_crypto_key.cryptokey-1.id
    }

    private_environment_config {

      enable_private_endpoint = true

    }
  }



}

data "google_kms_key_ring" "keyring-1" {
  name     = "keyring-1"
  location = "us-central1"
}

data "google_kms_crypto_key" "cryptokey-1" {
  name     = "cryptokey-1"
  key_ring = data.google_kms_key_ring.keyring-1.id
}