$(document).ready(function(){
  $('#locate_me').on("click", get_postion);
  $('#find_address').on("click", get_postion);

  function show_pos(position) {
    var latitude = position.coords.latitude
    var longitude = position.coords.longitude

    var pos = new google.maps.LatLng(latitude, longitude);

    options = {
      url: "update_location", 
      type: "get",
      data: {
        "location[latitude]": latitude,
        "location[longitude]": longitude
      },
      complete: function(response){
        $('.spinner').hide();
        $('.item_picture_list').last().append(response.responseText);

      }
    };

    $.ajax(options);

    var infowindow = new google.maps.InfoWindow({
      map: map,
      position: pos,
      content: 'You are here'
    });

    map.setCenter(pos);

  }

  function show_error(error){
    alert("Error");
  }

  function get_postion(event){
    $('h1').show();
    $('.spinner').show();

    $('.item_picture_list').empty();
    var mapOptions = {
      zoom: 14,
      zoomControl: false,
      disableDefaultUI: true, 
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    map = new google.maps.Map(document.getElementById('map_home_page'), mapOptions);

    if (event.target.id == "locate_me") {
      // Try HTML5 geolocation
      if(navigator.geolocation) {
        console.log(navigator.geolocation)
        navigator.geolocation.getCurrentPosition(show_pos, show_error);
      } else {
        alert("Sorry, your browser does not suport GeoLocation");
      }
    } else if (event.target.id == "find_address") {
      geocoder = new google.maps.Geocoder();
      address = $('#search_box').val()
      geocoder.geocode({'address': address}, function(results, status){ 
         position = { coords: {latitude: results[0].geometry.location.ob, longitude: results[0].geometry.location.pb}}
          show_pos(position)
      });
    } else {
    }
  }
});
