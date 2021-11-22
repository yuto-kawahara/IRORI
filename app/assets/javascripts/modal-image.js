/*global $*/
$(document).on('turbolinks:load', function () {
  var image = $('.image');
  var target_image = $('.target_image');
  var mask = $('#mask');

  image.click(function(){
    mask.removeClass("hidden");
    target_image.addClass('open');
    var image_src = image.attr('src');
    target_image.attr('src', image_src);
  });

  mask.click(function(){
    mask.addClass("hidden");
    target_image.removeClass('open');
    target_image.attr('src', "");
  });

  $(window).resize(function(){
    target_image.removeClass('open');
    target_image.attr('src', "");
  });
});