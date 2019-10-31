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
           
            for (var i = 0; i < $scope.cartlist.length; i++)
            {
                if ($scope.cartlist[i].Id == cartitems.Id)
                {
                    $scope.cartlist[i].quantity = $scope.cartlist[i].quantity + 1;
                   
                }
            }


            //$scope.quantity=$scope.quantity+1
        }
        if (status == 'minus') {
           // $scope.quantity = $scope.quantity - 1
            if ($scope.cartlist.length != 0)
                for (var i = 0; i < $scope.cartlist.length; i++) {
                    if ($scope.cartlist[i].Id == cartitems.Id) {
                        var value = $scope.cartlist[i].quantity - 1
                        if (value == 0) {
                            $scope.deleteitem(cartitems);
                        }
                        else {
                            $scope.cartlist[i].quantity = $scope.cartlist[i].quantity - 1;
                            $scope.addcartlength = $scope.cartlist.length;
                        }

                        
                    
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

    $scope.saveorder = function (custinfo) {
        var item;
        $scope.orderlist = [];
        $scope.rlist = [];
        for(var i=0;i<$localStorage.addcart.length;i++){

            $scope.rlist[i] = {
                BookDescription :$localStorage.addcart[i].BookDescription,
                BookImage : $localStorage.addcart[i].BookImage,
                BookPrice : $localStorage.addcart[i].BookPrice,
                BookTitle : $localStorage.addcart[i].BookTitle,
                BookType : $localStorage.addcart[i].BookType,
                quantity : $localStorage.addcart[i].quantity,
                Id: $localStorage.addcart[i].Id,
                address: custinfo.address1,
                email: custinfo.email,
                landmark: custinfo.landmark,
                mobileno: custinfo.mobileno,
                name: custinfo.name,
                sname: custinfo.sname,
                zipcode: custinfo.zipcode

        };

        $scope.orderlist.push($scope.rlist[i]);
    }


       
        var req = {
            method: 'POST',
            url: '/api/Order/SaveOrder',
            data: $scope.orderlist
        }
        $http(req).then(function (res) {
          
            alert('order placed Successfully...!');
           

        }, function (ee) {
            alert(ee.data.ExceptionMessage);
            $scope.errmsg = ee;
        });
    
    }

});











