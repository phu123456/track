// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require popper
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

function vehicleSearch() {
  vehicle_id = document.getElementById("plate").value
  for (i = 0; i < markersArray.length; i++) {
    if (markersArray[i].name[0] == vehicle_id) {
        map.setZoom(13);
        map.setCenter(markersArray[i].getPosition());
        // console.log(markersArray[i])
    } else
       console.log("")
  }
}
var output = $('#txt');
  var isPaused = false;
  var time = 0;
  var flightPath;
  var flightPathArray = [];
  $(".clear-marker").click(function(e) {
    var startDate = document.getElementById("startDate").value
    var endDate = document.getElementById("endDate").value
    vehicle_id = document.getElementById("plate").value
    e.preventDefault();
    isPaused = true;
    clearMarker()
    $.ajax({
      type:"GET",
      url:"/positions/routes",
      data: {
        id: vehicle_id,
        startDate: startDate,
        endDate: endDate
      },
      dataType:"json",
      success: function(data){
        var pathCoordinates = data
        console.log(data[1], (data[0]).length, data[2])
        flightPath = new google.maps.Polyline({
          path: pathCoordinates[0],
          icons: [{
            icon: lineSymbol,
            offset: '50%'
          }],
          geodesic: true,
          strokeColor: '#FF0000',
          strokeOpacity: 1.0,
          strokeWeight: 2
        });
        animateCircle(flightPath);
        flightPath.setMap(map);
        flightPathArray.push(flightPath);
      }
    });
  });

  $(".normal-mode").click(function(e) {
    isPaused = false;
  });

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
    console.log("fucko ff")
    placeMarker()
  };

  console.log(map)

  function clearMarker() {
    for (var i = 0; i < markersArray.length; i++ ) {
      markersArray[i].setMap(null);
    }
  }

  var t = window.setInterval(function(){
    if(!isPaused) {
      time++;
      output.text("Seconds: " + time);
      clearMarker()
      markersArray.length = 0;
      placeMarker()
    }
  }, 16000 );

  function placeMarker() {
    $.ajax({
      type:"GET",
      url:"/positions/marker",
      dataType:"json",
      success: function(data){
        console.log("55555")

        var markers = data
        for( i = 0; i < markers.length; i++ ) {
          console.log("5550505")
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
  }

  function removeLine() {

     for (var i = 0; i < flightPathArray.length; i++ ) {
       flightPathArray[i].setMap(null);
     }
   }

   var lineSymbol = {
     path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
     scale: 5,
     strokeWeight:2,
     strokeColor: '#393',
   };

   function animateCircle(line) {
        var count = 0;
        window.setInterval(function() {
          count = (count + 1) % 200;

          var icons = line.get('icons');
          icons[0].offset = (count / 2) + '%';
          line.set('icons', icons);
      }, 20);
    }
