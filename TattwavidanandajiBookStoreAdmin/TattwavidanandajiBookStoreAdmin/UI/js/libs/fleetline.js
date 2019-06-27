var app = angular.module('myApp', []);
var ctrl = app.controller('myCtrl', function ($scope, $http) {
    $scope.getfleetline=function()
    {
        $http.get("http://localhost:1476/api/fleetline/getfleetlinedata").then(function (res, data) {
            $scope.companies = res.data;
        });

 
    // $scope.Fleetlinedatacompanies= function () {
    //$scope.Fleetlinedata = [{ "col1": "test", "col2": "test2" }, { "col1": "test", "col2": "test2" }, { "col1": "test", "col2": "test2" }, { "col1": "test", "col2": "test2" }]
    //get the data from database
    //   $http.get('http://localhost:1476/api/fleetlinedatacompanies').then(function (res, data) {
    //  $scope.companies = res.data;
}
       
    
});
