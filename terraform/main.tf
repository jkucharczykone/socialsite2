terraform {
  required_providers {
    heroku = {
      source = "heroku/heroku"
      version = "3.0.1"
    }
  }
}

variable "app_name" {
  description = "Socialsite"
}

resource "heroku_app" "example" {
  name = "${var.app_name}"
  region = "eu"
}

# Build code & release to the app
resource "heroku_build" "example" {
  app = "${heroku_app.example.name}"
  buildpacks = ["https://github.com/heroku/heroku-buildpack-python.git","https://github.com/carloluis/heroku-buildpack-vim.git","https://github.com/heroku/heroku-buildpack-ci-postgresql.git"]

  source = {
    url = "https://github.com/jkucharczykone/jkucharczyk/archive/master.tar.gz"
    version = "0.0.1"
  }
}

# Launch the app's web process by scaling-up
# resource "heroku_formation" "example" {
#   app        = "${heroku_app.example.name}"
#   type       = "web"
#   quantity   = 1
#   size       = "Standard-1x"
#   depends_on = ["heroku_build.example"]
# }

output "example_app_url" {
  value = "https://${heroku_app.example.name}.herokuapp.com"
}