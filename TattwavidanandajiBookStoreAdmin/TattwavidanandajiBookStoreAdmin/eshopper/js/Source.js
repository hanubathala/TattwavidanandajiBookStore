var app = angular.module('myApp', ['ngStorage']);
var ctrl = app.controller('myCtrl', function ($scope, $http, $localStorage) {
    $localStorage.addcart = new Array();
    $scope.InitConfig = function () {
        $http.get('/api/Books/GetBooksList').then(function (res, data) {
            $scope.BookList = res.data;
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
            BookImage: ($scope.BookImage == null) ? null : $scope.BookImage,
            flag: flag
        };
        var req = {
            method: 'POST',
            url: '/api/Books/SaveBooks',
            data: booklist
        }
        $http(req).then(function (res) {
            Book = '';
            $scope.Book = '';
            $scope.BookImage = '';
            $scope.tt = '';
            alert('Books Saved Successfully...!');
            $scope.InitConfig();
            $('#Modal-header-new').modal('hide');
          
        }, function (ee) {
            alert(ee.data.ExceptionMessage);
            $scope.errmsg = ee;
        });
    }
    $scope.addtocard = function (items) {
        $localStorage.addcart
    }
   });










