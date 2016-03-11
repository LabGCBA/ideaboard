ideaCache = [];
errors = false;
prompt = "Me gustaría...";
promptActive = "Me gustaría "

$(document).ready(function() {
    $("#new_idea .pure-button").click(function(e) {
        if (ideaCache.indexOf($(".pure-input-3-4").val()) !== -1 || $(".pure-input-3-4").val() === prompt) {
            e.preventDefault();
        }
    });

    $("#new_idea .pure-input-3-4").val(prompt);
    $("#new_idea .pure-input-3-4").on("focus", function() {
        if ($(this).val() === prompt || $("#new_idea").valid()) {
            $(this).val(promptActive);
        }
    });
    $("#new_idea .pure-input-3-4").blur(function() {
        if ($(this).val() === promptActive) {
            $(this).val(prompt);
        };
    });
    
    $("#new_idea").validate({
        rules: {
            "idea[texto]": {
                required: true,
                minlength: 20,
                maxlength: 300,
            }
        },
        messages: {
            "idea[texto]": {
                minlength: $.validator.format("No menos de {0} letras!"),
                maxlength: $.validator.format("No más de {0} letras!"),
            }
        },
        showErrors: function(errorMap, errorList) {
            if ($("#new_idea .pure-input-3-4").val() !== promptActive) {
                noty({
                text: errorList[0].message,
                animation: {
                    open: {height: 'toggle'}, // jQuery animate function property object
                    close: {height: 'toggle'}, // jQuery animate function property object
                    easing: 'swing', // easing
                    speed: 500, // opening & closing animation speed
                    killer: true,
                    type: 'error',
                }
            });
            setTimeout(function(){ $.noty.closeAll() ; }, 1500);
            }
        },
        submitHandler: function(form) {
            $.rails.handleRemote($(form));
        },
    });

    autosize($('.pure-form .pure-input-3-4'));
});

$(window).load(function() {
    var $grid = $('.ideas');

    $('.idea .content').boxfit({
        multiline: true,
        align_center: false
    });    

    $grid.masonry({
        itemSelector: '.idea',
        isFitWidth: true,
        gutter: 20,
        resize: true,
    });    
});