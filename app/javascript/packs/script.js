document.addEventListener("turbolinks:load", function(){
  $('.top-btn').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 200);
    event.preventDefault();
  });

  $('.menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('.sp-menu').fadeToggle();
    event.preventDefault();
  });
});