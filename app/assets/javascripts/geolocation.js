
$(document).ready(function(){

  $('#locate_me').on("click", get_postion);

  
 function show_pos(position) {
   var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

   var infowindow = new google.maps.InfoWindow({
     map: map,
     position: pos,
     content: 'Location HTML5.'
   });
    map.setCenter(pos);
  }

  function show_error(error){
    alert("Error");
  }

  function get_postion(){
    var mapOptions = {
      zoom: 14,
      zoomControl: false,
      disableDefaultUI: true, 
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    map = new google.maps.Map(document.getElementById('map'), mapOptions);

    // Try HTML5 geolocation
    if(navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(show_pos, show_error);
    } else {
      alert("Sorry, your browser does not suport GeoLocation");
    }
  }
});
