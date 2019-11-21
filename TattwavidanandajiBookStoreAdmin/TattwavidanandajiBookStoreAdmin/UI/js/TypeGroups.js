var app = angular.module('myApp', ['ngStorage', 'ui.bootstrap', 'angularFileUpload']);


var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage) {
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

   
    $scope.getcustomerlist = function (flag) {

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
        $http.get('/api/TypeGroups/gettypegroups?curpage=' + curpage + '&maxrows=' + selecting).then(function (res, data) {
            $scope.TypeGroups = res.data.Table;
            $scope.paggin = res.data.Table1;
            if ($scope.TypeGroups.length < selecting) {
                $scope.secondvalue = $scope.secondvalue - (selecting - $scope.TypeGroups.length);

            }
            var result = [];
            for (var i = 1; i <= $scope.paggin[0].totalpages; i++) {
                result.push(i);
            }
            $scope.jumptotalpages = result;
        });
    }
    $scope.saveNew = function (TypeGroups1) {

        if (TypeGroups1 == null) {
            alert('Please enter name.');
            return;
        }

        if (TypeGroups1.Name == null) {
            alert('Please enter name.');
            return;
        }

        var SelTypeGroup = {
            Name: TypeGroups1.Name,
            Description: TypeGroups1.Description,
            Active: TypeGroups1.Active,
            Id: -1,
            insupddelflag: 'I'
        };

        var req = {
            method: 'POST',
            url: '/api/typegroups/savetypegroups',
            data: SelTypeGroup
        }
        $http(req).then(function (response) {
            $scope.getcustomerlist();
            $scope.tGroup = null;

        }, function (errres) {
            var errdata = errres.data;
            var errmssg = "";
            errmssg = (errdata && errdata.ExceptionMessage) ? errdata.ExceptionMessage : errdata.Message;
            alert(errmssg);
            $scope.getcustomerlist();
            $scope.tGroup = null;
        });

    };
    
    $scope.setdata = function (data) {
        $scope.edittgroup = data;
        $scope.edittgroup.editname = data.Name;
        $scope.edittgroup.editdes = data.Description;
        $scope.edittgroup.editActive = data.Active;

    }

    $scope.updatetypegroup = function (edittgroup) {

        if (edittgroup == null) {
            alert('Please enter name.');
            return;
        }

        if (edittgroup.editname == null) {
            alert('Please enter name.');
            return;
        }

        var SelTypeGroup = {
            Name: edittgroup.editname,
            Description: edittgroup.editdes,
            Active: edittgroup.editActive,
            Id: edittgroup.Id,
            insupddelflag: 'U'
        };

        var req = {
            method: 'POST',
            url: '/api/typegroups/savetypegroups',
            data: SelTypeGroup
        }
        $http(req).then(function (response) {
            $scope.getcustomerlist();
            $scope.tGroup = null;

        }, function (errres) {
            var errdata = errres.data;
            var errmssg = "";
            errmssg = (errdata && errdata.ExceptionMessage) ? errdata.ExceptionMessage : errdata.Message;
            alert(errmssg);
            $scope.getcustomerlist();
            $scope.tGroup = null;
        });

    };
});










