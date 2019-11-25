var app = angular.module('myApp', ['ngStorage']);
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage) {
    if ($localStorage.addcart == null) {
        $localStorage.addcart = [];
    }
    else {
        $scope.addcartlength = $localStorage.addcart.length;
    }
    if ($localStorage.userdata != null) {
        $scope.disusername = $localStorage.Username;
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
    
    $scope.InitConfig = function () {
        var InitParams = parseLocation(window.location.search)['Id'];
        $http.get('/api/Books/GetBookListbyId?Id=' + InitParams).then(function (res, data) {
            $scope.bookdetails = res.data[0];
            if ($localStorage.addcart != null || $localStorage.addcart.length != 0) {
                          
                        for (var j = 0; j < $localStorage.addcart.length; j++) {

                            if ($scope.bookdetails.Id == $localStorage.addcart[j].Id) {

                                $scope.bookdetails.quantity = $localStorage.addcart[j].quantity;
                                $scope.quantity = $localStorage.addcart[j].quantity;
                            }
                 

                }
            }
            if ($scope.bookdetails.quantity == null || $scope.bookdetails.quantity == 0) { 
                $scope.bookdetails.quantity = 1;
                $scope.quantity = 1;
            }
           
        });
    }
    $scope.addtocard = function (items) {
        var count = 0;
        items.flag = 1;
        items.quantity = $scope.quantity;
        
        if ($localStorage.addcart != null || $localStorage.addcart.length != 0) {

            for (var j = 0; j < $localStorage.addcart.length; j++) {

                if (items.Id == $localStorage.addcart[j].Id) {

                    $localStorage.addcart[j].quantity = $scope.quantity;
                    count = 1;
                }


            }
        }

        if (count == 0) {
            $localStorage.addcart.push(items)
        }
        $scope.addcartlength = $localStorage.addcart.length;
        //$localStorage.addcart.push(items)
    }

    //start  common in all screen 

    $scope.logout = function () {
        $localStorage.userdata = null;
        $localStorage.Username = null;
        $localStorage.disusername = null;
    }
    // end common in all screen
});