using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
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
                cmd.Connection.Open();
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

        [HttpGet]
        [Route("api/Books/SendEmail")]
        public void SendEmail() {
             string toemail="hanumaiah.bathala@gmail.com";
            try
            {
                MailMessage mail = new MailMessage();
                string emailserver = System.Configuration.ConfigurationManager.AppSettings["emailserver"].ToString();

                string username = System.Configuration.ConfigurationManager.AppSettings["username"].ToString();
                string pwd = System.Configuration.ConfigurationManager.AppSettings["password"].ToString();
                string fromaddress = System.Configuration.ConfigurationManager.AppSettings["fromaddress"].ToString();
                string port = System.Configuration.ConfigurationManager.AppSettings["port"].ToString();

                SmtpClient SmtpServer = new SmtpClient(emailserver);

                mail.From = new MailAddress(fromaddress);
                mail.To.Add(toemail);
                mail.Subject = "User registration - Email OTP";
                mail.IsBodyHtml = true;

                string verifcodeMail = @"<table>
                                                        <tr>
                                                            <td>
                                                                <h2>Thank you for registering with PaySmart APP</h2>
                                                                <table width=\""760\"" align=\""center\"">
                                                                    <tbody style='background-color:#F0F8FF;'>
                                                                        <tr>
                                                                            <td style=\""font-family:'Zurich BT',Arial,Helvetica,sans-serif;font-size:15px;text-align:left;line-height:normal;background-color:#F0F8FF;\"" >
<div style='padding:10px;border:#0000FF solid 2px;'>    <br /><br />
                                                                             
                                                       Your email OTP is:<h3>2536 </h3>

                                                        If you didn't make this request, <a href='http://154.120.237.198:52800'>click here</a> to cancel.

                                                                                <br/>
                                                                                <br/>             
                                                                       
                                                                                Warm regards,<br>
                                                                                PAYSMART Customer Service Team<br/><br />
</div>
                                                                            </td>
                                                                        </tr>

                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>

                                                    </table>";


                mail.Body = verifcodeMail;
                //SmtpServer.Port = 465;
                //SmtpServer.Port = 587;
                SmtpServer.Port = Convert.ToInt32(port);
                SmtpServer.UseDefaultCredentials = false;

                SmtpServer.Credentials = new System.Net.NetworkCredential(username, pwd);
                SmtpServer.EnableSsl = true;
                //SmtpServer.TargetName = "STARTTLS/smtp.gmail.com";
                SmtpServer.Send(mail);

            }
            catch (Exception ex)
            {
                //throw ex;
            }
        }
    }
}
