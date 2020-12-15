# This file is automatically compiled by Webpack, along with any other files
# present in this directory. You're encouraged to place your actual application logic in
# a relevant structure within app/javascript and only use these pack files to reference
# that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("bootstrap")
require("channels")
require("trix")
require("@rails/actiontext")
require("@fortawesome/fontawesome-free")

import "@fortawesome/fontawesome-free/css/all.css"
# Uncomment to copy all static images under ../images to the output folder and reference
# them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
# or the `imagePath` JavaScript helper below.
#
images = require.context('../images', true)
# imagePath = (name) => images(name, true)

import "../stylesheets/application.scss"

import "./admins"
import "./home"
import "./admins/users"
import "./posts"
import "./users"
import "./profile/posts"
import "./profile/users"


$(document).on 'turbolinks:load', ->
  $(".toggle_button").click ->
    target_id = $(this).data("toggle-target")
    if target_id
      $(target_id).slideToggle()
      $(this).toggle()
    else
      console.error("no toggle target")

  $('[data-toggle="tooltip"]').tooltip()

