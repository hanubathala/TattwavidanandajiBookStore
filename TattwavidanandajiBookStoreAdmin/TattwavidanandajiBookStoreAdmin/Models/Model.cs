using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TattwavidanandajiBookStoreAdmin.Models
{


    public class TypeGroups
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public string Active { get; set; }
        public string insupddelflag { get; set; }
    }

    public class Types
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string Description { get; set; }

        public string Active { get; set; }



        public string TypeGroupId { get; set; }

        public string ListKey { get; set; }

        public string Listvalue { get; set; }
        public string insupddelflag { get; set; }
    }
    public class ConfigData
    {
        public int booktype { get; set; }
        public int labeltype { get; set; }
        public int languagetype { get; set; }
       
    }
    public class FleetOwner
    {
        public int Id { get; set; }

        public string UserId { get; set; }

        public string BTPOSgroupid { get; set; }

        public string Active { get; set; }

    }


    public class CustomerInfo {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MobileNo { get; set; }
        public int Active { get; set; }
        public string Password { get; set; }
        public int Id { get; set; }
        public string address { get; set; }
        public string email { get; set; }
        public string landmark { get; set; }
        public string mobileno { get; set; }
        public string name { get; set; }
        public string sname { get; set; }
        public string zipcode { get; set; }
        public string flag { get; set; }
        public string Username { get; set; }
        
    }
   
    public class Orderlist
    {
        public string BookDescription { get; set; }
        public string BookImage { get; set; }
        public int BookPrice { get; set; }
        public string BookTitle { get; set; }
        public string BookType { get; set; }
        public int quantity { get; set; }
        public int Id { get; set; }
        public string address { get; set; }
        public string email { get; set; }
        public string landmark { get; set; }
        public string mobileno { get; set; }
        public string name { get; set; }
        public string sname { get; set; }
        public string zipcode { get; set; }
        public int BookStock { get; set; }
        }


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

        public string BookSKU { get; set; }
        public Decimal BookWeight { get; set; }
        public int BookLabelId { get; set; }
        public string BookBookAuthor { get; set; }
        public string BookTags { get; set; }
        public int BookLanguageId { get; set; }
        public int BookNoOfPages { get; set; }
        public int BookPublisher { get; set; }
        public int BookActive { get; set; }
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