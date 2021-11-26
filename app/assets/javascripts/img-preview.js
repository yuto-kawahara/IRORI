/*global $*/
$(document).on('turbolinks:load', function() {
  // 画像追加時に画面に即時反映
  $('#img_refile').change(function(){
    var file = $('input[type="file"]').prop('files')[0];
    var faceicon = document.querySelector('.edit_face_icon');
    var fileReader = new FileReader();

    fileReader.onloadend = function() {
      var src = fileReader.result;

      if (faceicon != null) {
        faceicon.src = src;
      }
      else {
        var html= `<div class='item_img' data-image="${file.name}">
                     <div class='item_img__inner'>
                       <img src="${src}" class="upload_img">
                       <i class="fas fa-times-circle btn__img_delete"></i>
                     </div>
                   </div>`;
        $('.img_wrapper').before(html);
      }
    };
    fileReader.readAsDataURL(file);
  });

  $(document).on('click', '.btn__img_delete', function(){
    var file_field = document.querySelector('input[type=file]');
    var target_image = $('.item_img');
    target_image.remove();
    file_field.value = '';
  });
});
