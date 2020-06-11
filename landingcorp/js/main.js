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

  productMenuItem.forEach((link) => {
    let section = document.querySelector(link.hash);
    console.log(section.offsetTop);
    if (
      section.offsetTop <= fromTop &&
      section.offsetTop + section.offsetHeight > fromTop
    ) {
      link.classList.add("current");
    } else {
      link.classList.remove("current");
    }
  });

  productImageItem.forEach((links) => {
    let section = document.querySelector(links.hash);

    if (
      section.offsetTop <= fromTop &&
      section.offsetTop + section.offsetHeight > fromTop
    ) {
      links.classList.add("active");
    } else {
      links.classList.remove("active");
    }
  });
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
