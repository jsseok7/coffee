document.addEventListener("DOMContentLoaded", function () {
 var typeButtons = document.querySelectorAll(
  ".productList__sortRecent, .productList__sortLike, .productList__sortBest"
 );

 typeButtons.forEach(function (button) {
  button.addEventListener("click", function () {
   var isActive = button.classList.contains("productActive");
   typeButtons.forEach(function (btn) {
    btn.classList.remove("productActive");
   });
   if (!isActive) {
    button.classList.add("productActive");
   }
  });
 });
});






