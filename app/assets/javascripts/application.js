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
        $('#list_with_full_access option').each(function(index) {
            $(this).attr("selected", "selected")
        });
        $('#list_with_access_to_show option').each(function(index) {
            $(this).attr("selected", "selected")
        });
    });

    $( "#category_questions" ).dblclick(function() {
        if ($('#category_questions option:selected').val() != null) {
            openWindow("/questions/" + $('#category_questions option:selected').val());
        }
    });

    $( "#unused_questions" ).dblclick(function() {
        if ($('#unused_questions option:selected').val() != null) {
            openWindow("/questions/" + $('#unused_questions option:selected').val());
        }
    });

    $( ".checked_radio").each(function() {
        $(this).click(function() {
            var link = $("#btn_check").attr("href")
            $("#btn_check").attr("href",  link.substr(0, link.length-1) + $(this).attr("value"))
        })
    })


    $("#btn_check").click(function(){
       // alert("test");
        $("#quiz_rounds_answer_container").addClass("not_hover");
    });

    //hide js_notice
    $("#js_notice").hide();

    //function to check question with div
    $(".answer_container").click(function (e) {
        $(this).children(":first").prop("checked", true)   });

    $('#from_list_with_full_access').click(function(e) {
        var selectedOpts = $('#list_with_full_access option:selected');

        selectedOpts.each(function(index) {
                $('#list_with_access_to_show').append($(this).clone());
        });

        $(selectedOpts).remove();
        e.preventDefault();
    });


    $('#to_list_with_full_access').click(function(e) {
        var selectedOpts = $('#list_with_access_to_show option:selected');

        selectedOpts.each(function(index) {
            $('#list_with_full_access').append($(this).clone());
        });

        $(selectedOpts).remove();
        e.preventDefault();
    });


    $('#from_list_without_access').click(function(e) {
        var selectedOpts = $('#list_without_access option:selected');

        selectedOpts.each(function(index) {
            $('#list_with_access_to_show').append($(this).clone());
        });

        $(selectedOpts).remove();
        e.preventDefault();
    });


    $('#to_list_without_access').click(function(e) {
        var selectedOpts = $('#list_with_access_to_show option:selected');

        selectedOpts.each(function(index) {
            $('#list_without_access').append($(this).clone());
        });

        $(selectedOpts).remove();
        e.preventDefault();
    });

    if ($('#own_categories_to_delete') != null) {
        var overlay = $("#own_categories_to_delete")
        overlay.appendTo(document.body)
    }


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