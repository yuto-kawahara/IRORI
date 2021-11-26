/*global $*/
$(document).on('turbolinks:load', function () {
  var target = $('.list');
  var cover = $('#cover');
  var ellipsis_h = $('.ellipsis_h');

  // 募集画面の右上の三点リーダークリック時にモーダルウィンドウを表示
  ellipsis_h.click(function() {
    cover.addClass("hidden");
    $('.recruit_change_area').toggleClass("open");
  });

  // コメント・通知・卓報告の削除時に右上の三点リーダークリック時にモーダルウィンドウを表示
  target.on('click', '.ellipsis_v', function() {
    cover.addClass("hidden");
    $(this).find('.option_modal').addClass("open");
  });

  // モーダルウィンドウ以外をクリックした時にモーダルウィンドウを閉じる
  cover.click(function() {
    cover.removeClass("hidden");
    $('.recruit_change_area').removeClass("open");
    $('.option_modal').removeClass("open");
  });
});