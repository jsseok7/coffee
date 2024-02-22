document.addEventListener("DOMContentLoaded", function () {
 var typeButtons = document.querySelectorAll(
  ".myPageNav__button, .myPageNav__button, .myPageNav__button"
 );

 typeButtons.forEach(function (button) {
  button.addEventListener("click", function () {
   var isActive = button.classList.contains("active");
   typeButtons.forEach(function (btn) {
    btn.classList.remove("active");
   });
   if (!isActive) {
    button.classList.add("active");
   }
  });
 });
});


