// smooth scroll to all anchor links
$(document).ready(function () {
  // Add smooth scrolling to all links
  $("a").on("click", function (event) {
    // Make sure this.hash has a value before overriding default behavior
    if (this.hash !== "") {
      // Prevent default anchor click behavior
      event.preventDefault();

      // Store hash
      var hash = this.hash;

      // Using jQuery's animate() method to add smooth page scroll
      // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
      $("html, body").animate(
        {
          scrollTop: $(hash).offset().top,
        },
        800,
        function () {
          // Add hash (#) to URL when done scrolling (default click behavior)
          window.location.hash = hash;
        }
      );
    } // End if
  });
});

// mega menu
jQuery(document).on("click", ".mega-dropdown", function (e) {
  e.stopPropagation();
});

/**
 * Image Apear Based On Viewport
 */
$(function () {
  // Execute the viewport for a element
  $(".deck_text section").appear();

  // Force execute after click the navigation
  $(".deck_menu_list .list-inline .deck_menu_item a").on("click", function () {
    $.force_appear();
  });

  // Force execute after reload the browser
  $(document.body).ready(function () {
    $.force_appear();
  });

  // TODO: Refactor to be less explicit, can't expect end-user to edit JS

  // Effect for a element
  $(document.body).on("appear", "#overview", function (e, $affected) {
    // Set the image
    $(".deck_image_list .product_img img").attr("src", "images/stack-0.png");

    // Remove previous active class
    $(".deck_menu_list .list-inline .deck_menu_item a").removeClass("active");

    // Set active class for current nav
    $(".deck_menu_list .list-inline .deck_menu_item a#overview-link").addClass(
      "active"
    );
  });

  // Effect for a element
  $(document.body).on("appear", "#provision", function (e, $affected) {
    // Set the image
    $(".deck_image_list .product_img img").attr("src", "images/stack-1.png");

    // Remove previous active class
    $(".deck_menu_list .list-inline .deck_menu_item a").removeClass("active");

    // Set active class for current nav
    $(".deck_menu_list .list-inline .deck_menu_item a#provision-link").addClass(
      "active"
    );
  });

  // Effect for a element
  $(document.body).on("appear", "#secure", function (e, $affected) {
    // Set the image
    $(".deck_image_list .product_img img").attr("src", "images/stack-2.png");

    // Remove previous active class
    $(".deck_menu_list .list-inline .deck_menu_item a").removeClass("active");

    // Set active class for current nav
    $(".deck_menu_list .list-inline .deck_menu_item a#secure-link").addClass(
      "active"
    );
  });

  // Effect for a element
  $(document.body).on("appear", "#connect", function (e, $affected) {
    // Set the image
    $(".deck_image_list .product_img img").attr("src", "images/stack-3.png");

    // Remove previous active class
    $(".deck_menu_list .list-inline .deck_menu_item a").removeClass("active");

    // Set active class for current nav
    $(".deck_menu_list .list-inline .deck_menu_item a#connect-link").addClass(
      "active"
    );
  });

  // Effect for a element
  $(document.body).on("appear", "#run", function (e, $affected) {
    // Set the image
    $(".deck_image_list .product_img img").attr("src", "images/stack-0.png");

    // Remove previous active class
    $(".deck_menu_list .list-inline .deck_menu_item a").removeClass("active");

    // Set active class for current nav
    $(".deck_menu_list .list-inline .deck_menu_item a#run-link").addClass(
      "active"
    );
  });
});
