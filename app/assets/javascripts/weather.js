  $(function() {
    function buildHTML(data, i) {
      var Week = new Array("（日）","（月）","（火）","（水）","（木）","（金）","（土）");
      var date = new Date (data.list[i].dt_txt);
      date.setHours(date.getHours() + 9);
      var month = date.getMonth()+1;
      var day = month + "月" + date.getDate() + "日" + Week[date.getDay()] + date.getHours() + "：00";
      var icon = data.list[i].weather[0].icon;
      // var rain = "";
      // if (data.list[i].rain) {
      //   rain = "降水量：" + Math.round(data.list[i].rain["3h"]) + "mm";
      // }
      var html =
      '<div class="weather-report">' +
        '<img src="http://openweathermap.org/img/w/' + icon + '.png">' +
        '<div class="weather-date">' + day + '</div>' +
        '<div class="weather-main">'+ data.list[i].weather[0].main + '</div>' +
        '<div class="weather-temp">' + Math.round(data.list[i].main.temp) + '℃</div>' +
      '</div>';
      return html
    }
    var API_KEY = '651e21f4cb404a11b71c7070586bda48'
    var city = 'Osaka';
    var url = 'http://api.openweathermap.org/data/2.5/forecast?q=' + city + ',jp&units=metric&APPID=' + API_KEY;
    $.ajax({
      url: url,
      dataType: "json",
      type: 'GET',
    })
    .done(function(data) {
      var insertHTML = "";
      var cityName = '<h2>' + data.city.name + '</h2>';
      $('#city-name').html(cityName);
      for (var i = 0; i <= 8; i = i + 2) {
        insertHTML += buildHTML(data, i);
      }
      $('#weather').html(insertHTML);
    })
    .fail(function(data) {
      console.log("失敗しました");
    });
  });