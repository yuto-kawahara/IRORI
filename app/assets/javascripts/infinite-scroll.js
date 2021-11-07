/*global $*/
$(document).on('turbolinks:load', function () {
  if ($("nav.pagination a[rel=next]").length) {
    $('.list').infiniteScroll({
      path: "nav.pagination a[rel=next]",
      append: ".item",
      hideNav: "nav.pagination",
      history: true,
      scrollThreshold: 400,
      prefill: true,
      status: ".page-load-status",
    });
  };
});