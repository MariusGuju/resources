
window.addEventListener("message", function(event){
	let data = event.data
	if (data.action == "olxMenu") {
    document.getElementById("background").style.display = "block";
    document.getElementById("olx").style.display = "block";
    document.querySelector("#vehicul").innerHTML = data.masina;
    document.querySelector("#vehiculplacuta").innerHTML = data.plate;
    document.querySelector("#proprietar").innerHTML = data.proprietar;
    document.querySelector("#pretmasina").innerHTML = '$'+data.pret;
    // TUNING
    if (data.engine == -1 ) {
      data.engine = 0
    }
    if (data.brakes == -1 ) {
      data.brakes = 0
    }
    if (data.turbo == -1 ) {
      data.turbo = 0
    }
    if (data.transmisii == -1 ) {
      data.transmisii = 0
    }
    document.querySelector("#infoengine").innerHTML = data.engine;
    document.querySelector("#infobrakes").innerHTML = data.brakes;
    document.querySelector("#infoturbo").innerHTML = data.turbo;
    document.querySelector("#infotransmisii").innerHTML = data.transmisii;
  }
  if (data.action == 'inchideOLX') {
    document.getElementById("background").style.display = "none";
    document.getElementById("olx").style.display = "none";
    $.post('http://KROlx/inchideOLX', JSON.stringify({}));
  }
});

$(document).ready(function(){
    document.onkeyup = function (data) {
      if (data.which == 27 ) {
        document.getElementById("background").style.display = "none";
        document.getElementById("olx").style.display = "none";
        $.post('http://KROlx/inchideOLX', JSON.stringify({}));
      }
    };
});

function cumpara(){
  $.post('http://KROlx/cumparamasina', JSON.stringify({}));
}


