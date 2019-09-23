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
  $fileField = $('#file_message')
  $($fileField).on('change', $fileField, function(e) {
    file = e.target.files[0]
    reader = new FileReader(),
    $preview = $("#img_field_message");
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
if (window.location.href.match(/\/groups\/\d+\/messages/)){
  $(function(){  
    $(".user_page__right").scrollTop($("#auto_scroll")[0].scrollHeight);  
  });
}
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
  if (window.location.href.match(/\/groups\/\d+\/messages/)){ //現在いるグループにしか入力を影響させないための記述
  var reloadMessages = function(){
    var last_message_id = $('.message:last').data('message-id');//カスタムデータ属性を利用し、ブラウザに表示されている最新メッセージのidを取得
      $.ajax({
        url: "api/messages",//ルーティングを記述rake route参照
        type: 'GET',  //ルーティングを記述      rake route参照
        dataType: 'json',
        data: {last_id: last_message_id}   //dataオプションでリクエストに値を含める
      })
      .done(function(messages){
        var insertHTML = '';//追加するHTMLの入れ物を作る
          messages.forEach(function(message){//配列messagesの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
          insertHTML = messageHTML(message);//メッセージが入ったHTMLを取得
          $('.user_page__right').append(insertHTML);//メッセージを追加
          $('.user_page__right').animate({ scrollTop: $('.user_page__right')[0].scrollHeight});
        })
      })
      .fail(function() {
        alert('自動更新失敗しました');
      })
    }
  setInterval(reloadMessages, 3000);
}
});
$(function(){
  function buildHTML(comment){
    var comment_text = comment.comment ? `${comment.comment}` : "";
    var html = `
    <div class="comment__message"  data-comment-id="${comment.comment_id}">
    <div class="comment__message__avatar">
    <img style="width: 40px;height:40px;border-radius:50%;box-shadow:rgba(133, 241, 255, 0.856)0px 0px 2px 2px;" src="${comment.user_avatar}">
    </div>
    <text class="comment__message__nickname">
    ${comment.user_name}
    </text>
    <div class="comment__message__comment">
    <text class="comment__message__comment__tri">
    ◥
    </text>
    <text class="comment__message__comment__comment">
    ${comment_text}
    </text>
    </div>
    <div class="comment__message__time">
    <i class="far fa-clock"></i>
    ${comment.time}
    </div>
    </div>`
    return html;
  }
  $('#new_comment').on('submit',function(e){
    e.preventDefault();
    var comment = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: comment,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.comment').append(html)
      $('#new_comment')[0].reset(); 
      return false
    })
    .fail(function(){
      alert('コメントを入力してください');
    })
    .always(function(){
      $('.submit').prop('disabled', false);
    })
  });
});
$(function(){
  setTimeout("$('.notice').fadeOut('slow')", 1500) 
})
$(function(){
  setTimeout("$('.alert').fadeOut('slow')", 1500) 
})
$(function(){
  $fileField = $('#file_avatar')
  $($fileField).on('change', $fileField, function(e) {
    file = e.target.files[0]
    reader = new FileReader(),
    $preview = $("#img_field_avatar");
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