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
        
        uglipop({class:'comments-modal',
            source:'div',
            content:'comments-modal'
        });
        
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
}

$(document).ready(function() {
    documentReadyEvents();
});

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
            fecha: function(element) {
                return Date.parse($(element).attr('data-date'));
            }
        },
        // sortBy: 'votos',
        // sortAscending: false,
    });
    
    reFitIdeaText();
    $grid.isotope('layout');
});
