var app = angular.module('myApp', ['ngStorage', 'ui.bootstrap', 'angularFileUpload']);


var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage) {
    if ($localStorage.uname == null) {
        window.location.href = "BooksList.html";
    }
    $scope.uname = $localStorage.uname;
    $scope.userdetails = $localStorage.userdetails;
    $scope.CanCreate = 0;
    $scope.selectedvalue ='5';      
    $scope.selectgoto = 1;
    $scope.ty = '-1';

    $scope.gettypegroups = function () {
        $http.get('/api/TypeGroups/GetTypeGroupsconfig').then(function (res, data) {
            $scope.TypeGroups = res.data;
            $scope.s = res.data[0];
            $scope.getcustomerlist();
        });


        
    }
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
        var tid = ($scope.s == null) ? -1 : $scope.s.Id;
        $http.get('/api/Types/TypesPaging?groupid='+tid+'&curpage=' + curpage + '&maxrows=' + selecting).then(function (res, data) {
            $scope.Types = res.data.Table;
            $scope.paggin = res.data.Table1;
            if ($scope.Types.length < selecting) {
                $scope.secondvalue = $scope.secondvalue - (selecting - $scope.Types.length);

            }
            var result = [];
            for (var i = 1; i <= $scope.paggin[0].totalpages; i++) {
                result.push(i);
            }
            $scope.jumptotalpages = result;
        });


    }
   
    $scope.saveNewType= function (Types) {

        if (Types == null) {
            alert('Please enter name.');
            return;
        }

        if (Types.Name == null) {
            alert('Please enter name.');
            return;
        }
        if (Types.group == null) {
            alert('Please select a type group');
            return;
        }

        var Types = {

            Id: null,
            Name: Types.Name,
            Description: Types.Description,
            Active: Types.Active,
            TypeGroupId: Types.group.Id,
            ListKey: Types.ListKey,
            Listvalue: Types.Listvalue,
            insupddelflag: 'I'
        };

        var req = {
            method: 'POST',
            url: '/api/Types/SaveType',
            //headers: {
            //    'Content-Type': undefined
            data: Types
        }

        $http(req).then(function (response) {

            // $scope.showDialog("Saved successfully!");
            $scope.getcustomerlist();
            $scope.saveNewType = null;

        }, function (errres) {
            var errdata = errres.data;
            var errmssg = "";
            errmssg = (errdata && errdata.ExceptionMessage) ? errdata.ExceptionMessage : errdata.Message;
            $scope.getcustomerlist();
           
        });
       
    };
    $scope.Updatetypedetails = function (edittype) {

        if (edittype == null) {
            alert('Please enter name.');
            return;
        }

        if (edittype.Name == null) {
            alert('Please enter name.');
            return;
        }
        if (edittype.edittypegroup == null) {
            alert('Please select a type group');
            return;
        }

        var Types = {

            Id: edittype.Id,
            Name: edittype.editname,
            Description: edittype.editdesc,
            Active: edittype.editActive,
            TypeGroupId: edittype.edittypegroup.Id,
            ListKey: edittype.ListKey,
            Listvalue: edittype.Listvalue,
            insupddelflag: 'U'
        };

        var req = {
            method: 'POST',
            url: '/api/Types/SaveType',
            //headers: {
            //    'Content-Type': undefined
            data: Types
        }

        $http(req).then(function (response) {

            // $scope.showDialog("Saved successfully!");
            $scope.getcustomerlist();
            $scope.saveNewType = null;

        }, function (errres) {
            var errdata = errres.data;
            var errmssg = "";
            errmssg = (errdata && errdata.ExceptionMessage) ? errdata.ExceptionMessage : errdata.Message;
            $scope.getcustomerlist();

        });

    };
    $scope.setdata = function (data) {

        $scope.edittype = data;
        $scope.edittype.editname = data.Name;
        $scope.edittype.editdesc = data.Description;
        $scope.edittype.editActive = data.Active;

        for (var i = 0; i <$scope.TypeGroups.length; i++) {
            if (data.TypeGroupId == $scope.TypeGroups[i].Id) {

                $scope.edittype.edittypegroup = $scope.TypeGroups[i];
            }

        }
    }
   });










