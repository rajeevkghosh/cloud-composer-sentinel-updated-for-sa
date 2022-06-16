
provider "google" {

  access_token = var.access_token
  project     = "modular-scout-345114"
  #credentials = file("../composer-sa.json")

}

provider "google-beta" {

  access_token = var.access_token
  project     = "modular-scout-345114"
}
resource "google_composer_environment" "test" {
  name   = "wf-us-dev-cmp-app01-res123"
  region = "us-central1"
  provider = google-beta
  

  config {
    software_config {
      image_version = "composer-2-airflow-2"
      airflow_config_overrides = {
        webserver-rbac_user_registration_role = "Viewer"
      }
    }

    node_config {
      network    = "default"
      subnetwork = "default"
      //service_account = google_service_account.test.name
    }

    encryption_config {
      kms_key_name = data.google_kms_crypto_key.cryptokey-1.id
    }

    private_environment_config {

      enable_private_endpoint = true

    }

    master_authorized_networks_config {

      enabled = true
      cidr_blocks {
        cidr_block = "10.2.0.0/16"
      }
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

resource "google_service_account" "test" {
  account_id   = "composer-env-account-17"
  display_name = "Test Service Account for Composer Environment"
}

resource "google_project_iam_member" "composer-worker" {
  project = "modular-scout-345114"
  role    = "roles/composer.worker"
  member  = "serviceAccount:${google_service_account.test.email}"
}