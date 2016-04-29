$grid = $('.ideas');

function deFitIdeaText() {
    $('.ideas .idea .content .boxfitted').each(function() {
        $(this).replaceWith($(this).contents());
    });
    $('.ideas .idea .content').each(function() {
        $(this).css('display', '');
    });
}

function reFitIdeaText() {
    $(".ideas .idea .content").each(function() {
        $(this).boxfit({
            multiline: true,
            align_center: false,
        }); 
    });
}

function filterByTag(element, options) {
    if (options.nav) {
        var filterValue = $(element).attr('data-filter');
    }
    else {
        var filterValue = "." + options.event.target.innerText;
    }
    
    $grid.isotope({ filter: filterValue });
    
    return false; // Void the click
}

function loadIdeaData(idea) {
    var idea_id = $(idea).attr('id').split("_").pop();   
    var categoria = idea.find('.tags .categoria').text();
    var etapa = idea.find('.tags .etapa').text();
    var content = idea.find('.content').text();
    var nombre = idea.find('.metadata .nombre').text();
    var area = idea.find('.metadata .area').text();
    var votos = idea.find('.actionables .votos').text();
    var urlEstados = $(location).attr('href') + "/ideas/" + idea_id + "/estados";
    var urlComentarios = $(location).attr('href') + "/ideas/" + idea_id + "/comentarios";

    $('.comments-modal .tags .categoria').text(categoria);
    $('.comments-modal .tags .etapa').text(etapa);
    $('.comments-modal .content').text(content);
    $('.comments-modal .metadata .nombre').text(nombre);
    $('.comments-modal .metadata .area').text(area);
    $('.comments-modal .actionables .votos').text(votos);
    $('.comments-modal #new_comentario').find('#comentario_idea_id').val(idea_id);

    //getEstados(urlEstados);
    getComentarios(urlComentarios);
}

function getEstados(url) {
    $.ajax({
        type:"GET",
        url: url,
        dataType: "json",
        success: function(result) {
            showEstados(result);
        },
        error: function(xhr, error) {
            console.log(error);
            console.log(xhr);
        },
    });
}

function showEstados(result) {
    if (result.length > 0) {
        var lastItem = result.pop();
        var currentHeader =  $('.comments-modal .estado > .header').text();
        var texto = lastItem.texto;
        var fecha = moment(lastItem.created_at).fromNow();
        var nombre = lastItem.persona.nombre;
        
        $('.comments-modal .estado > .header').text(currentHeader + ' - ' + fecha);
        $('.comments-modal .estado > .texto').text(texto);
        $('.comments-modal .estado > .nombre').text(nombre);
    }
}

function getComentarios(url) {
    $('.comentarios-wrapper').empty();

    $.ajax({
        type:"GET",
        url: url,
        dataType: "script",
        error: function(xhr, error) {
           console.log(error);
            console.log(xhr);
        },
    });
}

$(window).bind('load', function() {
    $grid.isotope({
        itemSelector: '.idea',
        percentPosition: true,
        transitionDuration: '0.3s',
        // isInitLayout: false,
        // layoutMode: 'packery',
        masonry: {
            gutter: '.gutter-sizer',
            columnWidth: '.idea',
            // resize: true,
        },
        getSortData: {
            votos: '.votos parseInt', // text from querySelector
            fecha: function (element) {
                return Date.parse($(element).attr('data-date'));
            }
        },
        // sortBy: 'votos',
        // sortAscending: false,
    });
    
    reFitIdeaText();
});