// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

document.addEventListener("DOMContentLoaded", function() {
    var burgers = document.querySelectorAll(".burger");

    if (burgers.length > 0) {
        burgers.forEach(function(el) {
            el.addEventListener("click", function(event) {
                event.preventDefault();

                var target = el.dataset.target;
                el.classList.toggle("is-active");
                document.getElementById(target).classList.toggle("is-active");
            });
        });
    }

    var deletes = document.querySelectorAll(".delete-notification");

    if (deletes.length > 0) {
        deletes.forEach(function(el) {
            el.addEventListener("click", function(event) {
                event.preventDefault();

                var parent = el.parentElement;
                parent.parentElement.removeChild(parent);
            })
        });
    }

    deletes = document.querySelectorAll(".delete-message");

    if (deletes.length > 0) {
        deletes.forEach(function(el) {
            el.addEventListener("click", function(event) {
                event.preventDefault();

                var message = el.closest(".message");
                message.parentElement.removeChild(message);
            })
        });
    }
});
