//$(document).ready(function(){  
//  
//  
//});

$(document).ready(function(){
  $('input[type=checkbox]').on("click", get_data); 
  function get_data(){
    $('.item_picture_list').empty();
    checkd = $('input[type=checkbox]:checked');

    data = ""
    for(var i = 0; i < checkd.length; ++i){
      data += ($(checkd[i]).val())+ ",";
    }
    console.log(data);

    var url = $('.pagination .next_page').attr('href');
    
    options = {
      url: url,
      data: {
        categories: data,
      },
      complete: function(response){
        
      },
      dataType: "script"
    }
    console.log(data);
    $.ajax(options);
  }

  if($('.pagination').length){ 
  
    $(window).scroll(function(){    

      var url = $('.pagination .next_page').attr('href');
      checkd = $('input[type=checkbox]:checked');
      data = ""
      for(var i = 0; i < checkd.length; ++i){
        data += ($(checkd[i]).val())+ ",";
      }

      var options = {
        url: url,
        data: {
          categories: data
        },
        dataType: "script"
      };

      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50){
        //console.log("ScrollTop: " + $(window).scrollTop())
        //console.log("Doc Height: " + $(document).height())
        //console.log("Windwo Height: " + $(window).height())
        $.ajax(options);        
        console.log("query:" + url)
      }
    });
    return $(window).scroll();
  }

});
