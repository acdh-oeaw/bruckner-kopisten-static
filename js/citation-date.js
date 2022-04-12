$(function() {

    `
    replacing citation date of app build with current date
    in de and en format.

    `

    $('.citationDateDe').each(function() {
        let date = new Date();
        let options = { 
            weekday: 'long', 
            year: 'numeric',
            month: 'long', 
            day: 'numeric'
        };
        $(this).html(
            date.toLocaleDateString('de-DE', options)
        );
    });
    $('.citationDateEn').each(function() {
        let date = new Date();
        let options = { 
            weekday: 'long', 
            year: 'numeric',
            month: 'long', 
            day: 'numeric'
        };
        $(this).html(
            date.toLocaleDateString('en-EN', options)
        );
    });
});
