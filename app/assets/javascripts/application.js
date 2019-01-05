// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .

// Auto-close alerts.
$(document).ready(function () {
    window.setTimeout(function () {
        $(".alert .close").click();
    }, 5000);
});

// Resize textareas to fit their content on page-load
$(document).on('turbolinks:load', function () {
    $("textarea").each(function (textarea) {
        $(this).height($(this)[0].scrollHeight);
    });
});

// When navigating back through turbolinks history to a page which
// had a modal open, the modal becomes unresponsive and cant be closed.
// This just clears them out when navigating away from a page.
$(document).on('turbolinks:before-render', function () {
    $(".modal.show").modal('hide').css('display', 'none');
    $(".modal-backdrop").remove();
});
