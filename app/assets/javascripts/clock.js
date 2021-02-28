function clock() {
  var twoDigit = function(num){
    var digit
    if( num < 10 )
    { digit = "0" + num; }
    else { digit = num; }
    return digit;
  }
  var weeks = new Array("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
  var now = new Date();
    var year = now.getFullYear();
    var month = twoDigit(now.getMonth() + 1);
    var day = twoDigit(now.getDate());
    var week = weeks[now.getDay()];
    var hour = twoDigit(now.getHours());
    var minute = twoDigit(now.getMinutes());
    var second = twoDigit(now.getSeconds());
  document.getElementById("clock_date").textContent = year + "/" + month + "/" + day + " (" + week + ")";
  document.getElementById("clock_time").textContent = hour + ":" + minute + ":" + second;
}

setInterval(clock, 1000);