terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = "todo-api-ratekka44"
  region  = "europe-west3"
}

resource "google_cloud_run_v2_service" "todo_api" {
  name                = "todo-api-tf"
  location            = "europe-west3"
  deletion_protection = false
  

  template {
    containers {
      image = "europe-west3-docker.pkg.dev/todo-api-ratekka44/todo-repo/todo-app:v1"
      ports {
        container_port = 8000
      }
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "public" {
  name     = google_cloud_run_v2_service.todo_api.name
  location = google_cloud_run_v2_service.todo_api.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
output "url" {
  value = google_cloud_run_v2_service.todo_api.uri
}
