﻿var app = angular.module('myApp', ['ngStorage', 'ui.bootstrap', 'angularFileUpload']);
app.directive('file-input', function ($parse) {
    return {
        restrict: "EA",
        template: "<input type='file' />",
        replace: true,
        link: function (scope, element, attrs) {

            var modelGet = $parse(attrs.fileInput);
            var modelSet = modelGet.assign;
            var onChange = $parse(attrs.onChange);

            var updateModel = function () {
                scope.$apply(function () {
                    modelSet(scope, element[0].files[0]);
                    onChange(scope);
                });
            };

            element.bind('change', updateModel);
        }
    };
});
app.directive("ngFileSelect", function () {

    return {

        link: function ($scope, el) {

            el.on('click', function () {

                this.value = '';

            });

            el.bind("change", function (e) {

                $scope.file = (e.srcElement || e.target).files[0];



                var allowed = ["jpeg", "png", "gif", "jpg"];

                var found = false;

                var img;

                img = new Image();

                allowed.forEach(function (extension) {

                    if ($scope.file.type.match('image/' + extension)) {

                        found = true;

                    }

                });

                if (!found) {

                    alert('file type should be .jpeg, .png, .jpg, .gif');

                    return;

                }

                img.onload = function () {

                    var dimension = $scope.selectedImageOption.split(" ");

                    if (dimension[0] == this.width && dimension[2] == this.height) {

                        allowed.forEach(function (extension) {

                            if ($scope.file.type.match('image/' + extension)) {

                                found = true;

                            }

                        });

                        if (found) {

                            if ($scope.file.size <= 1048576) {

                                $scope.getFile();

                            } else {

                                alert('file size should not be grater then 1 mb.');

                            }

                        } else {

                            alert('file type should be .jpeg, .png, .jpg, .gif');

                        }

                    } else {

                        alert('selected image dimension is not equal to size drop down.');

                    }

                };
                //  img.src = _URL.createObjectURL($scope.file);
            });
        }
    };
});

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
                booktype: 1,
                labeltype: 1,
                languagetype: 1,
            };

            var req = {
                method: 'POST',
                url: '/api/Types/TypesByGroupId',
                data: grpid
            }
            $http(req).then(function (res, data) {
                $scope.bok = res.data.Table;
                $scope.labellist = res.data.Table1;
                $scope.languagelist = res.data.Table2;
                $scope.getbooklist();
            },function (ee) {
                alert(ee.data.ExceptionMessage);
                $scope.errmsg = ee;
            });
    }
    $scope.getbooklist = function (flag) {

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
        $http.get('/api/Books/GetBooksListConfig?curpage=' + curpage + '&maxrows=' + selecting).then(function (res, data) {
            $scope.BookList = res.data.Table;
            $scope.paggin = res.data.Table1;
            if ($scope.BookList.length < selecting) {
                $scope.secondvalue = $scope.secondvalue - (selecting - $scope.BookList.length);

            }
            var result = [];
            for (var i = 1; i <= $scope.paggin[0].totalpages; i++) {
                result.push(i);
            }
            $scope.jumptotalpages = result;
        });


    }
    $scope.addbook = function () {
        //$http.get('/api/Books/Gettypesdata?booktype=1').then(function (res, data) {
        //    $scope.bok = res.data;
        //}, function (error) {
        //   // alert(error.data.ExceptionMessage);
        //});

    }
    $scope.onFileSelect1 = function () {

        fileReader.readAsDataUrl($scope.file, $scope).then(function (result) {

            $scope.BookImage = result;
        });
    }
    $scope.UploadImg = function () {
        var fileinput = document.getElementById('fileInput');
        fileinput.click();

        //  
        //if ($scope.file == null)
        //{ $scope.file = fileinput.files[0]; }
        //fileReader.readAsDataUrl($scope.file, $scope).then(function (result) { $scope.imageSrc = result; });
        //fileReader.onLoad($scope.file, $scope).then(function (result) { $scope.imageSrc = result; });
    };
    $scope.AddNewBook = function (Book, flag) {
       
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
        if (Book.Weight == null) {
            alert('Please Enter Book Weight.');
            return
        }
        //if (Book.Label == null) {
        //    alert('Please Select Book Label.');
        //    return
        //}
        if (Book.BookAuthor == null) {
            alert('Please Enter Book Author Name.');
            return
        }
        if (Book.BookType.Id == null | Book.BookType.Id == "") {
            alert('Please Enter Book Type.');
            return
        }
        if (Book.Language == null) {
            alert('Please Enter in which laguage book is written.');
            return
        }
        if (Book.Tags == null) {
            alert('Please Enter Tags of Book.');
            return
        }
        if (Book.NoOfPages == null) {
            alert('Please Ente No of Page in the book.');
            return
        }
        if (Book.Publisher== null) {
            alert('Please Enter Publise Name.');
            return
        }
        if ($scope.BookImage == null) {
            alert('Please select Book Image.');
            return
        }
        
        var booklist = {
            Id: (Book.Id != null || Book.Id != '') ? Book.Id : '',
            BookTitle: Book.BookTitle,
            BookPrice: Book.BookPrice,
            BookStock: Book.BookStock,
            BookType: Book.BookType.Id,
            BookDescription: Book.BookDescription,
            BookSKU: Book.SKU,
            BookWeight: Book.Weight,
            BookLabelId: (Book.Label == null) ? null : Book.Label.Id,
            BookBookAuthor: Book.BookAuthor,
            BookTags: Book.Tags,
            BookLanguageId: Book.Language.Id,
            BookNoOfPages: Book.NoOfPages,
            BookPublisher: Book.Publisher,
            Active: Book.Active,
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
   
    $scope.updatebookdetails = function (Book, flag) {

        if (Book == null) {
            alert('Please Enter Details.');
            return
        }
        if (Book.BookTitle1 == null) {
            alert('Please Enter Book Title.');
            return
        }
        if (Book.BookPrice1 == null) {
            alert('Please Enter Price.');
            return
        }
        if (Book.BookStock1 == null) {
            alert('Please Enter Book Stock.');
            return
        }
        if ($scope.BookType1.Id == null || $scope.BookType1.Id == "") {
            alert('Please Enter Book Type.');
            return
        }
       
        if (Book.Weight1 == null) {
            alert('Please Enter Book Weight.');
            return
        }
        
        if (Book.BookAuthor1 == null) {
            alert('Please Enter Book Author Name.');
            return
        }
       
        if ($scope.Language1 == null) {
            alert('Please Enter in which laguage book is written.');
            return
        }
        if (Book.Tags1 == null) {
            alert('Please Enter Tags of Book.');
            return
        }
        if (Book.NoOfPages1 == null) {
            alert('Please Ente No of Page in the book.');
            return
        }
        if (Book.Publisher1 == null) {
            alert('Please Enter Publise Name.');
            return
        }
        if ($scope.bookedit.BookImage1 == null) {
            alert('Please select Book Image.');
            return
        }
        var booklist = {
            Id: (Book.Id != null || Book.Id != '') ? Book.Id : '',
            BookTitle: Book.BookTitle1,
            BookPrice: Book.BookPrice1,
            BookStock: Book.BookStock1,
            BookType: $scope.BookType1.Id,
            BookDescription: Book.BookDescription1,
            BookSKU: Book.SKU1,
            BookWeight: Book.Weight1,
            BookLabelId: $scope.Label1.Id,
            BookBookAuthor: Book.BookAuthor1,
            BookTags: Book.Tags1,
            BookLanguageId: $scope.Language1.Id,
            BookNoOfPages: Book.NoOfPages1,
            BookPublisher: Book.Publisher1,
            Active: Book.Active1,
            BookImage: ($scope.bookedit.BookImage1 == null) ? null : $scope.bookedit.BookImage1,
            flag: flag
        };
        var req = {
            method: 'POST',
            url: '/api/Books/SaveBooks',
            data: booklist
        }
        $http(req).then(function (res) {
            Book = ''
            $scope.bookedit = '';   
            alert('Updated Book Details Successfully');
            $scope.InitConfig();
            $('#Modal-header-new-Edit').modal('hide');

        }, function (ee) {
            alert(ee.data.ExceptionMessage);
            $scope.errmsg = ee;
        });
    }
    $scope.setCourse = function (grp) {
        $scope.bookedit = grp;
        $scope.bookedit.BookTitle1 = grp.BookTitle;
        $scope.bookedit.BookPrice1 = grp.BookPrice;
        $scope.bookedit.BookStock1 = grp.BookStock;
        $scope.bookedit.BookDescription1 = grp.BookDescription;
        $scope.bookedit.SKU1 = grp.BookSKU;
        $scope.bookedit.Weight1 = grp.BookWeight;
        
        $scope.bookedit.BookAuthor1 = grp.BookAuthor;
        $scope.bookedit.Tags1 = grp.BookTags;
        $scope.bookedit.Language1 = grp.BookTitle;
        $scope.bookedit.NoOfPages1 = grp.BookNoOfPages;
        $scope.bookedit.Publisher1 = grp.BookPublisher;
        $scope.bookedit.Active1 = grp.Active;
        $scope.bookedit.BookImage1 = grp.BookImage;

        for (i = 0; i < $scope.bok.length; i++) {
            if ($scope.bok[i].Name == grp.BookType) {
                $scope.BookType1 = $scope.bok[i];
                break;
            }
        }
        for (i = 0; i < $scope.labellist.length; i++) {
            if ($scope.labellist[i].Id == grp.BookLabelId) {
                $scope.Label1 = $scope.labellist[i];
                break;
            }

        }
        for (i = 0; i < $scope.languagelist.length; i++) {
            if ($scope.languagelist[i].Id == grp.BookLanguageId) {
                $scope.Language1 = $scope.languagelist[i];
                break;
            }
        }

    }
    $scope.openimagetoshow = function (t) {

        openPDF(t.BookImage, "BookImage");
    }
    function openPDF(resData, fileName) {

        var blob = null;
        var ext = fileName.split('.').pop();
        if (ext == 'csv') {
            blob = new Blob([resData], { type: "text/csv" });
            saveAs(blob, fileName);
        }
        else {

            var ieEDGE = navigator.userAgent.match(/Edge/g);
            var ie = navigator.userAgent.match(/.NET/g); // IE 11+
            var oldIE = navigator.userAgent.match(/MSIE/g);

            if (ie || oldIE || ieEDGE) {
                blob = b64toBlob(resData, (ext == 'csv') ? 'text/csv' : 'application/pdf');
                // window.open(blob, '_blank');
                //  window.navigator.msSaveBlob(blob, fileName);
                saveAs(blob, fileName);
                //openReportWindow('test', resData, 1000, 700);
                //window.open(resData, '_blank');
                //  var a = document.createElement("a");
                //  document.body.appendChild(a);
                //  a.style = "display: none";
                //  a.href = resData;
                //  a.download = fileName;
                ////  a.onclick = "window.open(" + fileURL + ", 'mywin','left=200,top=20,width=1000,height=800,toolbar=1,resizable=0')";
                //  a.click(); 

            }
            else {

                if (ext == 'csv' || ext == 'pdf') {
                    blob = b64toBlob(resData, (ext == 'csv') ? 'text/csv' : 'application/pdf');
                    saveAs(blob, fileName);
                }
                else {
                    openReportWindow(fileName, resData, 1000, 700);
                }
                // newWindow =   window.open(resData, 'newwin', 'left=200,top=20,width=1000,height=700,toolbar=1,resizable=0');
                //   timerObj = window.setInterval("ResetTitle('"+fileName+"')", 10);
            }
        }
    }

    var winLookup;
    var showToolbar = false;
    function openReportWindow(m_title, m_url, m_width, m_height) {
        var strURL;
        var intLeft, intTop;

        strURL = m_url;

        // Check if we've got an open window.
        if ((winLookup) && (!winLookup.closed))
            winLookup.close();

        // Set up the window so that it's centered.
        intLeft = (screen.width) ? ((screen.width - m_width) / 2) : 0;
        intTop = 20;//(screen.height) ? ((screen.height - m_height) / 2) : 0;

        // Open the window.
        winLookup = window.open('', 'winLookup', 'scrollbars=no,resizable=yes,toolbar=' + (showToolbar ? 'yes' : 'no') + ',height=' + m_height + ',width=' + m_width + ',top=' + intTop + ',left=' + intLeft);
        checkPopup(m_url, m_title);

        // Set the window opener.
        if ((document.window != null) && (!winLookup.opener))
            winLookup.opener = document.window;

        // Set the focus.
        if (winLookup.focus)
            winLookup.focus();
    }

    function checkPopup(m_url, m_title) {
        if (winLookup.document) {
            //identify the file type and display accordingly
            var ext = m_title.split('.').pop();
            switch (ext) {
                case 'pdf':
                    winLookup.document.write('<html><head><title>' + m_title + '</title></head><body height="100%" width="100%"><embed type="application/pdf" src="' + m_url + '" height="100%" width="100%" /></body></html>');
                    break;
                default:
                    winLookup.document.write('<html><head><title>' + m_title + '</title></head><body height="100%" width="100%"><img src="' + m_url + '" height="100%" width="100%" /></body></html>');
                    break;
            }

        } else {
            // if not loaded yet
            setTimeout(checkPopup(m_url, m_title), 10); // check in another 10ms
        }
    }

    function b64toBlob(b64Data, contentType) {
        contentType = contentType || '';
        var sliceSize = 512;
        b64Data = b64Data.replace(/^[^,]+,/, '');
        b64Data = b64Data.replace(/\s/g, '');
        var byteCharacters = window.atob(b64Data);
        var byteArrays = [];

        for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
            var slice = byteCharacters.slice(offset, offset + sliceSize);

            var byteNumbers = new Array(slice.length);
            for (var i = 0; i < slice.length; i++) {
                byteNumbers[i] = slice.charCodeAt(i);
            }

            var byteArray = new Uint8Array(byteNumbers);

            byteArrays.push(byteArray);
        }

        var blob = new Blob(byteArrays, { type: contentType });
        return blob;
    }

    $scope.onFileSelect2 = function () {

        fileReader.readAsDataUrl($scope.file, $scope).then(function (result) {

            $scope.BookImage2 = result;
        });
    }
    $scope.UploadImg = function () {
        var fileinput = document.getElementById('fileInput');
        fileinput.click();

        //  
        //if ($scope.file == null)
        //{ $scope.file = fileinput.files[0]; }
        //fileReader.readAsDataUrl($scope.file, $scope).then(function (result) { $scope.imageSrc = result; });
        //fileReader.onLoad($scope.file, $scope).then(function (result) { $scope.imageSrc = result; });
    };
   });










