var app = angular.module('myApp', ['ngStorage']);
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage) {

    var parseLocation = function (location) {
        var pairs = location.substring(1).split("&");
        var obj = {};
        var pair;
        var i;

        for (i in pairs) {
            if (pairs[i] === "") continue;

            pair = pairs[i].split("=");
            obj[decodeURIComponent(pair[0])] = decodeURIComponent(pair[1]);
        }

        return obj;
    };
    $scope.InitConfig = function () {
        var InitParams = parseLocation(window.location.search)['Id'];
        $http.get('/api/Books/GetBookListbyId?Id=' + InitParams).then(function (res, data) {
            $scope.bookdetails = res.data[0];
           
        });
    }
});