$(document).ready(function(){
  $('#demo-link').click(function(){
    $('#user_email').val('demo@romibo.com');
    $('#user_password').val('password');
    $('#signUpButton').trigger('click');
  });
})
