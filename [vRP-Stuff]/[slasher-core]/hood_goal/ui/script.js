
$(document).ready(function(){

  window.addEventListener("message", function(event){

    if(event.data.pmoney) {
      $(".pmoney").html("<span class='symbol'></span>"+event.data.pmoney);
    }
    if(event.data.contributiamea) {
      $(".contributiamea").html("<span class='symbol'></span>"+event.data.contributiamea);
    }


  });
});


function setProgress(percent, element){
  $(element).css("width",percent+"%");
}
