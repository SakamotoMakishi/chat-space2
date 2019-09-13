$(function() {
  $('.chat_all__space__lists').addClass('show');
});
jQuery(function(){
  jQuery(window).scroll(function (){
      jQuery('.root_page__right__contents_fadein').each(function(){
          var elemPos = jQuery(this).offset().top;
          var scroll = jQuery(window).scrollTop();
          var windowHeight = jQuery(window).height();
          if (scroll > elemPos - windowHeight + 0){
              jQuery(this).addClass('scrollin');
          }
      });
  });
  jQuery(window).scroll();
});