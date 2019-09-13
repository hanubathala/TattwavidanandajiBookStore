var app = angular.module('myApp', ['ngStorage']);
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage) {
    
    var r = $localStorage.addcart.length;
    $scope.addcartlength = r;
    $scope.cartlist = new Array();
    $scope.cartlist= $localStorage.addcart;
    $scope.quantity=1;
  
    $scope.setquantity = function (items) {
        
        if(items==1){
            $scope.quantity=$scope.quantity+1
        }
        if(items==0){
            $scope.quantity=$scope.quantity-1
        }
       
    }
    $scope.deleteitem = function (itemposition) {
        
        var index =  $localStorage.addcart.indexOf(itemposition);
        $localStorage.addcart.splice(index, 1);
        $scope.cartlist = new Array();
        $scope.cartlist= $localStorage.addcart;
    
}
});











