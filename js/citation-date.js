$(function() {
    $('.citationDateDe').each(function() {
        let date = new Date();
        let options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        $(this).html(date.toLocaleDateString('de-DE', options));
    });
});

$(function() {
    $('.citationDateEn').each(function() {
        let date = new Date();
        let options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        $(this).html(date.toLocaleDateString('en-EN', options));
    });
});
