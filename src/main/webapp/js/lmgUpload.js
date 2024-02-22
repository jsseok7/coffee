$(document).ready(function() {
    $("#beanImgFile").on('change', function() {
        var fileName = $(this).val().split('\\').pop();
        $(".beanImg-name").val(fileName || "대표이미지를 넣어주세요.");
    });

    $("#descriptFile").on('change', function() {
        var fileName = $(this).val().split('\\').pop();
        $(".descript-name").val(fileName || "상세설명 이미지를 넣어주세요.");
    });
});
