terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "docker" {}

resource "docker_network" "demo" {
  name = "demo"
}

resource "docker_image" "debian" {
  name         = "debian:bookworm"
  keep_locally = true
}

resource "docker_container" "web" {
  name  = "web1"
  image = docker_image.debian.image_id
  networks_advanced {
    name = docker_network.demo.name
  }
  command = ["sleep", "infinity"]
  ports {
    internal = 80
    external = 8080
  }
  restart = "always"
  tty     = true
}