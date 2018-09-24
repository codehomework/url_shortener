$(document).ready(function(){
  $("form").submit(function(event){
    event.preventDefault();

    // Step 1: Get what the user typed in
    var user_entered_long_url = $("#shortened_io").val();

    // Step 2: If the user entered nothing, complain
    // and quit
    if(user_entered_long_url == ""){
      $(".shortener_console").text("You must enter a URL to shorten.");
      return;
    }

    // Step 3: Kick off an AJAX request to the backend
    // and handle the reply
    $.ajax({
      type: "POST",
      url: '/urls',
      data: {'long_url': user_entered_long_url},
      success: function(data){
        $(".shortener_console").html("Your short URL is: <a href='" + data.short_url + "'>" + data.short_url + "</a>");
      },
      statusCode: {
      400: function(){
        $(".shortener_console").text("That's not a valid URL.");
      }
  }
    });
  });
});
