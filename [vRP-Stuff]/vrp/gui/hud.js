$(document).ready(function(){
  $(".character").hide();
  $(".hud").hide();
  $(".mission").hide();
  $(".time").hide();
  $(".info-text").hide();
  window.addEventListener("message", function(event){
    if(event.data.survival == true){
      setProgress(event.data.hunger,'.hunger');
      setProgress(event.data.thirst,'.thirst');
    }
    if(event.data.pmoney){
      $(".pmoney").html(formatNumber(event.data.pmoney)+"  €");
    }
    if(event.data.info_text){
      $(".info-text").show();
      $(".info-text").html(event.data.info_text);
    }else $(".info-text").hide();
    if(event.data.bmoney){
      $(".bmoney").html(formatNumber(event.data.bmoney)+"  €");
    }
    if(event.data.gifts){
      $(".gifts").html(formatNumber(event.data.gifts)+" Cadouri");
    }
    if(event.data.info){
      $(".character").show();
      $(".hud").show();
      $(".time").show();
      $(".menu").hide();
      $("#login").hide();
      $("#register").hide();
      $(".info .title").html(event.data.info);
    }
    if(event.data.mission){
      $(".mission").show();
      $(".mission .content").html(event.data.mission);
      $(".mission .items").html(event.data.items);
    }else $(".mission").hide();
  });
});
function formatNumber(num) {
  return " "+num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
}

function setProgress(percent, element){
  $(element).css("width",percent+"%");
}