var app = angular.module('myApp', ['ngStorage', 'ui.bootstrap']);
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage, $interval) {
    if ($localStorage.uname == null) {
        window.location.href = "login.html";
    }
    $scope.uname = $localStorage.uname;
    $scope.InitConfig = function () {
        
        $http.get('/api/Course/GetCourseSchedule?getlist=5').then(function (res, data) {
            $scope.scourse = res.data.Table;
            if (res.data.Table[0]!= null) { 
                $scope.getConfig(res.data.Table[0]);
                $scope.selectionoption = res.data.Table[0];
            }
        });
    }
    $scope.getConfig = function (dd) {
            $http.get('/api/Course/GetIndexCourse?Id='+dd.Id).then(function (res, data) {
            $scope.clist = res.data.Table[0];
            $scope.courselist = res.data.Table1;
            $scope.cschedulelist = res.data.Table2;
            $scope.csName = res.data.Table3[0].Description;
        });
    }
});










