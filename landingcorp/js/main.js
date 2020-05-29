let productMenuItem = document.querySelectorAll(
  ".product_menu_list .product_menu_item a"
);
let productDetails = document.querySelectorAll(
  ".product_section .product_details"
);
let productMenuList = document.querySelector(".product_menu_list");
let lastId;
let cur = [];

productMenuItem.forEach((link) => {
  link.addEventListener("click", (event) => {
    event.preventDefault();
    let target = document.querySelector(event.target.hash);
    target.scrollIntoView({
      behavior: "smooth",
      block: "start",
    });
  });
});

window.addEventListener("scroll", (event) => {
  let fromTop = window.scrollY;
  productMenuList.classList.add("hello");

  productMenuItem.forEach((link) => {
    let section = document.querySelector(link.hash);

    if (
      section.offsetTop <= fromTop &&
      section.offsetTop + section.offsetHeight > fromTop
    ) {
      link.classList.add("current");
    } else {
      link.classList.remove("current");
    }
  });
});

let navbarToggler = document.getElementById("navbar_toggler");
