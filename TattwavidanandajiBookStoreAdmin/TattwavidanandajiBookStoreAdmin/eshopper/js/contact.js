/// <reference path="contact.js" />
var app = angular.module('myApp', ['ngStorage']);
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage) {
    if ($localStorage.addcart == null) {
        $localStorage.addcart = [];
    }
    else {
        $scope.addcartlength = $localStorage.addcart.length;
    }
    if ($localStorage.localshowotp != null) {
        $scope.showotp = $localStorage.localshowotp;
    }

    if ($localStorage.Username != null)
        $scope.disusername = $localStorage.Username;
   
    $scope.sendquery = function () {

        if ($scope.emailid == null) {

            alert("Please Enter Email Id");
            return;
        }
        if ($scope.messagedes == null) {

            alert("Please Enter Message Description");
            return;
        }

        var query = {
               Name:$scope.name,
               Email: $scope.emailid,
               Subject:$scope.subject, 
               MessageDes: $scope.messagedes,
               flag:'I'

        }

        var req = {
            method: 'POST',
            url: '/api/Customer/sendcustomerquery',
            data: query
        }
        $http(req).then(function (res) {
            alert('Your query sent and get the response very soon   ...');
            $scope.name = null;
            $scope.emailid = null;
            $scope.subject = null;
            $scope.messagedes = null;
        }, function (ee) {
            alert(ee.data.ExceptionMessage);
        });
    }

});