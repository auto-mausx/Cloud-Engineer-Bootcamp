provider "google" {
    project = "zarate-linux-admin-fund"
    region = "us-central1"
    zone = "us-central1-a"
}

resource "google_compute_instance" "vm_instance" {
    name = "micro-ubuntu18"
    machine_type = "f1-micro"

    tags = ["http-server", "https-server"]

    labels = {
        purpose = "learning"
    }

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-1804-lts"
        }
    }

    network_interface {
        network = "default"

        access_config {

        }
    }
}
