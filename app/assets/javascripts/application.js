// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require semantic_ui/semantic_ui

$(document).ready(function() {
    $("#center .item:first()").addClass("idea-active");

    $("#agregar-idea").click(function() {
        $('#new-idea').modal('show');
    });

    $(".editar-idea").click(function() {
        var text = $(this).parents(".content").find(".header").text();
        var textarea = $('#edit-idea').find('textarea');
        var id = $(this).attr("data-id");
        var url = '/ideas/' + id
        var form = $('#edit-idea').find("form");
        textarea.text(text);

        form.attr("action", url);

        $('#edit-idea').modal("setting", {
            onHidden: function() {
                textarea.text('');
            }
        }).modal('show');
    });

    $("#center .item .header").click(function() {
        if (!$(this).parents(".item").hasClass("idea-active")) {
            $(this).parents(".item").addClass("idea-active");
            $(this).parents(".item").siblings().removeClass("idea-active");
        }
    });    
});