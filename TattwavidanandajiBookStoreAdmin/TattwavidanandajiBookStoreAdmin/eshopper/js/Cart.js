var app = angular.module('myApp', ['ngStorage']);
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage) {
    
    var r = $localStorage.addcart.length;
    $scope.addcartlength = r;
    $scope.cartlist = new Array();
    $scope.cartlist= $localStorage.addcart;
    $scope.quantity=1;
  
    $scope.setquantity = function (cartitems,status) {
        
        //alert(cartitems);
        if (status == 'plus') {
            $scope.quantity=$scope.quantity+1
        }
        if (status == 'minus') {
            $scope.quantity = $scope.quantity - 1
            if($scope.quantity==0)
                for (var i = 0; i < $scope.cartlist.length; i++) {
                    if ($scope.cartlist[i].Id==cartitems.Id) {
                        $scope.cartlist.splice(i, 1);
                        $scope.addcartlength = $scope.cartlist.length;
                    i--;
                }
            }

        }
       
    }
    $scope.deleteitem = function (itemposition) {
        
        var index =  $localStorage.addcart.indexOf(itemposition);
        $localStorage.addcart.splice(index, 1);
        $scope.cartlist = new Array();
        $scope.cartlist= $localStorage.addcart;
    
}
});











