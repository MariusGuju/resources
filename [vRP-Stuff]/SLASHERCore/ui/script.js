
$(document).ready(function(){

  window.addEventListener("message", function(event){
    if(event.data.survival == true){
      setProgress(event.data.hunger,'.progress-hunger');
      setProgress(event.data.thirst,'.progress-thirst');
    }

    if(event.data.pmoney) {
      $(".pmoney").html("<span class='symbol'></span>"+event.data.pmoney);
    }
    if(event.data.job){
      $(".job").html("<span class='symbol'></span>"+event.data.job);
    }
    if(event.data.bmoney){
      $(".bmoney").html("<span class='symbol'></span>"+event.data.bmoney);
    }
    if(event.data.aurmoney){
      $(".aurmoney").html("<span class='symbol'></span>"+event.data.aurmoney);
    }
    if(event.data.giftmoney){
      $(".giftmoney").html("<span class='symbol'></span>"+event.data.giftmoney);
    }


  });
});


function setProgress(percent, element){
  $(element).css("width",percent+"%");
}
