/*global $*/
$(document).on('turbolinks:load', function() {
  var search_form = $('#user_search_form');
  var search_result = $('.search_result');

  // 検索時に追加される子要素
  function buildHTML(data){
    var html = `<li class="result_item">${data.nickname}</li>`;
    search_result.append(html);
  }
  // 該当するユーザーがいない場合に'該当するユーザーはいません'を表示する
  function no_result(message) {
    var html = `<li>${message}</li>`;
    search_result.append(html);
  }

  // 検索フォームのkeyアップに合わせてsearchメソッドを実行
  search_form.on('keyup', function() {
    var target = $(this).val();
    if (target !== "") {
      search(target);
    }
    else {
      search_result.empty();
    }
  });

  // Ajaxによる検索メソッド
  function search(target) {
    $.ajax({
      type: 'get',
      url: '/users/search',
      data: {keyword: target},
      dataType: 'json'
    })
    .done(function(data) {
      search_result.empty();
      if (data.length !== 0) {
        data.forEach(function(data) {
          buildHTML(data);
        });
      }
      else {
        no_result('該当するユーザーはいません');
      }
    })
    .fail(function(data) {
      alert('非同期通信に失敗しました');
    });
  }
  // 検索結果をクリックした後、フォームにフォーカスし検索結果を削除
  search_result.on('click', '.result_item', function(){
    var result_item = $('.result_item');
    search_form.val(this.textContent);
    search_form.focus();
    result_item.remove();
  });
});
