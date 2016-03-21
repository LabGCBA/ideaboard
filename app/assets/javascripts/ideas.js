ideaCache = [];
errors = false;
prompt = "Me gustaría...";
promptActive = "Me gustaría "
newIdeaTextarea = $("#new_idea .pure-input-3-4");
$grid = $('.ideas');

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

function validateForm(form) {
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

function deFitIdeaText() {
    $('.idea .content .boxfitted').each(function() {
        $(this).replaceWith($(this).contents());
    });
    $('.idea .content').each(function() {
        $(this).css('display', '');
    });
}

function reFitIdeaText() {
    $(".idea .content").each(function() {
        $(this).boxfit({
            multiline: true,
            align_center: false,
        }); 
    });
}

function filterByTag(element, nav) {
    if (nav) {
        var filterValue = $(element).attr('data-filter');
    }
    else {
        var filterValue = $(element).parents('.idea').attr('data-filter');
    }
    
    $grid.isotope({ filter: filterValue });
    
    return false; // Void the click
}

function documentReadyEvents() {
    
    // Idea submit button click
    $("#new_idea .pure-button").click(function(e) {
        var text = $.trim(newIdeaTextarea.val());
        newIdeaTextarea.val(text);

        if (validateForm($('#new_idea'))) {
            autosize.update(newIdeaTextarea);
        }
        else {
            e.preventDefault();
        }
    });
    
    // Placeholder manager
    newIdeaTextarea.focus(function() {
        if ($.trim($(this).val()) === prompt || $.trim($(this).val()).length === 0) {
            $(this).val(promptActive);
        }

        autosize(newIdeaTextarea);
        setCaretToPos($(this), $(this).length);
    });
    
    newIdeaTextarea.blur(function() {
        if (($.trim($(this).val()) + " ") === promptActive || $.trim($(this).val()).length === 0) {
            $(this).val(prompt);
        };
        
        autosize(newIdeaTextarea);
    });

    /////////////////////////////////////////////////////////////////
    //  FILTERS
    /////////////////////////////////////////////////////////////////
        $('.filtros .todas').click(function(e) {
            $grid.isotope({ filter: '*' });
            return false; // Void the click
        });

        $('.filtros .mas-votadas').click(function(e) {
            $grid.isotope({ sortBy : 'votos' });
            return false; // Void the click
        });    

        $('.etiquetas a').click(function(e) {
            return filterByTag(this, true);
        });

        $('a.categoria').click(function(e) {
            return filterByTag(this);
        });

    ////////////////////////////////////////////////////////////////    

    $('#etiquetas-nav').click(function() {
        return false;
    });

    
    // Recalculate grid on browser resize
    $(window).bind('resize', function() {
        if ($('.boxfitted').length) {
            deFitIdeaText();
        }
        $grid.isotope('updateSortData').isotope('layout');
    });

    $grid.on('layoutComplete', function() {
        reFitIdeaText();
    });
}

$(document).ready(function() {
    documentReadyEvents();
    
    newIdeaTextarea.val(prompt);
    autosize(newIdeaTextarea);
});

$(window).bind('load', function() {
    $grid.isotope({
        itemSelector: '.idea',
        percentPosition: true,
        //layoutMode: 'packery',
        masonry: {
            gutter: '.gutter-sizer',
            columnWidth: '.idea',
            //resize: true,
        },
        getSortData: {
            votos: '.votos parseInt', // text from querySelector
        },
        //sortBy: 'votos',
        //sortAscending: false,
    }).isotope('layout');; 
});
