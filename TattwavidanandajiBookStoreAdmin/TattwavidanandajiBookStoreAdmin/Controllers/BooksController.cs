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
    public class BooksController : ApiController
    {
        [HttpGet]
        [Route("api/Books/GetBooksList")]
        public DataTable GetBooksList()
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "GetBookList";
                cmd.Connection = con;

                SqlDataAdapter db = new SqlDataAdapter(cmd);
                db.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }

            }
        }
        [HttpPost]
        [Route("api/Books/SaveBooks")]
        public DataTable SaveBooksList(Books bk)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "InsUpdDelBook";
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@BookTitle", SqlDbType.VarChar, 250)).SqlValue = bk.BookTitle;
                cmd.Parameters.Add(new SqlParameter("@BookImage", SqlDbType.VarChar, -1)).SqlValue = bk.BookImage;
                cmd.Parameters.Add(new SqlParameter("@BookStock", SqlDbType.Int)).SqlValue = bk.BookStock;
                cmd.Parameters.Add(new SqlParameter("@BookDescription", SqlDbType.VarChar, 250)).SqlValue = bk.BookDescription;
                cmd.Parameters.Add(new SqlParameter("@BookType", SqlDbType.Int)).SqlValue = bk.BookType;
                cmd.Parameters.Add(new SqlParameter("@BoolPrice", SqlDbType.Decimal)).SqlValue = bk.BookPrice;
                cmd.Parameters.Add(new SqlParameter("@flag", SqlDbType.VarChar, 250)).SqlValue = bk.flag;
                cmd.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int)).SqlValue = bk.Id;
                cmd.Parameters.Add(new SqlParameter("@Active", SqlDbType.Int)).SqlValue = bk.Active;
                SqlDataAdapter db = new SqlDataAdapter(cmd);
                db.Fill(dt);
            }
            catch (Exception ex)
            {
                throw new HttpResponseException(Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex.Message));
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }

            }
            return dt;
        }

        [HttpGet]
        [Route("api/Books/UpdateActive")]
        public DataTable UpdateActive(int active, int bookId)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "UpdateActiveBooklist";
                cmd.Connection = con;

                cmd.Parameters.Add(new SqlParameter("@Active", SqlDbType.Int)).SqlValue = active;
                cmd.Parameters.Add(new SqlParameter("@BookId", SqlDbType.Int)).SqlValue = bookId;
                SqlDataAdapter db = new SqlDataAdapter(cmd);
                db.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }

            }
        }

        [HttpGet]
        [Route("api/Books/Gettypesdata")]
        public DataTable Gettypesdata(int booktype)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "Gettypesdata";
                cmd.Connection = con;

                cmd.Parameters.Add(new SqlParameter("@booktype", SqlDbType.Int)).SqlValue = booktype;

                SqlDataAdapter db = new SqlDataAdapter(cmd);
                db.Fill(dt);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }

            }
            return dt;
        }

        [HttpGet]
        [Route("api/Books/GetBookListbyId")]
        public DataTable GetBookListbyId(int Id)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "GetBookListbyId";
                cmd.Connection = con;

                cmd.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int)).SqlValue = Id;

                SqlDataAdapter db = new SqlDataAdapter(cmd);
                db.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }

            }
        }
    }
}
