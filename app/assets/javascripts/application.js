// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

//todo in correct file
var ready = function() {
    $('#btn_select').click(function(e) {
        var selectedOpts = $('#unused_questions option:selected');

        selectedOpts.each(function(index) {
            if (!containsId($(this).val(), $('#category_questions option'))) {
                $('#category_questions').append($(this).clone());
            }
        });

        e.preventDefault();
    });

    $('#btn_deselect').click(function(e) {
        var selectedOpts = $('#category_questions option:selected');

        selectedOpts.each(function(index) {
            if (!containsId($(this).val(), $('#unused_questions option'))) {
                $('#unused_questions optgroup').get(0).innerHTML += "<option value='" + $(this).val()  + "'>" + $(this).html() + "</option>"
            }
        });
        $(selectedOpts).remove();
        e.preventDefault();
    });

    $('#btn_submit').click(function(e) {
        $('#category_questions option').each(function(index) {
            $(this).attr("selected", "selected")
        });
    });

    $( "#category_questions" ).dblclick(function() {
        openWindow("/questions/" + $('#category_questions option:selected').val());
    });

    $( "#unused_questions" ).dblclick(function() {
        openWindow("/questions/" + $('#unused_questions option:selected').val());
    });
};

function openWindow(address) {
    questionWindow = window.open(address, "_blank");
    questionWindow.focus();
}

function containsId(id, listbox) {
    var r = false
    listbox.each(function(index){
        if($(this).val() == id) {
            r = true
        }
    });
    return r
}

$(document).ready(ready);
$(document).on('page:load', ready);