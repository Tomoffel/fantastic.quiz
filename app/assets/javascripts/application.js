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

var ready = function() {
    // create function of select button in categories view. Add all selected options of unused question to used questions
    $('#btn_select').click(function(e) {
        var selectedOpts = $('#unused_questions option:selected');

        selectedOpts.each(function(index) {
            if (!containsId($(this).val(), $('#category_questions option'))) {
                $('#category_questions').append($(this).clone());
            }
        });

        e.preventDefault();
    });

    // create function of deselect button in categories view. remove all selected options of select.
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

    // if user click submit on categories view all used questions, user with full access and user with access to show are selected
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

    // show question at double click
    $( "#category_questions" ).dblclick(function() {
        if ($('#category_questions option:selected').val() != null) {
            openWindow("/questions/" + $('#category_questions option:selected').val());
        }
    });

    // show question at double click
    $( "#unused_questions" ).dblclick(function() {
        if ($('#unused_questions option:selected').val() != null) {
            openWindow("/questions/" + $('#unused_questions option:selected').val());
        }
    });

    // show category t double click
    $( "#question_id" ).dblclick(function() {
        if ($('#question_id option:selected').val() != null) {
            openWindow("/categories/" + $('#question_id option:selected').val());
        }
    });

    // change check button of quiz round if user change answer
    $( ".checked_radio").each(function() {
        $(this).click(function() {
            var link = $("#btn_check").attr("href")
            $("#btn_check").attr("href",  link.substr(0, link.length-1) + $(this).attr("value"))
        })
    })

    // create function of move to access to show button in categories view. Add all selected options of full access to access to show
    $('#from_list_with_full_access').click(function(e) {
        var selectedOpts = $('#list_with_full_access option:selected');

        selectedOpts.each(function(index) {
                $('#list_with_access_to_show').append($(this).clone());
        });

        $(selectedOpts).remove();
        e.preventDefault();
    });


    // create function of move to full access button in categories view. Add all selected options of access to show to full access
    $('#to_list_with_full_access').click(function(e) {
        var selectedOpts = $('#list_with_access_to_show option:selected');

        selectedOpts.each(function(index) {
            $('#list_with_full_access').append($(this).clone());
        });

        $(selectedOpts).remove();
        e.preventDefault();
    });

    // create function of move to access to show button in categories view. Add all selected options of without access to access to show
    $('#from_list_without_access').click(function(e) {
        var selectedOpts = $('#list_without_access option:selected');

        selectedOpts.each(function(index) {
            $('#list_with_access_to_show').append($(this).clone());
        });

        $(selectedOpts).remove();
        e.preventDefault();
    });

    // create function of move to without access button in categories view. Add all selected options of access to show to without access
    $('#to_list_without_access').click(function(e) {
        var selectedOpts = $('#list_with_access_to_show option:selected');

        selectedOpts.each(function(index) {
            $('#list_without_access').append($(this).clone());
        });

        $(selectedOpts).remove();
        e.preventDefault();
    });

    // create an overlay to delete a question
    if ($('#own_categories_to_delete') != null) {
        var overlay = $("#own_categories_to_delete")
        overlay.appendTo(document.body)
    }


};

function openWindow(address) {
    window.location.href = address
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