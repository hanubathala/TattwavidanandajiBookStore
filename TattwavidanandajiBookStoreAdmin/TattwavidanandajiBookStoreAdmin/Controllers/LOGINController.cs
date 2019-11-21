using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using TattwavidanandajiBookStoreAdmin.Models;

namespace TattwavidanandajiBookStoreAdmin.Controllers
{
    public class LOGINController : ApiController
    {
        [HttpPost]
        public DataTable ValidateCredentials(UserLogin u)
        {
            DataTable Tbl = new DataTable();

            string username = u.LoginInfo;
            string pwd = u.Passkey;

            //connect to database
            SqlConnection conn = new SqlConnection();

            try
            {
                conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ValidationUserLogins";

                cmd.Connection = conn;

                SqlParameter lUserName = new SqlParameter("@logininfo", SqlDbType.VarChar, 50);
                lUserName.Value = username;
                lUserName.Direction = ParameterDirection.Input;
                cmd.Parameters.Add(lUserName);


                SqlParameter lPassword = new SqlParameter("@passkey", SqlDbType.VarChar, 50);
                lPassword.Value = pwd;
                lPassword.Direction = ParameterDirection.Input;
                cmd.Parameters.Add(lPassword);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(Tbl);
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
           
            return Tbl;

        }

        [HttpPost]
        [Route("api/LOGIN/CustomerLogin")]
        public DataTable CustomerLogin(UserLogin u)
        {
            DataTable Tbl = new DataTable();
            SqlConnection conn = new SqlConnection();
            try
            {
                conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "CustomerLoginsValidate";
                cmd.Connection = conn;
                cmd.Parameters.Add(new SqlParameter("@Email", SqlDbType.VarChar, 250)).SqlValue = u.LoginInfo;
                cmd.Parameters.Add(new SqlParameter("@Pwd", SqlDbType.VarChar, 250)).SqlValue = u.Passkey;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(Tbl);
            }
            catch (Exception ex)
            {

                throw ex;
            }

            return Tbl;

        }

    }
}
