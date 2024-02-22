function changeIcon() {
    var iconElement = document.querySelector('.productListDetailDetail__likeButton .myPageLike__button i.fa-solid.fa-heart');
    if (iconElement) {
        iconElement.classList.remove('fa-heart');
        iconElement.classList.add('fa-heart-crack');
    }
}


function resetIcon() {
    var iconElement = document.querySelector('.productListDetailDetail__likeButton .myPageLike__button i.fa-solid.fa-heart-crack');
    if (iconElement) {
        iconElement.classList.remove('fa-heart-crack');
        iconElement.classList.add('fa-heart');
    }
}

var likeButton = document.getElementById('likeButton');
if (likeButton) {
    likeButton.addEventListener('mouseover', changeIcon);
    likeButton.addEventListener('mouseout', resetIcon);
}