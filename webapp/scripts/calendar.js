/* ienursing calendar page*/
var timeInterval = 1000;
var redLineWidth = 2;

function moveNowTimeRedLine() {
	var myDate = new Date();
	var nowHour = myDate.getHours();

	if (nowHour >= 8 && nowHour <= 38) {
		nowHour = nowHour;
		var fromLeft = 142;
		var perPX = 0.026388889;
		var nowMinute = myDate.getMinutes();
		var nowSecond = myDate.getSeconds();
		var totalSeconds = nowSecond + nowMinute * 60 + (nowHour - 8) * 60 * 60;
		var resultPX = fromLeft + perPX * totalSeconds;
		// alert(nowHour + " " + nowMinute+ " " + nowSecond+ " " + resultPX);
		j$("#content_now_time_line_div").css("width", redLineWidth + "px");
		j$("#content_now_time_line_div").css("left", resultPX + "px");
	}
}

