/*global $*/
$(document).on('turbolinks:load', function () {
  var side_area = $('#side_area');
  var mask = $('#mask');

  side_area.removeClass('open');
  mask.addClass("hidden");

  $('.mobile_menu_btn').click(function() {
    side_area.addClass('open');
    mask.removeClass("hidden");

    mask.click(function(){
      side_area.removeClass('open');
      mask.addClass("hidden");
    });
  });

  $(window).resize(function(){
    var width = $(window).width();

    if (width >= 600) {
      mask.addClass("hidden");
    }
    else {
      side_area.removeClass('open');
    }
  });
});