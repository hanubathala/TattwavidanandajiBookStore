var app = angular.module('myApp', ['ng-Storage', 'ui.bootstrap'])
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage, $uibModal) {

 
    $scope.GetFleettextData = function () {
        $scope.FleettextData = [{ "col1": "test", "col2": "test2" }, { "col1": "test", "col2": "test2" }, { "col1": "test", "col2": "test2" }, { "col1": "test", "col2": "test2" }]
        //get the data from database
        $http.get('').then(re, function () {
            $scope.FleettextData = res.data;
        })
       
    }

});
