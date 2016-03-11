ideaCache = [];
errors = false;
prompt = "Me gustaría...";
promptActive = "Me gustaría "

function setSelectionRange(input, selectionStart, selectionEnd) {
    if (input.setSelectionRange) {
        input.focus();
        input.setSelectionRange(selectionStart, selectionEnd);
    }
    else if (input.createTextRange) {
        var range = input.createTextRange();
        range.collapse(true);
        range.moveEnd('character', selectionEnd);
        range.moveStart('character', selectionStart);
        range.select();
    }
}

function setCaretToPos (input, pos) {
  setSelectionRange(input, pos, pos);
}

function notifyError(message) {
    noty({
        text: message,
        animation: {
            open: {height: 'toggle'}, // jQuery animate function property object
            close: {height: 'toggle'}, // jQuery animate function property object
            easing: 'swing', // easing
            speed: 500, // opening & closing animation speed
            type: 'error',
            killer: true,
        }
    });
    setTimeout(function(){ $.noty.closeAll() ; }, 1500);
}

function validate(form) {
    var text = $.trim(form.find(".pure-input-3-4").val());

    if (ideaCache.indexOf(text) !== -1 || text === prompt || text === promptActive || text.length === 0) {
        return false
    }
    else if (text.length < 20) {
        notifyError("No menos de 20 letras!");
        return false;
    }
    else if (text.length > 300) {
        notifyError("No más de 300 letras!");
        return false;
    }

    return true;
}

$(document).ready(function() {
    $.validator.setDefaults({ 
        debug: true,
        onkeyup: false,
        onclick: false,
        onfocusout: false,
        focusCleanup: true,
    });

    $("#new_idea .pure-button").click(function(e) {
        var text = $.trim($("#new_idea .pure-input-3-4").val());
        $("#new_idea .pure-input-3-4").val(text);

        if (validate($('#new_idea'))) {
            autosize($('.pure-form .pure-input-3-4'));
        }
        else {
            e.preventDefault();
        }
    });

    $("#new_idea .pure-input-3-4").on("focusout keyup", function(e){ e.stopPropagation(); });   
    $("#new_idea .pure-input-3-4").val(prompt);
    $("#new_idea .pure-input-3-4").on("focus", function() {
        if ($(this).val() === prompt || $("#new_idea").valid()) {
            $(this).val(promptActive);
        }
        setCaretToPos($(this), $(this).length);
    });
    $("#new_idea .pure-input-3-4").blur(function() {
        if ($(this).val() === promptActive) {
            $(this).val(prompt);
        };
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