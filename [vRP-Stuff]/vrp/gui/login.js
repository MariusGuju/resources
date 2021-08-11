function LoginTry(){
  var username = $("#login #username").val();
  var password = $("#login #pass").val();
  $.post("http://vrp/vrp_login", JSON.stringify({username: username,password: password}));
  setTimeout(function(){},5000);
}

function RegisterTry(){
  var username = $("#register #username").val();
  var password = $("#register #pass").val();
  $.post("http://vrp/vrp_register", JSON.stringify({username: username,password: password}));
  setTimeout(function(){},5000);
}

function StopDisplay(){
  $("#login").css("display","none");
}

window.addEventListener('message', function(event){
  var item = event.data;
  
  if(item.loginSuccesful == true) {
    $("#login").css("display","none");
    $("#register").css("display","none");
    $(".menu").css("display","none");
  }
});

var show_reg = false;
var show_log = false;

function RegisterShow(){
  show_reg = !show_reg;
  show_log = false;
  if (show_reg) $("#register").show(); else $("#register").hide();
  if (show_log) $("#login").show(); else $("#login").hide();
}

function LoginShow(){
  show_log = !show_log;
  show_reg = false;
  if (show_reg) $("#register").show(); else $("#register").hide();
  if (show_log) $("#login").show(); else $("#login").hide();
}