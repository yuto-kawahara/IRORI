/*global $*/
$(document).on('turbolinks:load', function () {
  $('.tab__link').each(function() {
    var $href = $(this).attr('href');

    if (location.pathname == $href) {
      $(this).addClass('active');
    }
    else {
      $(this).removeClass('active');
    }

  });
});