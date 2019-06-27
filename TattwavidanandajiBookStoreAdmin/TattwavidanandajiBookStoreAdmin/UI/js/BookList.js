var app = angular.module('myApp', ['ngStorage', 'ui.bootstrap']);
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage, $interval) {
    if ($localStorage.uname == null) {
        window.location.href = "BooksList.html";
    }
    $scope.uname = $localStorage.uname;
    $scope.userdetails = $localStorage.userdetails;
    $scope.Roleid = $localStorage.userdetails[0].RoleId;

    $scope.InitConfig = function () {
        $http.get('/api/Books/GetBooksList').then(function (res, data) {
            $scope.BookList = res.data;
        });
    }
    $scope.addbook = function () {
        $http.get('/api/Books/Gettypesdata?booktype=1').then(function (res, data) {
            $scope.bok = res.data;
        }, function (error) {
           // alert(error.data.ExceptionMessage);
        });

    }

    $scope.AddNewBook = function (Book, flag) {
        if (Book.BookTitle == null) {
            alert('Please Enter Details.');
            return
        }
        if (Book.BookTitle == null)  {
            alert('Please Enter Book Title.');
            return
        }
        if (Book.BookPrice == null) {
            alert('Please Enter Price.');
            return
        }
        if (Book.BookStock == null) {
            alert('Please Enter Book Stock.');
            return
        }
        if (Book.BookType.Id == null | Book.BookType.Id == "") {
            alert('Please Enter Book Type.');
            return
        }
        var booklist = {
            Id: (Book.Id != null || Book.Id != '') ? Book.Id : '',
            BookTitle: Book.BookTitle,
            BookPrice: Book.BookPrice,
            BookStock: Book.BookStock,
            BookType: Book.BookType.Id,
            BookDescription: Book.BookDescription,
            BookImage:Book.BookImage,
            flag: flag
        };
        var req = {
            method: 'POST',
            url: '/api/Books/SaveBooks',
            data: booklist
        }
        $http(req).then(function (res) {
            $scope.InitConfig();
            $scope.Course = '';
            $scope.Coursedit = '';
            alert('Books Saved Successfully...!');
            $('#Modal-header-new').modal('hide');
            $('#Modal-header-new-Edit').modal('hide');
        }, function (ee) {
            alert(ee.data.ExceptionMessage);
            $scope.errmsg = ee;
        });
    }
   
    $scope.setCourse = function (grp) {
        $scope.bookedit = grp;

        for (i = 0; i < $scope.bok.length; i++) {
            if ($scope.bok[i].Id == $scope.bok.BookType) {
                $scope.bookedit.BookType = $scope.bok[i];
                break;
            }
        }
    }

   });










