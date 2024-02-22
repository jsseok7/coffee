function changeIcon(event) {
    var iconElement = event.currentTarget.querySelector('i.fa-solid.fa-heart');
    if (iconElement) {
        iconElement.classList.remove('fa-heart');
        iconElement.classList.add('fa-heart-crack');
    }
}

function resetIcon(event) {
    var iconElement = event.currentTarget.querySelector('i.fa-solid.fa-heart-crack');
    if (iconElement) {
        iconElement.classList.remove('fa-heart-crack');
        iconElement.classList.add('fa-heart');
    }
}

var likeButtons = document.querySelectorAll('.likeButton');
if (likeButtons) {
    likeButtons.forEach(function (button) {
        button.addEventListener('mouseover', changeIcon);
        button.addEventListener('mouseout', resetIcon);
    });
}
