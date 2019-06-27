using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TattwavidanandajiBookStoreAdmin.Models
{

    public class GetTypeData
    {
        public int booktype { get; set; }
    }

    public class Books
    {
        public string BookTitle { get; set; }
        public string BookImage { get; set; }
        public string BookDescription { get; set; }
        public int BookType { get; set; }
        public Decimal BookPrice { get; set; }
        public int Id { get; set; }
        public string flag { get; set; }
        public int Active { get; set; }
        public int BookStock { get; set; }
    }
    public class UserLogin
    {
        public int Id { set; get; }
        public int UserId { set; get; }
        public string LoginInfo { set; get; }
        public string Passkey { set; get; }
        public string Active { set; get; }
    }
}