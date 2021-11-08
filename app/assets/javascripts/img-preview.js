/*global $*/
$(document).on('turbolinks:load', function() {
  var file_field = document.querySelector('input[type=file]')
  $('#img_refile').change(function(){
    var file = $('input[type="file"]').prop('files')[0];
    var fileReader = new FileReader();
    fileReader.onloadend = function() {
      var src = fileReader.result
      var html= `<div class='item_img' data-image="${file.name}">
                   <div class='item_img__inner'>
                     <img src="${src}" class="upload_img">
                     <button type='button' class='btn btn__img_delete'>
                       <i class="fas fa-times"></i>
                     </button>
                   </div>
                 </div>`
      $('.img_wrapper').before(html);
    }
    fileReader.readAsDataURL(file);
  });

  $(document).on('click', '.btn__img_delete', function(){
    var file_field = document.querySelector('input[type=file]')
    var target_image = $('.item_img');
    target_image.remove();
    file_field.value = '';
  });
});
