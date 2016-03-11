ideaCache = [];
prompt = "Me gustaría...";
promptActive = "Me gustaría "

$(document).ready(function() {
    $("#new_idea .pure-input-3-4").val(prompt);
    $("#new_idea .pure-input-3-4").on("focus", function() {
        $(this).val(promptActive);
    });
    $("#new_idea .pure-input-3-4").blur(function() {
        if ($(this).val() === promptActive) {
            $(this).val(prompt);
        };
    });

    $('.content').boxfit({
        multiline: true,
        align_center: false
    });

    $('.ideas').masonry({
        itemSelector: '.idea',
        isFitWidth: true,
        gutter: 20,
        resize: true,
    });
    

    $("#new_idea .pure-button").click(function(e) {
        if (ideaCache.indexOf($(".pure-input-3-4").val()) !== -1 || $(".pure-input-3-4").val() === prompt) {
            e.preventDefault();
        }
    });
    
    $("#new_idea").validate({
        rules:{
            "idea[texto]": {
                required: true,
                minlength: 20,
            }
        },
        showErrors: function(errorMap, errorList) {
            // Avoid showing errors
        },
        submitHandler: function(form){
            $.rails.handleRemote($(form));
        }
    })  
});