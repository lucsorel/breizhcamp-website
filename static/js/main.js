(function(document, window, $) {
    document.addEventListener('DOMContentLoaded', function() {
        var pathname = window.location.pathname;
        var levels = pathname.split(/\//).filter(function(part) {
            return part;
        });
        var links = levels.reduce(function(links, part, index) { // each path part corresponds to a sub-menu
            var result;
            if (index === 0) {
                result = '/' + part + '/';
            } else {
                result = links[index - 1] + part + '/';
            }
            links.push(result);
            return links;
        }, []);
        links.forEach(function(link) {
            $('.nav > li > a[href="' + link + '"]').parent().addClass('active');
        });
    });
})(document, window, $);


function languageTroll() {
    const languages = ['.Net', 'C', 'C++', 'C#', 'Go', 'Java', 'JavaScript', 'Objective-C', 'Perl', 'PHP', 'Python', 'R', 'Ruby', 'Rust', 'Swift'];
    var index = Math.floor(Math.random() * Math.floor(languages.length));
    jQuery('.language-troll').text(languages[index]);
}
