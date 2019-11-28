var app = angular.module('myApp', ['ngStorage', 'ui.bootstrap', 'angularFileUpload']);
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage, $interval, fileReader) {
    if ($localStorage.uname == null) {
        window.location.href = "BooksList.html";
    }
    $scope.uname = $localStorage.uname;
    $scope.userdetails = $localStorage.userdetails;
    $scope.Roleid = $localStorage.userdetails[0].RoleId;
    $scope.CanCreate = 0;
    $scope.selectedvalue ='5';      
    $scope.selectgoto = 1;
    $scope.ty = '-1';

    $scope.InitConfig = function () {
        
            var grpid = {
                status: 1,
            };

            var req = {
                method: 'POST',
                url: '/api/Types/TypesByGroupId',
                data: grpid
            }
            $http(req).then(function (res, data) {
                $scope.typedata = res.data.Table;
                $scope.getorderlist();
            },function (ee) {
                alert(ee.data.ExceptionMessage);
                $scope.errmsg = ee;
            });
    }
    $scope.getorderlist = function (flag) {

        var selecting = ($scope.selectedvalue == null) ? 10 : $scope.selectedvalue;
        if (flag == '' || flag == null) {
            $scope.page = ($scope.selectgoto == null || $scope.selectgoto == '') ? 1 : $scope.selectgoto;
        }
        if (flag == 'N') {

            $scope.page++;
            curpage = $scope.page;
            $scope.firstvalue = $scope.secondvalue;
            $scope.secondvalue = curpage * selecting;
            $scope.selectgoto = curpage;
        } else if (flag == 'P') {
            $scope.page--
            curpage = $scope.page;
            $scope.secondvalue = $scope.firstvalue;
            $scope.firstvalue = ($scope.firstvalue - selecting);
            if ($scope.firstvalue == 0) {
                $scope.firstvalue = 1;
            }
            $scope.selectgoto = curpage;
        }
        else {
            $scope.page;
            curpage = $scope.page;
            if ($scope.selectgoto > 1) {

                $scope.secondvalue = curpage * selecting;
                $scope.firstvalue = ($scope.secondvalue - selecting);
            }
            else {
                $scope.selectgoto = 1;
                $scope.firstvalue = 1
                $scope.secondvalue = selecting;
            }
        }
        $http.get('/api/Order/GetOrders?curpage=' + curpage + '&maxrows=' + selecting).then(function (res, data) {
            $scope.OrderList = res.data.Table;
            $scope.paggin = res.data.Table1;
            if ($scope.OrderList.length < selecting) {
                $scope.secondvalue = $scope.secondvalue - (selecting - $scope.OrderList.length);

            }
            var result = [];
            for (var i = 1; i <= $scope.paggin[0].totalpages; i++) {
                result.push(i);
            }
            $scope.jumptotalpages = result;
            
        });


    }
    
   });










