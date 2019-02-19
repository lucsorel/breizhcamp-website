(function() {
    'use strict';

    angular.module('speakers', ['ngSanitize', 'hc.marked', 'ngLocale', 'ngAnimate', 'ui.bootstrap'])
        .controller('SpeakersCtrl', ['$scope', '$http', '$q', 'marked', '$window', function($scope, $http, $q, marked, $window) {

            var refresh = this.refresh = function() {
                // TODO
            };

            var http_speakers
                = (SPEAKER_CONFIG == null || SPEAKER_CONFIG.get_speakers_method === "static")
                ? $http.get('/json/speakers.json')
                : $http({
                        method: 'GET',
                        url: 'https://api.cfp.io/api/speakers',
                        headers: {
                            'X-Tenant-Id': 'breizhcamp'
                        }
                    });

            $q.all([
                $http.get('/json/speakers_others.json'),
                http_speakers
            ]).then(function(responses) {
                return [].concat(responses[0].data, responses[1].data);
            }).then(function(speakers) {
                _.forEach(speakers, function(n, key) {
                   n.social = _.without(n.social.split(', '), '')
                });
                speakers = _.sortBy(speakers, 'lastname');
                this.speakers = speakers;
            }.bind(this));
        }])
        .config(function($interpolateProvider) {
            $interpolateProvider.startSymbol('#{');
            $interpolateProvider.endSymbol('}#');
        });;
})();
