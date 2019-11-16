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
   
    $scope.updatebookdetails = function (Book, flag) {
        if (Book.BookTitle == null) {
            alert('Please Enter Details.');
            return
        }
        if (Book.BookTitle == null) {
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
        if (Book.BookType1.Id == null | Book.BookType1.Id == "") {
            alert('Please Enter Book Type.');
            return
        }
        var booklist = {
            Id: (Book.Id != null || Book.Id != '') ? Book.Id : '',
            BookTitle: Book.BookTitle,
            BookPrice: Book.BookPrice,
            BookStock: Book.BookStock,
            BookType: Book.BookType1.Id,
            BookDescription: Book.BookDescription,
            Active:Book.Active,
            BookImage: ($scope.BookImage2 == null) ? null : $scope.BookImage2,
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
        $scope.bookedit = grp
        $scope.BookImage2 = grp.BookImage;
        for (i = 0; i < $scope.bok.length; i++) {
            if ($scope.bok[i].Name == grp.BookType) {
                $scope.bookedit.BookType1 = $scope.bok[i];
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










