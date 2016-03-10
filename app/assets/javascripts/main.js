$(document).ready(function() {
    $(".pure-input-3-4").val("Me gustaría...");

    $('.ideas').masonry({
        itemSelector: '.idea',
        isFitWidth: true,
        gutter: 20,
        resize: true,
    });

    $('.content').boxfit({
        multiline: true,
        align_center: false
    });
});