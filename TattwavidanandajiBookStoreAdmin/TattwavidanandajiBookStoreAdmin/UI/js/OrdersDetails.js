var app = angular.module('myApp', ['ngStorage', 'ui.bootstrap', 'angularFileUpload']);
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage, $interval, fileReader) {
    if ($localStorage.uname == null) {
        window.location.href = "BooksList.html";
    }
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
    $scope.getorderdetails = function () {
        var InitParams = parseLocation(window.location.search)['Id'];
        $http.get('/api/Order/GetOrderDetails?Id=' + InitParams).then(function (res, data) {
        $scope.Orderdetails = res.data;

    });
    }

  
    
   });










