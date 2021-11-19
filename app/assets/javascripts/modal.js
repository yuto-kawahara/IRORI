/*global $*/
$(document).on('turbolinks:load', function () {
  var target = $('.list');
  const config = { attributes: false, childList: true, subtree: true };
  var cover = $('#cover');
  var ellipsis_h = $('.ellipsis_h');


  ellipsis_h.click(function() {
    cover.addClass("hidden");
    $('.recruit_change_area').toggleClass("open");
  });

  var ellipsis_v = $('.ellipsis_v');

  target.on('click', '.ellipsis_v', function() {
    cover.addClass("hidden");
    $(this).find('.option_modal').addClass("open");
  });

  cover.click(function() {
    cover.removeClass("hidden");
    $('.recruit_change_area').removeClass("open");
    $('.option_modal').removeClass("open");
  });

});