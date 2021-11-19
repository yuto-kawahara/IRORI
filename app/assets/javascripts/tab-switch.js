/*global $*/
$(document).on('turbolinks:load', function () {
  $('.tab__link').each(function() {
    var href = $(this).attr('href');
    if (href.indexOf('?') != -1) {
      href = href.substring(0, href.indexOf('?'));
    }

    if (location.pathname == href) {
      $(this).addClass('active');
    }
    else {
      $(this).removeClass('active');
    }

  });
});