/*global $*/
$(document).on('turbolinks:load', function () {
  var target = document.getElementById('review_list');
  const config = { attributes: false, childList: true, subtree: true };

  function review() {
    var review_stars = $('.review_stars');
    if (review_stars != null) {
      review_stars.empty();
      review_stars.raty({
        readOnly: true,
        score: function() {
          return review_stars.attr('data-score');
        },
        path: "/images/"
      });
    }
  }
  review();
  // 親要素(review_list)に子要素が追加されたらreviewメソッドを実行する
  if (target !== null) {
    var observer = new MutationObserver(function(record) {
      observer.disconnect();
      review();
      observer.observe(target, config);
    });
    observer.observe(target, config);
  }
});