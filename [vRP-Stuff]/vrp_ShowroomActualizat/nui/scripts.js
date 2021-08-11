window.addEventListener("message", function(event){

    let data = event.data

	if (data.action == "deschideShowroomlolxd") {

        document.getElementById("opwnShowroom").style.display = "inline-block";

        // document.querySelector("#categorii").innerHTML = data.categorii;

    }

    if (data.act == "adaugaCategori") {

        document.querySelector("#categorii").innerHTML = data.categorii;

        document.getElementById("categorii").style.display = data.stil;

    }

	if (data.action == "adaugaMasinile") {

        document.querySelector("#masinile").innerHTML = data.masinile;

    }

    if (data.action == "adaugaInfoDespremasina") {

        document.getElementById("infoMasina").style.display = "block";

        // document.querySelector("#numeMasina-info").innerHTML = data.numemasina;

        document.querySelector("#numeMasina-pret").innerHTML = "$"+data.pret;



        document.querySelector("#frana").innerHTML = data.brakes+"%";

        document.getElementById("franabox").style.width = data.brakes+"%";



        document.querySelector("#acceleratie").innerHTML = data.acceleration+"%";

        document.getElementById("acceleratiebox").style.width = data.acceleration+"%";



        document.querySelector("#kmperh").innerHTML = data.maxspeed;

        document.getElementById("kmperhbox").style.width = data.maxspeedbar+"%";



    }



    if (data.action == "inchideShowroom") {

        document.getElementById("opwnShowroom").style.display = "none";

        document.getElementById("infoMasina").style.display = "none";

    }

});



function schimbaCategoria(categorieSelectata) {

    $('#masinile').empty();

    $.post('http://vrp_ShowroomActualizat/changeCategory', JSON.stringify({categorieSelectata}));

}



function spawnMasina(idSelectie) {

    $.post('http://vrp_ShowroomActualizat/spawnVehicle', JSON.stringify({idSelectie}));

}



function exitShowroom() {

    document.getElementById("opwnShowroom").style.display = "none";

    document.getElementById("infoMasina").style.display = "none";

    $.post('http://vrp_ShowroomActualizat/exitshowroom', JSON.stringify({}));

    $('#masinile').empty();

    $('#categorii').empty();

}



function goBack(categorii) {

    document.getElementById("infoMasina").style.display = "none";

    $.post('http://vrp_ShowroomActualizat/goBack', JSON.stringify({ categorii }));

    $('#masinile').empty();

}



function cumparaMasina() {

    $.post('http://vrp_ShowroomActualizat/cumparaMasina', JSON.stringify({}));

}



function testeazaMasina() {

    $.post('http://vrp_ShowroomActualizat/testeazaMasina', JSON.stringify({}));

}



function culoare(culoareselectata) {

	$.post('http://vrp_ShowroomActualizat/schimbaCuloare', JSON.stringify({culoareselectata}));

}



$(document).ready(function () {

    var vehicleShopStartRotate = false

    var vehicleShopMousePositionX = 0

    var vehicleShopMousePositionY = 0



    $("body").mousedown(function (a) {

        vehicleShopStartRotate = true;

        vehicleShopMousePositionX = a.pageX;

        vehicleShopMousePositionY = a.pageY

    });



    $("body").mouseup(function (a) {

        vehicleShopStartRotate = false;

    });



    $("body").mousemove(function (a) {

        if (vehicleShopStartRotate) {

            let h = (a.pageX - vehicleShopMousePositionX / 5);

            $.post('http://vrp_ShowroomActualizat/schimbaHeading', JSON.stringify({ h }));

            vehicleShopMousePositionX = a.pageX

            vehicleShopMousePositionY = a.pageY

        }

    });

});