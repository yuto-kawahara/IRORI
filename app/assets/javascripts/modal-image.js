/*global $*/
$(document).on('turbolinks:load', function () {
  var image = $('.image');
  var target_image = $('.target_image');
  var mask = $('#mask');

  // 募集画面の投稿画像をクリックした時に画像をアップ表示する
  image.click(function(){
    mask.removeClass("hidden");
    target_image.addClass('open');
    var image_src = image.attr('src');
    target_image.attr('src', image_src);
  });

  // 画像アップ時に外側のウィンドウをクリックした時に画像をもとのサイズに更新
  mask.click(function(){
    mask.addClass("hidden");
    target_image.removeClass('open');
    target_image.attr('src', "");
  });

  //　ウィンドウのリサイズ時に画像アップを解除
  $(window).resize(function(){
    target_image.removeClass('open');
    target_image.attr('src', "");
  });
});