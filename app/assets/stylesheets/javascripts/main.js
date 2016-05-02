ideaCache = [];
errors = false;
prompt = "Me gustaría...";
promptActive = "Me gustaría "
newIdeaTextarea = $("#idea_texto");
newCommentTextarea = $("textarea").last();

function replaceSVGs() {
    /*
    * Replace all SVG images with inline SVG
    */
    $('img.svg').each(function(){
        var $img = $(this);
        var imgID = $img.attr('id');
        var imgClass = $img.attr('class');
        var imgURL = $img.attr('src');

        $.get(imgURL, function(data) {
            // Get the SVG tag, ignore the rest
            var $svg = $(data).find('svg');

            // Add replaced image's ID to the new SVG
            if(typeof imgID !== 'undefined') {
                $svg = $svg.attr('id', imgID);
            }
            // Add replaced image's classes to the new SVG
            if(typeof imgClass !== 'undefined') {
                $svg = $svg.attr('class', imgClass+' replaced-svg');
            }

            // Remove any invalid XML tags as per http://validator.w3.org
            $svg = $svg.removeAttr('xmlns:a');

            // Replace image with new SVG
            $img.replaceWith($svg);

        }, 'xml');

    });
}

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
            open: {height: 'toggle'}, // $ animate function property object
            close: {height: 'toggle'}, // $ animate function property object
            easing: 'swing', // easing
            speed: 500, // opening & closing animation speed
            type: 'error',
            killer: true,
        }
    });
    setTimeout(function(){ $.noty.closeAll() ; }, 1500);
}

function validateNewIdeaForm(form) {
    var text = $.trim(newIdeaTextarea.val());
    var tieneEtiqueta = false;

    if (ideaCache.indexOf(text) !== -1) {
        notifyError("Ya enviaste esa idea!")
        return false
    }
    else if (text === prompt || text === promptActive) {
        notifyError("No escribiste nada!")
        return false
    }
  
    $('.etiquetas-slider a').each(function() {
        if ($(this).hasClass("etiqueta-active")) tieneEtiqueta = true;
    });

    if (tieneEtiqueta) {
        tieneEtiqueta = false;
        return true;
    }
    else{
        $('#idea_categoria').val(0);
        return true;
        //notifyError("Debe elegir una etiqueta!");
        //return false;
    }
}

function validateNewCommentForm(form, textarea) {
    var text = $.trim(textarea.val());

    if (text === '') {
        notifyError("No escribiste nada!");
        return false;
    }
    else if (text.length < 20) {
        notifyError("No menos de 3 caracteres!");
        return false;
    }
    else if (text.length > 300) {
        notifyError("No más de 600 caracteres!");
        return false;
    }

    return true;
}

function recalculateGrid() {
    if ($('.boxfitted').length) {
        deFitIdeaText();
    }
    reFitIdeaText();
    $grid.isotope('updateSortData').isotope('layout');
}

function ideaClickHandler(element, e) {
    e.preventDefault();

    uglipop({ class:'comments-modal',
        source:'div',
        content:'comments-modal',
    });

    $('.comments-modal').show();
    //autosize(newComentarioTextarea);
    loadIdeaData($(element).parents('.idea'));
    
    return false;
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
            $grid.isotope({ sortBy: 'votos', sortAscending: false, });
            return false; // Void the click
        });

        $('.filtros .mas-nuevas').click(function(e) {
            e.preventDefault();
            e.stopPropagation();
            $grid.isotope({ sortBy: 'fecha', sortAscending: false, });
            return false; // Void the click
        });     

        $('.filtros li').click(function(e) {
            e.preventDefault();
            e.stopPropagation();
            return filterByTag(this, {nav: true, event: e});
        });

        $('.ideas .idea .tags a').click(function(e) {
            e.preventDefault();
            e.stopPropagation();
            return filterByTag(this, {event: e});
        });

    ///////////////////////////////////////////////////////////////////////////////////
   
    $('.ideas .idea').on("click", ".content", function(e) {
        ideaClickHandler(this, e);
    });   
    
    // Recalculate grid on browser resize
    $(window).bind('resize', function() {
        recalculateGrid();
    });
    
    // Idea submit button click
    $('#new_idea .new-idea-submit-button').click(function(e) {
        var text = $.trim(newIdeaTextarea.val());
        newIdeaTextarea.val(text);

        if (validateNewIdeaForm($('#new_idea'))) {
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
        }
        
        $('.etiquetas-slider-wrapper').removeClass('slideUp').addClass('slideDown');
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

    // replaceSVGs();
    moment.locale('es');
    $('.etiquetas-slider-wrapper').addClass('slideUp');
    newIdeaTextarea.val(prompt);
    autosize(newIdeaTextarea);
});