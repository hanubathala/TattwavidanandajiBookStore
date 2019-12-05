var app = angular.module('myApp', ['ngStorage']);
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage) {
    

    var r = $localStorage.addcart.length;
    $scope.addcartlength = r;
    $scope.cartlist = new Array();
    $scope.countt = 0;
    $scope.cartlist = $localStorage.addcart;
    if ($scope.cartlist.length != 0) {
        $scope.totalamt = 0;
        for (var i = 0; i < $scope.cartlist.length; i++) {
            $scope.totalamt = $scope.totalamt + ($scope.cartlist[i].quantity * $scope.cartlist[i].BookPrice);
        }
    }
    if ($localStorage.userdata != null) {
        $scope.disusername = $localStorage.Username;
    }
    $http.get('/api/Order/GetCustomerOrder?Id=' + $localStorage.userdata[0].Id).then(function (res, data) {
        $scope.orders = res.data;
       
    });
   
});











