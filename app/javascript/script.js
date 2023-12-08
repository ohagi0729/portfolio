$(function() {
  $('#top-btn').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 200);
    event.preventDefault();
  });
});