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
    public class CustomerController : ApiController
    {
        [HttpPost]
        [Route("api/Customer/sendcustomerquery")]
        public void sendcustomerquery(CustomerQuery cust)
        {

            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection();
            SqlCommand cmd = new SqlCommand();
            try
            {

                //con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();

                //cmd.CommandType = CommandType.StoredProcedure;
                //cmd.CommandText = "InsUpdDelCustomer";
                //cmd.Connection = con;
                //cmd.Parameters.Add(new SqlParameter("@Username    ", SqlDbType.VarChar, 250)).SqlValue = cust.Name;
                //cmd.Parameters.Add(new SqlParameter("@FirstName", SqlDbType.VarChar, 250)).SqlValue = cust.Subject;
                //cmd.Parameters.Add(new SqlParameter("@LastName", SqlDbType.VarChar, 250)).SqlValue = cust.Email;
                //cmd.Parameters.Add(new SqlParameter("@MobileNo", SqlDbType.VarChar, 250)).SqlValue = cust.MessageDes;
                //cmd.Parameters.Add(new SqlParameter("@flag", SqlDbType.VarChar)).SqlValue = cust.flag;

                //SqlDataAdapter da = new SqlDataAdapter(cmd);
                //da.Fill(dt);

                if (cust.flag == "I")
                {

                    #region send email with details
                   // string eotp = dt.Rows[0]["eotp"].ToString();
                    //string email = dt.Rows[0]["Email"].ToString();


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
                        mail.To.Add(cust.Email);

                        mail.Subject = cust.Name+" : "+cust.Subject;
                        mail.IsBodyHtml = true;




                        string verifcodeMail = @"<table style='border-radius:8px;'>
                                                        <tr>
                                                            <td>
                                                                <h2>Query</h2>
                                                                <table width=\""860\"" align=\""center\"" >
                                                                    <tbody style='background-color:#F0F8FF;border-radius:8px;'>
                                                                        <tr>
                                                                            <td style=\""font-family:'Zurich BT',Arial,Helvetica,sans-serif;font-size:15px;text-align:left;line-height:normal;background-color:#F0F8FF;\"" >
<div style='padding:10px;border:#0000FF solid 2px;'>    <br /><br />
                                                                             
                                                       <h3>" + cust.MessageDes + @" </h3>

                                                        

                                                                                <br/>
                                                                                <br/>             
                                                                       
                                                                               
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

                    //update if email is sent

                    #endregion send email with details

                }
            }
            catch (Exception ex)
            {

                throw ex;
            }


            //return dt;
        }
        

         [HttpGet]
         [Route("api/Custome/GetCustomerList")]
        public DataSet GetCustomerList(int curpage, int maxrows)
        {
            DataSet dt = new DataSet();
            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "GetCustomerList";
                cmd.Connection = con;

                cmd.Parameters.Add(new SqlParameter("@curpage", SqlDbType.Int)).SqlValue = curpage;
                cmd.Parameters.Add(new SqlParameter("@maxrows", SqlDbType.Int)).SqlValue = maxrows;

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
        [Route("api/Customer/SaveCustomerDetails")]
        public DataTable SaveCustomerDetails(CustomerInfo cust) { 
         
          DataTable dt=new DataTable();
          SqlConnection con = new SqlConnection();
          SqlCommand cmd = new SqlCommand();
          try

          {

              con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();

              cmd.CommandType = CommandType.StoredProcedure;
              cmd.CommandText = "InsUpdDelCustomer";
              cmd.Connection = con;
              //@Id int=-1,@FirstName varchar(250)=null,@LastName varchar(250)=null,@MobileNo varchar(20)=null
              //,@Email varchar(250)=null,@Address varchar(max)=nulll,@ZipCode varchar(20)=null,
              //@LandMark varchar(max)=null,@AccountNo varchar(250)=null,@Active int=null,@flag varchar,@Password varchar(50)=null 
              cmd.Parameters.Add(new SqlParameter("@Username    ", SqlDbType.VarChar, 250)).SqlValue = cust.Username;
              cmd.Parameters.Add(new SqlParameter("@FirstName", SqlDbType.VarChar, 250)).SqlValue = cust.name;
              cmd.Parameters.Add(new SqlParameter("@LastName", SqlDbType.VarChar, 250)).SqlValue = cust.sname;
              cmd.Parameters.Add(new SqlParameter("@MobileNo", SqlDbType.VarChar, 250)).SqlValue = cust.MobileNo;
              cmd.Parameters.Add(new SqlParameter("@Password", SqlDbType.VarChar, 250)).SqlValue = cust.Password;
              cmd.Parameters.Add(new SqlParameter("@Active", SqlDbType.Int)).SqlValue = cust.Active;
              cmd.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int)).SqlValue = cust.Id;
              cmd.Parameters.Add(new SqlParameter("@Address", SqlDbType.VarChar, 250)).SqlValue = cust.address;
              cmd.Parameters.Add(new SqlParameter("@Email", SqlDbType.VarChar, 250)).SqlValue = cust.email;
              cmd.Parameters.Add(new SqlParameter("@LandMark", SqlDbType.VarChar, 250)).SqlValue = cust.landmark;
              //cmd.Parameters.Add(new SqlParameter("@mobileno", SqlDbType.VarChar, 25)).SqlValue = cust.mobileno;
              //cmd.Parameters.Add(new SqlParameter("@name", SqlDbType.VarChar, 100)).SqlValue = cust.name;
              //cmd.Parameters.Add(new SqlParameter("@sname", SqlDbType.VarChar, 100)).SqlValue = cust.sname;
              cmd.Parameters.Add(new SqlParameter("@ZipCode", SqlDbType.VarChar, 25)).SqlValue = cust.zipcode;
              cmd.Parameters.Add(new SqlParameter("@flag", SqlDbType.VarChar)).SqlValue = cust.flag;

              SqlDataAdapter da = new SqlDataAdapter(cmd);
              da.Fill(dt);

              if(cust.flag=="I"){

              #region send email with details
                   string eotp =  dt.Rows[0]["eotp"].ToString();
                   string email=dt.Rows[0]["Email"].ToString();
                

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
                  mail.To.Add(email);

                  mail.Subject = "Your Registering Email OTP";
                  mail.IsBodyHtml = true;

                  

                 
                  string verifcodeMail = @"<table>
                                                        <tr>
                                                            <td>
                                                                <h2>Thank you for registering with Holy Book Store</h2>
                                                                <table width=\""760\"" align=\""center\"">
                                                                    <tbody style='background-color:#F0F8FF;'>
                                                                        <tr>
                                                                            <td style=\""font-family:'Zurich BT',Arial,Helvetica,sans-serif;font-size:15px;text-align:left;line-height:normal;background-color:#F0F8FF;\"" >
<div style='padding:10px;border:#0000FF solid 2px;'>    <br /><br />
                                                                             
                                                       Your email OTP is:<h3>"+eotp+@" </h3>

                                                        

                                                                                <br/>
                                                                                <br/>             
                                                                       
                                                                                Warm regards,<br>
                                                                                Holy Book Store Customer Service Team<br/><br />
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

              //update if email is sent

              #endregion send email with details

               }
              }
          catch (Exception ex)
          {
             
              throw ex;
          }


          return dt;
        }


        [System.Web.Http.AcceptVerbs("GET", "POST")]
        [System.Web.Http.HttpGet]
        [Route("api/Customer/eotpverification")]
        public DataTable eotpverification(String Email, String Emailotp)
        {

            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection();
            SqlCommand cmd = new SqlCommand();
            try
            {

                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "EOTPverification";
                cmd.Connection = con;

                cmd.Parameters.Add(new SqlParameter("@Email    ", SqlDbType.VarChar, 250)).SqlValue = Email;
                cmd.Parameters.Add(new SqlParameter("@Emailotp", SqlDbType.VarChar, 250)).SqlValue = Emailotp;
               

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

               
            }
            catch (Exception ex)
            {

                throw ex;
            }


            return dt;
        }


    }
}
