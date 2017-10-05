// // This is a manifest file that'll be compiled into application.js, which will include all the files
// // listed below.
// //
// // Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// // vendor/assets/javascripts directory can be referenced here using a relative path.
// //
// // It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// // compiled file. JavaScript code in this file should be added after the last require_* statement.
// //
// // Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// // about supported directives.
// //
// //= require rails-ujs
// //= require turbolinks
// //= require_tree .
//

    window.onload = function () {
        LoadMap();
    };
    var markersArray = [];
    var map;
    function LoadMap() {
        var mapOptions = {
            center: new google.maps.LatLng(14.5829178, 100.8755719),
            zoom: 6,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("dvMap"), mapOptions);
    };

    setInterval(function(){

      for (var i = 0; i < markersArray.length; i++ ) {
        markersArray[i].setMap(null);
      }
      markersArray.length = 0;
      $.ajax({
        type:"GET",
        url:"/positions/marker",
        dataType:"json",
        success: function(data){
          var markers = data
          for( i = 0; i < markers.length; i++ ) {
            var position = new google.maps.LatLng(markers[i][2], markers[i][3]);
            marker = new google.maps.Marker({
                position: position,
                name: [markers[i][0], markers[i][1]],
                icon: "http://maps.google.com/mapfiles/kml/shapes/truck.png",
                // label: {text: markers[i][0], color: "red"},
                map: map,
            });
            markersArray.push(marker);
          }
        }
      });
    }, 10000 );


$(document).ready(function() {
    $('.js-example-basic-single').select2();
});
