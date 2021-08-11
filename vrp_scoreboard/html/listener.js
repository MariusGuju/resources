$(function()
{
	window.addEventListener('message', function(event)
	{
		var item = event.data;
		var buf = $('#wrap');

		$('#ems').html(event.data.ems);
		$('#police').html(event.data.police);
		$('#fbi').html(event.data.fbi);
		$('#hitman').html(event.data.hitman);
		$('#uber').html(event.data.uber);
		$('#curve').html(event.data.curve);
		$('#mechanic').html(event.data.mechanic);
		$('#spelare').html(event.data.spelare);
		$('#maximus').html(event.data.maximus);
		if(event.data.thePage == 3) {
			$('#thePage').html(1);
			$('#maxPages').html(1);
		} else {
			$('#thePage').html(event.data.thePage);
			$('#maxPages').html(2);
		} 
		
		buf.find('table').append("<tr class=\"heading\"><th width='5%'>ID</th><th width='20%'>Nume</th><th width='17%'>Factiune</th><th width='17%'>Job</th><th width='16%'>Premium</th><th width='11%'>Ore</th></tr>");
		if (item.meta && item.meta == 'close')
		{
			document.getElementById("ptbl").innerHTML = "";
			$('#wrap').hide();
			return;
		}
		buf.find('table').append(item.text);
		$('#wrap').show();
	}, false);
});


