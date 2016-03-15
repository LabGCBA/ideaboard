ideaCache = [];
errors = false;
prompt = "Me gustaría...";
promptActive = "Me gustaría "
newIdeaTextarea = $("#new_idea .pure-input-3-4");

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
    var text = $.trim(newIdeaTextarea.val());

    if (ideaCache.indexOf(text) !== -1 || text.length === 0) {
        return false
    }
    else if (text === prompt || text === promptActive) {
        notifyError("No ingresaste ninguna idea!");
        return false;
    }
    else if (text.length < 20) {
        notifyError("No menos de 20 caracteres!");
        return false;
    }
    else if (text.length > 300) {
        notifyError("No más de 300 caracteres!");
        return false;
    }

    return true;
}

$(document).ready(function() {
    $("#new_idea .pure-button").click(function(e) {
        var text = $.trim(newIdeaTextarea.val());
        newIdeaTextarea.val(text);

        if (validate($('#new_idea'))) {
            autosize.update(newIdeaTextarea);
        }
        else {
            e.preventDefault();
        }
    });

    newIdeaTextarea.val(prompt);
    newIdeaTextarea.on("focus", function() {
        if ($(this).val() === prompt || $.trim($(this).val()).length === 0) {
            $(this).val(promptActive);
        }

        autosize(newIdeaTextarea);
        setCaretToPos($(this), $(this).length);
    });
    newIdeaTextarea.blur(function() {
        if ($(this).val() === promptActive || $.trim($(this).val()).length === 0) {
            $(this).val(prompt);
        };
    });

    autosize(newIdeaTextarea);
});

$(window).load(function() {
    var $grid = $('.ideas');

    $('.idea .content').boxfit({
        multiline: true,
        align_center: false
    });    

    $grid.isotope({
        itemSelector: '.idea',
        masonry: {
            isFitWidth: true,
            gutter: 30,
            resize: true,
        },
        getSortData: {
            votos: '.votos parseInt', // text from querySelector
        },
        //sortBy: 'votos',
        //sortAscending: false,
    });    
});