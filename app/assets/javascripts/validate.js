/*global $*/
$(document).on('turbolinks:load', function () {
  var privacy_check = $('#privacy_check');
  var btn__sending = $('.btn__sending');
  btn__sending.addClass('no_active');

  var subject_count = 0;
  var message_count = 0;

  $('#contact_subject').on('keyup', function() {
    subject_count = $(this).val().length;
  });
  $('#contact_message').on('keyup', function() {
    message_count = $(this).val().length;
  });

  privacy_check.change(function() {
    if (subject_count >= 5 &&
      message_count >= 5 &&
      privacy_check.is(':checked')) {
      btn__sending.removeClass('no_active');
    }
  });
});