$(document).ready(function(){

  if("#existing_credit_card") {

    $("#new_card_btn").on("click", function(event){

      // Show new card form
      $("#new_credit_card").toggleClass("hidden");

    });

    $("#payment").submit(function(event) {
      // Hide new card form
      $("#new_credit_card").toggleClass("hidden");
    });

  };

});
