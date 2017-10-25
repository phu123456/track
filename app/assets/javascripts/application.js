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
        // console.log("---here---")
        // console.log(data)
        var pathCoordinates = data
        // console.log(data[1], (data[0]).length, data[2])
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

    placeMarker()
  };

  // console.log(map)

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
    console.log("sssssssssss")
    $.ajax({
      type:"GET",
      url:"/positions/marker",
      dataType:"json",
      success: function(data){
        console.log(data)
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

    $(".reset").click(function() {
      id = this.id
      $.ajax({
        type:"GET",
        url:"/maintenances/reset",
        data: {
          id: id
        },
        dataType:"json",
        success: function(data){
          // console.log(data[1])
          document.getElementById("progressBar"+id).innerHTML = '<div class="progress"><div class="'+ data[1] +' role="progressbar" style="width: '+ data[0] +'%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">'+ data[0] +'%</div></div>'
        }
      })
    });

  function sortTable(n) {
    var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
    table = document.getElementById("myTable");
    switching = true;
    //Set the sorting direction to ascending:
    dir = "asc";
    /*Make a loop that will continue until
    no switching has been done:*/
    while (switching) {
      //start by saying: no switching is done:
      switching = false;
      rows = table.getElementsByTagName("TR");
      /*Loop through all table rows (except the
      first, which contains table headers):*/
      for (i = 1; i < (rows.length - 1); i++) {
        //start by saying there should be no switching:
        shouldSwitch = false;
        /*Get the two elements you want to compare,
        one from current row and one from the next:*/
        x = rows[i].getElementsByTagName("TD")[n];
        y = rows[i + 1].getElementsByTagName("TD")[n];
        /*check if the two rows should switch place,
        based on the direction, asc or desc:*/
        if (dir == "asc") {
          if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
            //if so, mark as a switch and break the loop:
            shouldSwitch= true;
            break;
          }
        } else if (dir == "desc") {
          if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
            //if so, mark as a switch and break the loop:
            shouldSwitch= true;
            break;
          }
        }
      }
      if (shouldSwitch) {
        /*If a switch has been marked, make the switch
        and mark that a switch has been done:*/
        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
        switching = true;
        //Each time a switch is done, increase this count by 1:
        switchcount ++;
      } else {
        /*If no switching has been done AND the direction is "asc",
        set the direction to "desc" and run the while loop again.*/
        if (switchcount == 0 && dir == "asc") {
          dir = "desc";
          switching = true;
        }
      }
    }
  }
