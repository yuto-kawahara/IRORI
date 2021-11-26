/*global $*/
$(document).on('turbolinks:load', function () {
  var side_area = $('#side_area');
  var mask = $('#mask');
  var modal = $('#modal');

  side_area.removeClass('open');
  mask.addClass("hidden");

  // モバイルメニューボタンをクリックした時にサイドメニューをスライドする
  $('.mobile_menu_btn').click(function() {
    side_area.addClass('open');
    mask.removeClass("hidden");

    mask.click(function(){
      side_area.removeClass('open');
      mask.addClass("hidden");
    });
  });
  // ウィンドウをリサイズした時に、サイドメニューを閉じる
  $(window).resize(function(){
    if (screen.width >= 480) {
      modal.empty();
      mask.addClass("hidden");
      side_area.removeClass('open');
    }
  });
});