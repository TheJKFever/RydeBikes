jQuery(function($) {
  $('body').addClass('postload');

  // $('body').waypoint(function() {
  //     $('body').toggleClass('stuck');
  //   }, { offset: -140});

  $('#header-wrap').waypoint('sticky');
  
    $('.page-content').waypoint(function() {
    $('body').toggleClass('stuck');
  }, { context: '.page-container', offset: -200 });
  
  // Reveal search field
  
  var search = false;
  
  $('#search .wsite-search-button').click(function(){
      $("#search").toggleClass("showsearch");
      if ($("#search").hasClass("showsearch")) {
          $("#search .wsite-search-input").focus();                
      }
      return false;
  });
	
	// Move cart

  var cart = $("#navhidden").detach();
  cart.insertAfter('#header');
	if (!$('.wsite-nav-cart').length) {
	  $("#search").css({ 'width': '255px', 'padding-right': '0'});
	}
  $('#main-wrap').jqTransform());

});