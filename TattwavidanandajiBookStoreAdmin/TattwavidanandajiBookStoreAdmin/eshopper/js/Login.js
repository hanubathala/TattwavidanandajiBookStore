var app = angular.module('myApp', ['ngStorage']);
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage) {
    

   

    $scope.savecustomerdetails = function () {

        if ($scope.username != null || $scope.username != '')
        {
            alert("Enter Username");
            return;
        }
        if ($scope.userpassword != null) {
            alert("Enter Password");
            return;
        }
        if ($scope.userconfpasswod != null) {
            alert("Enter Confirm Password");
            return;
        }
        if ($scope.userpassword != $scope.userconfpasswod) {
            alert("Enter Passwords are not matched");
            return;
        }
        var custdetails = {
            Username:$scope.username,
            Password: $scope.userpassword,
            Email: $scope.UserEmail,
            flag:'I'
        }


       
        var req = {
            method: 'POST',
            url: '/api/Customer/SaveCustomerDetails',
            data: custdetails
        }
        $http(req).then(function (res) {
          
            alert('Sign Up Successfully...!');
        }, function (ee) {
            alert(ee.data.ExceptionMessage);
            $scope.errmsg = ee;
        });
    
    }

});











