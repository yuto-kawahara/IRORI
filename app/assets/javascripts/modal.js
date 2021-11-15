/*global $*/
$(document).on('turbolinks:load', function () {
  var cover = $('#cover');
  var ellipsis_h = $('.ellipsis_h');
  var ellipsis_v = $('.ellipsis_v');

  ellipsis_h.click(function() {
    cover.addClass("hidden");
    $('.recruit_change_area').toggleClass("open");
  });

  ellipsis_v.click(function() {
    cover.addClass("hidden");
    $(this).find('.option_modal').toggleClass("open");
  });


  cover.click(function() {
    cover.removeClass("hidden");
    $('.recruit_change_area').removeClass("open");
    $('.option_modal').removeClass("open");
  });

});