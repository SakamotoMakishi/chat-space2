$(function(){
  $('.js-modal-open').on('click',function(){
      $('.js-modal').fadeIn();
  });
  $('.js-modal-close').on('click',function(){
      $('.js-modal').fadeOut();
  });
});
$(function(){
  var modalBtn = $('.js-modal__btn');
  var modalBtnClose = $('.js-modal__btn--close');
  var modalBtnCloseFix = $('.js-modal__btn--close--fix');
  var modalBg = $('.js-modal__bg');
  var modalMain = $('.js-modal__main');
  modalBtn.on('click', function (e) {
    $(this).next(modalBg).fadeIn();
    $(this).next(modalBg).next(modalMain).removeClass("_slideDown");
    $(this).next(modalBg).next(modalMain).addClass("_slideUp");
  });
  modalBtnClose.on('click', function (e) {
    modalBg.fadeOut();
    modalMain.removeClass("_slideUp");
    modalMain.addClass("_slideDown");
  });
  modalBtnCloseFix.on('click', function (e) {
    modalBg.fadeOut();
    modalMain.removeClass("_slideUp");
    modalMain.addClass("_slideDown");
  });
  modalMain.on('click', function (e) {
    e.stopPropagation();
  });
  modalBg.on('click', function () {
    $(this).fadeOut();
    $(this).next(modalMain).removeClass("_slideUp");
    $(this).next(modalMain).addClass("_slideDown");
  });
});
$(function(){
  $fileField = $('#file')
  $($fileField).on('change', $fileField, function(e) {
    file = e.target.files[0]
    reader = new FileReader(),
    $preview = $("#img_field");
    reader.onload = (function(file) {
      return function(e) {
        $preview.empty();
        $preview.append($('<img>').attr({
          src: e.target.result,
          class: "avatar_preview",
          title: file.name
        }));
      };
    })(file);
    reader.readAsDataURL(file);
  });
});

$(function(){
  function messageHTML(message){
    var image = message.image ? `<img class="content_image" src="${message.image}">` : "";  //message.imageにtrueならHTML要素、faiseなら空の値を代入。
    var html = `<div class="message" data-message-id="${message.id}">
                  <div class="message_current_user">
                    <div class="message__user">
                    <div class="message__user__avatar">
                      <img style="width: 70px;height:70px;border-radius:50%;box-shadow:rgba(133, 241, 255, 0.856)0px 0px 2px 2px;" src="${message.user_avatar}">
                    </div>
                    <div class="message__user__name">
                      ${message.name}
                    </div>
                    </div>
                    <div class="message__content">
                      <text class="message__content__tri">
                      ◤
                      </text>
                      <div class="message__content__text">
                      ${message.content}
                    </>
                    <div class="message__content__image">
                      ${image}
                    </div>
                    </div>
                    <div class="message__check">
                    </div>
                    <text class="message__time11">
                      ${message.date}
                    <i class="fas fa-trash-alt js-modal-open"></i>
                    </text>
                    </div>
                </div>
                `
    return html;
  }
  $('#new_message').on('submit',function(e){
    e.preventDefault();     //submitされた処理を止める。
    var message = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: message,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(message){
      var html = messageHTML(message);  //messageHTMLを変数でappendに渡す。↓
      $('.user_page__right').append(html)     //変数を受け取る。↑
      $('#new_message')[0].reset();  //text送信後入力した値を消す。
      $('.user_page__right').animate({ scrollTop: $('.user_page__right')[0].scrollHeight});  //メッセージ入力後スクロールで一番下まで戻す。
      return false
    })
    .fail(function(){
      alert('メッサージを入力してください');
    })
    .always(function(){ //リロードせずにSENDボタンを推せる
      $('.submit').prop('disabled', false);
    })
  });
})