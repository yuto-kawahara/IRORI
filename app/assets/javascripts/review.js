/*global $*/
$(document).on('turbolinks:load', function () {

  var evaluate_stars = $('#evaluate_stars');
  if (evaluate_stars != null) {
    evaluate_stars.empty();
    evaluate_stars.raty({
      starOn: '/assets/star-on.png',
      starOff: '/assets/star-off.png',
      starHalf: '/assets/star-half.png',
      scoreName: 'evaluation[stars]',
      half: true
    });
  }


  var review_stars = $('.review_stars');
  if (review_stars != null) {
    review_stars.empty();
    review_stars.raty({
      readOnly: true,
      score: function() {
        return $(this).attr('data-score');
      },
      path: '/assets/'
    });
  }
});