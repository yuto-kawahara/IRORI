/*global $*/
$(document).on('turbolinks:load', function () {
  // サイドメニューの各項目をクリックした時に、activeクラスを付与
  $('.side_menu__link').each(function() {
    var $href = $(this).attr('href');

    if (location.pathname == $href) {
      $(this).addClass('active');
    }
    else {
      $(this).removeClass('active');
    }
  });
  // フッターメニューの各項目をクリックした時に、activeクラスを付与
  $('.footer_menu__link').each(function() {
    var $href = $(this).attr('href');

    if (location.pathname == $href) {
      $(this).addClass('active');
    }
    else {
      $(this).removeClass('active');
    }
  });
});