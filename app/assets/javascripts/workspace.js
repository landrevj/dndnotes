// all this does is auto submit the workspace select form when the select changes
// this could easily be replaced with a submit button in the form itself
$(document).on('turbolinks:load', function () {
  if ($('.workspace-activate-form').length > 0) {
    $('.workspace-activate-form .workspace-select').change(function () {
      $('.workspace-activate-form').submit();
    })
  }
});
