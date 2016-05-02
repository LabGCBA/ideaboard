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
    var ideaId = $(idea).attr('id').split("_").pop();   
    var categoria = idea.find('.tags .categoria').text();
    
    var etapa = idea.find('.tags .etapa').text();
    var etapaId = idea.find('.tags .etapa').attr('class').split(' ').pop().split('').pop();
    var selectorEtapa = '.comments-modal .tags .etapa-' + etapaId;
    var updateEtapaURL = $(location).attr('href') + '/ideas/' + ideaId + '/etapa/';
    
    var content = idea.find('.content').text();
    var nombre = idea.find('.metadata .nombre').text();
    var area = idea.find('.metadata .area').text();
    var votos = idea.find('.actionables .votos').text();
    var urlEstados = $(location).attr('href') + "/ideas/" + ideaId + "/estados";
    var urlComentarios = $(location).attr('href') + "/ideas/" + ideaId + "/comentarios";

    $('.comments-modal .tags .categoria').text(categoria);
    $('.comments-modal .tags .etapa').text(etapa);
    
    if (etapaId) $(selectorEtapa).addClass("activa");
    
    $('.comments-modal .content').text(content);
    $('.comments-modal .metadata .nombre').text(nombre);
    $('.comments-modal .metadata .area').text(area);
    $('.comments-modal .actionables .votos').text(votos);
    $('.comments-modal #new_comentario #comentario_idea_id').val(ideaId);

    console.log(ideaId);
    
    $('.comments-modal .tags .etapa a').click(function (e) {
        if ($(this).closest('.etapa').hasClass('activa')) { 
            e.preventDefault();
            return false;
        };            

        var nuevaEtapaId = $(this).closest('.etapa').attr('class').split(' ').pop().split('').pop();
        
        $.post({ // TODO: Make PATCH
            url: updateEtapaURL + nuevaEtapaId,
            success: function () {
                var selectorNuevaEtapa = '.comments-modal .tags .etapa-' + nuevaEtapaId + ' a';
                var antiguaEtapa = $('.comments-modal .tags .etapa.activa');
                var claseAntiguaEtapa = "etapa-" + etapaId;
                var claseNuevaEtapa = "etapa-" + nuevaEtapaId
                var textoNuevaEtapa = $(selectorNuevaEtapa).text();

                antiguaEtapa.removeClass('activa');
                $(selectorNuevaEtapa).addClass("activa");
                
                idea.find('.tags .etapa').text(textoNuevaEtapa);
                idea.find('.tags .etapa').removeClass(claseAntiguaEtapa);
                idea.find('.tags .etapa').addClass(claseNuevaEtapa);
            }
        });

        e.preventDefault();
        return false;
    });

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