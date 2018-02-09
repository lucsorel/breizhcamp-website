const LANGUAGE_TROLL = (function () {
    const LANGUAGE = [
        '.Net',
        'C',
        'C++',
        'C#',
        'Groovy',
        'Go',
        'Java',
        'JavaScript',
        'Kotlin',
        'Objective-C',
        'Perl',
        'PHP',
        'Python',
        'R',
        'Ruby',
        'Rust',
        'Scala',
        'Swift'
    ];


    var languages_shuffle = LANGUAGE.map(function (val, i) { return i });
    var current_language_index = -1;  // laisser -1 pour que le shuffle se déclanche au prochain tour


    function shuffle() {
        // Fisher–Yates shuffle
        var i, j, temp;
        for (i = LANGUAGE.length - 1; i > 0; i--) {
            j = Math.floor(Math.random() * i);
            temp = languages_shuffle[i];
            languages_shuffle[i] = languages_shuffle[j];
            languages_shuffle[j] = temp;
        }
    }


    function next() {
        current_language_index = ++current_language_index % LANGUAGE.length;
        if (current_language_index <= 0) {
            shuffle();
        }
        return LANGUAGE[languages_shuffle[current_language_index]];
    }


    return {
        "next": next
    }
})();
