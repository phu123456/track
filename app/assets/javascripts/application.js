// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .

jQuery(function($) {
  // Asynchronously Load the map API
  var script = document.createElement('script');
  script.src = "https://maps.googleapis.com/maps/api/js?key=AIzaSyCf9Z1hvwvDGPJ5yCTopw7AUzUfhhSLXws&callback=initMap";
  document.body.appendChild(script);
});

function initMap() {
  var map;
  var bounds = new google.maps.LatLngBounds();
  var mapOptions = {
      mapTypeId: 'roadmap'
  };

  // Display a map on the page
  map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
  // map.setTilt(45);

  // Multiple Markers
  // var markers = [
  //     ['London Eye, London', 51.503454,-0.119562],
  //     ['Palace of Westminster, London', 51.499633,-0.124755]
  // ];

  // Info Window Content
  var infoWindowContent = [
      ['<div class="info_content">' +
      '<h3>London Eye</h3>' +
      '<p>The London Eye is a giant Ferris wheel situated on the banks of the River Thames. The entire structure is 135 metres (443 ft) tall and the wheel has a diameter of 120 metres (394 ft).</p>' +        '</div>'],
      ['<div class="info_content">' +
      '<h3>Palace of Westminster</h3>' +
      '<p>The Palace of Westminster is the meeting place of the House of Commons and the House of Lords, the two houses of the Parliament of the United Kingdom. Commonly known as the Houses of Parliament after its tenants.</p>' +
      '</div>']
  ];

  // Display multiple markers on a map
  var infoWindow = new google.maps.InfoWindow(), marker, i;
  map.fitBounds(bounds);
  // Loop through our array of markers & place each one on the map

  setInterval( function(){
      // function clearMarkers() {
      //   setMapOnAll(null);
      // }
      var markers = [];
      // marker.setMap(null)
      // console.log(markers)
      $.ajax({
        type:"GET",
        url:"/positions/marker",
        dataType:"json",
        success: function(data){
          var markers = data
          for( i = 0; i < markers.length; i++ ) {
              console.log(markers)
              var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
              // bounds.extend(position);
              marker = new google.maps.Marker({
                  position: position,
                  map: map,
                  title: markers[i][0]
              });

              // Allow each marker to have an info window
              google.maps.event.addListener(marker, 'click', (function(marker, i) {
                  return function() {
                      infoWindow.setContent(infoWindowContent[i][0]);
                      infoWindow.open(map, marker);
                  }
              })(marker, i));
              // Automatically center the map fitting all markers on the screen
          }

        }
      });
  }, 5000 );
  // Override our map zoom level once our fitBounds function runs (Make sure it only runs once)
  var boundsListener = google.maps.event.addListener((map), 'bounds_changed', function(event) {
      this.setZoom(10);
      google.maps.event.removeListener(boundsListener);
  });

}
