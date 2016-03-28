ideaCache = [];
errors = false;
prompt = "Me gustaría...";
promptActive = "Me gustaría "
newIdeaTextarea = $("#idea_texto");

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
    var tieneEtiqueta = false;

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

    $('.etiquetas-slider a').each(function() {
        if ($(this).hasClass("etiqueta-active")) tieneEtiqueta = true;
    });

    if (tieneEtiqueta) {
        tieneEtiqueta = false;
        return true;
    }
    else {
        notifyError("Debe elegir una etiqueta!");
        return false;
    }
}

function documentReadyEvents() {
    
        /////////////////////////////////////////////////////////////////////////////////////
    //  FILTERS
    /////////////////////////////////////////////////////////////////////////////////////

        $('.filtros .todas').click(function(e) {
            e.preventDefault();
            e.stopPropagation();
            $grid.isotope({ filter: '*' });
            return false; // Void the click
        });

        $('.filtros .mas-votadas').click(function(e) {
            e.preventDefault();
            e.stopPropagation();
            $grid.isotope({ sortBy : 'votos', sortAscending: false, });
            return false; // Void the click
        });

        $('.filtros .mas-nuevas').click(function(e) {
            e.preventDefault();
            e.stopPropagation();
            $grid.isotope({ sortBy : 'fecha', sortAscending: false, });
            return false; // Void the click
        });     

        $('.filtros .etiquetas li').click(function(e) {
            e.preventDefault();
            e.stopPropagation();
            return filterByTag(this, true);
        });

        $('.ideas .idea .tag').click(function(e) {
            e.preventDefault();
            e.stopPropagation();
            return filterByTag(this);
        });

    ///////////////////////////////////////////////////////////////////////////////////
   
    $('.ideas .idea .content').click(function(e) {
        e.preventDefault();

        uglipop({ class:'comments-modal',
            source:'div',
            content:'comments-modal',
        });

        $('.comments-modal').show();
        loadIdeaData($(this).parents('.idea'));
        
        return false;
    });   
    
    // Recalculate grid on browser resize
    $(window).bind('resize', function() {
        if ($('.boxfitted').length) {
            deFitIdeaText();
        }
        reFitIdeaText();
        $grid.isotope('updateSortData').isotope('layout');
    });
    
    // Idea submit button click
    $("#new_idea .pure-button").click(function(e) {
        var text = $.trim(newIdeaTextarea.val());
        newIdeaTextarea.val(text);

        if (validateForm($('#new_idea'))) {
            autosize.update(newIdeaTextarea);
            $('.etiquetas-slider a').removeClass('etiqueta-active');
            $('.etiquetas-slider-wrapper').removeClass('slideDown').addClass('slideUp');
        }
        else {
            e.preventDefault();
        }
    });
    
    // Placeholder manager
    newIdeaTextarea.focus(function() {
        if ($.trim($(this).val()) === prompt || $.trim($(this).val()).length === 0) {
            $(this).val(promptActive);
            $('.etiquetas-slider-wrapper').removeClass('slideUp').addClass('slideDown');
        }

        autosize(newIdeaTextarea);
        setCaretToPos($(this), $(this).length);
    });
    
    newIdeaTextarea.blur(function() {
        if (($.trim($(this).val()) + " ") === promptActive || $.trim($(this).val()).length === 0) {
            $(this).val(prompt);
            
            if ($('#idea_categoria').val() === '') {
                $('.etiquetas-slider-wrapper').removeClass('slideDown').addClass('slideUp');
            }
        };
        
        autosize(newIdeaTextarea);
    });
    
        $('#etiquetas-nav').click(function() {
        return false;
    });

    $('.etiquetas-slider a').click(function() {
        var categoria = $(this).attr('data-category');
        $('#new_idea').find('#idea_categoria').val(categoria);

        $(this).siblings().removeClass('etiqueta-active');
        $(this).addClass('etiqueta-active');
        newIdeaTextarea.focus();

        return false;
    });
}

$(document).ready(function() {
    documentReadyEvents();
    
    moment.locale('es');
    $('.etiquetas-slider-wrapper').addClass('slideUp');
    newIdeaTextarea.val(prompt);
    autosize(newIdeaTextarea);
});