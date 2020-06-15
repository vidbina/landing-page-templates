let productMenuItem = document.querySelectorAll(
  ".product_list ul .product_menu_item a"
);
let productImageItem = document.querySelectorAll(
  ".product_area .product_img_list ul li a"
);

let productDetails = document.querySelectorAll(
  ".product_section .product_details"
);
let productMenuList = document.querySelector(".product_list ul");
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

  let manageCurrentState = (el) => {
    let section = document.querySelector(el.hash);

    if (
      section.offsetTop <= fromTop &&
      section.offsetTop + section.offsetHeight > fromTop
    ) {
      el.classList.add("current");
    } else {
      el.classList.remove("current");
    }
  };

  productMenuItem.forEach(manageCurrentState);
  productImageItem.forEach(manageCurrentState);
});

// let navbarToggler = document.getElementById('navbar_toggler');

// Navbar Link
// let overviewLink = document.querySelector('.overviewLink');
// let provisionLink = document.querySelector('.provisionLink');
// let secureLink = document.querySelector('.secureLink');
// let connectLink = document.querySelector('.connectLink');
// let runLink = document.querySelector('.runLink');

// // Section List
// let overview = document.getElementById('overview');
// let provision = document.getElementById('provision');
// let secure = document.getElementById('secure');
// let connect = document.getElementById('connect');
// let run = document.getElementById('run');

// let productSection = document.getElementsByClassName('product_section');

// let overviewOffset = overview.offsetTop;

// window.addEventListener('scroll', function () {
// 	let isTop = window.scrollY < 100;

// 	console.log(isTop);
// });
