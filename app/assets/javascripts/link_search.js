/*
 *  The basic way this functions is by querying a search route every time the user updates the
 *  search bar and adding link-cards to a div in the form for the user to click.
 * 
 *  When the user selects a card, the linkable_id and linkable_type hidden fields get updated
 *  to the right values for the form to submit. When the user changes the type select it updates
 *  the linkable_type value and removes the value added to linkable_id.
 * 
 *  Any time linkable_id doesn't have a value, the submit button should be disabled.
 *  This keeps the user from submitting when the hidden fields don't reflect something they clicked
 *  on.
 */

$(document).on('turbolinks:load', function () {
    // whenever the user types in the search bar
    $(".link-search").on('input', () => {
        do_search();
    });

    // whenever the select changes
    $('#linkable-search-type').change(function() {
        // empty out the search bar, results div, and target div
        $('.link-search-results').empty();
        $('.link-search-form .link-current-target').empty();
        do_search(true);
        /////////////
        // IMPORTANT: REMOVING VALUES FROM HIDDEN FORM FIELDS
        /////////////
        $('.link-search-form #link_linkable_id').val('').trigger('change');     
        $('.link-search-form #link_linkable_type').val('');   
    });

    // when the user clicks a result card
    $('.link-search-results').on('click', '.link-card', function() {
        /////////////
        // IMPORTANT: SETTING VALUE FOR HIDDEN FORM FIELD
        /////////////
        $('.link-search-form #link_linkable_id').val($(this).attr('data-id')).trigger('change');
        // copy the selected card to the bottom after getting rid of the last one
        $('.link-search-form .link-current-target').empty();        
        $('.link-search-form .link-current-target').prepend($(this).clone());
    })

    // when the hidden ID field changes
    $('.link-search-form #link_linkable_id').change(function() {
        // make sure the submit button is disabled when its empty
        let val = $(this).val();
        if (val === '') $('.link-search-form input[type="submit"]').attr('disabled', 'disabled');
        else            $('.link-search-form input[type="submit"]').removeAttr('disabled');
    })
});

// query and fill the results div
function do_search(empty_query) {
    // grab the type from the select and the query
    let type = $('.link-search-form #linkable-search-type').val();
    let query = '';
    if (!empty_query) {
        query = $('.link-search').val();
    }

    // dont search for the default value
    if (type !== 'Type...') {
        // query the search controller
        $.getJSON('/search?type=' + type + '&q=' + query, (data) => {
            // empty out the results div
            $('.link-search-results').empty();
            /////////////
            // IMPORTANT: SETTING VALUE FOR HIDDEN FORM FIELD
            /////////////
            $('.link-search-form #link_linkable_type').val(data[0].type);

            // populate the search results div
            data.forEach(e => {
                let lower_type = data[0].type.substring(0, 1).toLowerCase() + data[0].type.substring(1, data[0].type.length);
                $('.link-search-results').append(card(lower_type, e.text, e.id));
            });
        });
    }
}

// create the html for the result link-cards
function card(type, text, id) {
    return "<div class=\"card link-card " + type + "-card\" data-id=\"" + id + "\"><div class=\"card-body\">" + text + "</div></div>"
}
