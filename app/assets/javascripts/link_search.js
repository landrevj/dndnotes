/*
 *  The basic way this functions is by querying a search route every time the user updates the
 *  search bar and adding link-cards to a div in the form for the user to click.
 * 
 *  When the user selects a card, the linked_note_id hidden field gets updated
 *  to the right value for the form to submit. When the user changes the type select it 
 *  removes the value added to linkable_id.
 * 
 *  Any time linkable_id doesn't have a value, the submit button should be disabled.
 *  This keeps the user from submitting when the hidden fields don't reflect something they clicked
 *  on.
 */

$(document).on('turbolinks:load', function () {
    // only act if the form exists
    if ($('.link-search-form').length) {
        // whenever the user types in the search bar
        $(".link-search").on('input', () => {
            do_search();
        });

        do_search(true);

        // whenever the select changes
        $('#linkable-search-type').change(function() {
            // empty out the search bar, results div, and target div
            $('.link-search-results').empty();
            $('.link-search-form .link-current-target').empty();
            do_search(true);
            /////////////
            // IMPORTANT: REMOVING VALUES FROM HIDDEN FORM FIELDS
            /////////////
            $('.link-search-form #link_linked_note_id').val('').trigger('change');
        });

        // when the user clicks a result card
        $('.link-search-results').on('click', '.link-card', function() {
            /////////////
            // IMPORTANT: SETTING VALUE FOR HIDDEN FORM FIELD
            /////////////
            $('.link-search-form #link_linked_note_id').val($(this).attr('data-id')).trigger('change');
            // copy the selected card to the bottom after getting rid of the last one
            $('.link-search-form .link-current-target').empty();        
            $('.link-search-form .link-current-target').prepend($(this).clone());
        })

        // when the hidden ID field changes
        $('.link-search-form #link_linked_note_id').change(function() {
            // make sure the submit button is disabled when its empty
            let val = $(this).val();
            if (val === '') $('.link-search-form input[type="submit"]').attr('disabled', 'disabled');
            else            $('.link-search-form input[type="submit"]').removeAttr('disabled');
        })
    }
});

// query and fill the results div
function do_search(empty_query) {
    // grab the type from the select and the query
    let category_id = $('.link-search-form #linkable-search-type').val();
    let query = '';
    if (!empty_query) {
        query = $('.link-search').val();
    }

    // query the search controller
    let search_path = '/search?category_id=' + category_id + '&q=' + query;
    $.getJSON(search_path, (data) => {
        // empty out the results div
        $('.link-search-results').empty();

        // populate the search results div
        let color = data.motif_color;
        data.notes.forEach(e => {
            $('.link-search-results').append( card(color, e.text, e.id) );
        });
    });
}

// create the html for the result link-cards
function card(color, text, id) {
    return "<div class=\"card link-card card-motif-" + color + "\" data-id=\"" + id + "\"><div class=\"card-body\">" + text + "</div></div>"
}
