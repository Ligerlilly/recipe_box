$(document).ready(function(){
  $('.search').hide();
  $('#search').hide();
  if(window.location.pathname === '/recipes') {
    $('#search').show();
  }
  $('#search').click(function(){
    $('#search').hide();
    $('.search').show();
  });
});
