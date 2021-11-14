/*global $*/
$(document).on('turbolinks:load', function () {
  var cover = $('#cover');
  var reader = $('.three_point_reader');

  reader.click(function() {
    cover.addClass("hidden");
    $('.recruit_change_area').toggleClass("open");
  });
  cover.click(function() {
    cover.removeClass("hidden");
    $('.recruit_change_area').removeClass("open");
  });

});