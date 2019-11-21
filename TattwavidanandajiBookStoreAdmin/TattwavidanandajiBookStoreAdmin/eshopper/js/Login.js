var app = angular.module('myApp', ['ngStorage']);
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage) {
    if ($localStorage.addcart == null) {
        $localStorage.addcart = [];
    }
    else {
        $scope.addcartlength = $localStorage.addcart.length;
    }

    if ($localStorage.Username!=null)
    $scope.disusername = $localStorage.Username;

    $scope.savecustomerdetails = function () {

        if ($scope.username == null || $scope.username == '')
        {
            alert("Enter Username");
            return;
        }
        if ($scope.userpassword == null) {
            alert("Enter Password");
            return;
        }
        if ($scope.userconfpasswod == null) {
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
          
            $localStorage.useremail = res.data[0].Email;
            alert('Sign Up Successfully...!');
        }, function (ee) {
            alert(ee.data.ExceptionMessage);
            $scope.errmsg = ee;
        });
    
    }
    //String Email, String Emailotp
    $scope.eotpverification = function (f) {
        $http.get('/api/Customer/eotpverification?Email=' + $localStorage.useremail + '&Emailotp=' + $scope.UserEmailOTP).then(function (res, data) {
            $localStorage.userdata = res.data;
            $localStorage.Username = res.data[0].UserName;
            $scope.disusername = $localStorage.Username;
           
        }, function (ee) {
            alert(ee.data.ExceptionMessage);
        });
    }

    $scope.loginverification = function () {

        if ($scope.loginemail == null) {
            alert('Please Enter Email Id..');
            return;
        }
        if ($scope.loginpasword == null) {
            alert('Please Enter Password..');
            return;
        }

        var e = {
            LoginInfo: $scope.loginemail,
            Passkey : $scope.loginpasword,

        }

        var req = {
            method: 'POST',
            url: '/api/LOGIN/CustomerLogin',
            data: e
        }

        $http(req).then(function (res) {
            $localStorage.userdata = res.data;
            $localStorage.Username = res.data[0].UserName;
            $scope.disusername = $localStorage.Username;

        }, function (ee) {
            alert(ee.data.ExceptionMessage);
        });
    }


    $scope.LogoutUser = function () {
        $localStorage.disusername = null;
        $scope.disusername = null;
        $localStorage.Username = null;        
    }
});











