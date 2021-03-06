/*global $*/
// 無限スクロール：2ページ目以降、ページ読み込みを実行
$(document).on('turbolinks:load', function () {
  if ($("nav.pagination a[rel=next]").length) {
    $('.list').infiniteScroll({
      path: "nav.pagination a[rel=next]",
      append: ".item",
      hideNav: "nav.pagination",
      history: 'push',
      scrollThreshold: 400,
      prefill: true,
      status: ".page-load-status",
    });
  };
});