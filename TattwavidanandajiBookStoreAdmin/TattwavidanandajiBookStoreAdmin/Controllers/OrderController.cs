using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Text;
using System.Web.Http;
using TattwavidanandajiBookStoreAdmin.Models;

namespace TattwavidanandajiBookStoreAdmin.Controllers
{
    public class OrderController : ApiController
    {

            [HttpGet]
        [Route("api/Order/GetOrderDetails")]
        public DataTable GetOrderDetails(int Id)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "GetOrderDetails";
                cmd.Connection = con;

                SqlParameter cpage = new SqlParameter();
                cpage.ParameterName = "@orderId";
                cpage.SqlDbType = SqlDbType.Int;
                cpage.Value = Id;
                cmd.Parameters.Add(cpage);

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
        [Route("api/Order/GetOrders")]
        public DataSet GetOrders(int curpage, int maxrows)
        {
            DataSet dt = new DataSet();
            SqlConnection con = new SqlConnection();
            try
            {
                con.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "GetOrders";
                cmd.Connection = con;

                SqlParameter cpage = new SqlParameter();
                cpage.ParameterName = "@curpage";
                cpage.SqlDbType = SqlDbType.Int;
                cpage.Value = curpage;
                cmd.Parameters.Add(cpage);

                SqlParameter mrows = new SqlParameter();
                mrows.ParameterName = "@maxrows";
                mrows.SqlDbType = SqlDbType.Int;
                mrows.Value = maxrows;
                cmd.Parameters.Add(mrows);

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
        [HttpPost]
        public DataTable SaveOrder(List<Orderlist> list)
        {
            DataTable dt = new DataTable();
            DataTable dt1 = new DataTable();
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();
            Int16 Id=0,Id1=0;
            try
            {

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
               

                #region send email with details

                try
                {
                    string emailaddress = "hnmisv";
                    string customer = "1";

                    MailMessage mail = new MailMessage();
                    string emailserver = System.Configuration.ConfigurationManager.AppSettings["emailserver"].ToString();

                    string username = System.Configuration.ConfigurationManager.AppSettings["username"].ToString();
                    string pwd = System.Configuration.ConfigurationManager.AppSettings["password"].ToString();
                    string fromaddress = System.Configuration.ConfigurationManager.AppSettings["fromaddress"].ToString();
                    string port = System.Configuration.ConfigurationManager.AppSettings["port"].ToString();

                    SmtpClient SmtpServer = new SmtpClient(emailserver);

                    mail.From = new MailAddress(fromaddress);
                    mail.To.Add(list[0].email);

                    mail.Subject = "Your Books Order";
                    mail.IsBodyHtml = true;

                    StringBuilder itemsList = new StringBuilder();
                    DateTime dtime = DateTime.Now;
                    dtime.AddDays(5);

                    int cnt = 1;
                    
                    foreach (Orderlist m in list)
                    {
                        itemsList.Append("<tr>");

                        itemsList.Append("<td align='center'>");
                        itemsList.Append(cnt++);
                        itemsList.Append("</td>");

                        itemsList.Append("<td>");
                        itemsList.Append(m.BookTitle);
                        itemsList.Append("</td>");

                        itemsList.Append("<td>");
                        itemsList.Append(m.BookDescription);
                        itemsList.Append("</td>");

                        itemsList.Append("<td align='center'>");
                        itemsList.Append(m.quantity);
                        itemsList.Append("</td>");

                        //int subtotal = m.qty * m.perunit;

                        itemsList.Append("<td align='center'>");
                        itemsList.Append(m.BookPrice);
                        itemsList.Append("</td>");

                        itemsList.Append("<td align='center'>");
                        itemsList.Append((m.BookPrice * m.quantity).ToString());
                        itemsList.Append("</td>");

                       
                        itemsList.Append("</tr>");
                    }
                    
                    string verifcodeMail = @"<table>
                                        <tr>
                                            <td>
                                                <h3>Holy Store Book Store</h3>
                                                <h4>Thanking you for ordering books online</h4>
                                             
                                                <table border=" + 1 + @">
                                                    <tr>
                                                        <td>
                                                            S.No
                                                        </td>
                                                        <td>Book Title</td>
                                                        <td>Book Description</td>
                                                        <td>Quantity</td>
                                                        <td>Price</td>
                                                        <td>Sub Total</td>
                                                    </tr>" + itemsList.ToString() + @"</table>
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


                // sending the email for admin --- start
                #region send email with details
                
                
                try
                {
                    string emailaddress = "hnmisv";
                    string customer = "1";

                    MailMessage mail = new MailMessage();
                    string emailserver = System.Configuration.ConfigurationManager.AppSettings["emailserver"].ToString();

                    string username = System.Configuration.ConfigurationManager.AppSettings["username"].ToString();
                    string pwd = System.Configuration.ConfigurationManager.AppSettings["password"].ToString();
                    string fromaddress = System.Configuration.ConfigurationManager.AppSettings["fromaddress"].ToString();
                    string port = System.Configuration.ConfigurationManager.AppSettings["port"].ToString();

                    SmtpClient SmtpServer = new SmtpClient(emailserver);

                    mail.From = new MailAddress(fromaddress);
                    mail.To.Add(fromaddress);
                    mail.Subject =list[0].name+" "+list[0].sname+" has placed the Order.";
                    mail.IsBodyHtml = true;

                    StringBuilder itemsList = new StringBuilder();
                    DateTime dtime = DateTime.Now;
                    dtime.AddDays(5);

                    int cnt = 1;

                    foreach (Orderlist m in list)
                    {
                        itemsList.Append("<tr>");

                        itemsList.Append("<td align='center'>");
                        itemsList.Append(cnt++);
                        itemsList.Append("</td>");

                        itemsList.Append("<td>");
                        itemsList.Append(m.BookTitle);
                        itemsList.Append("</td>");

                        itemsList.Append("<td>");
                        itemsList.Append(m.BookDescription);
                        itemsList.Append("</td>");

                        itemsList.Append("<td align='center'>");
                        itemsList.Append(m.quantity);
                        itemsList.Append("</td>");

                        //int subtotal = m.qty * m.perunit;

                        itemsList.Append("<td align='center'>");
                        itemsList.Append(m.BookPrice);
                        itemsList.Append("</td>");

                        itemsList.Append("<td align='center'>");
                        itemsList.Append((m.BookPrice * m.quantity).ToString());
                        itemsList.Append("</td>");


                        itemsList.Append("</tr>");
                    }

                    string verifcodeMail = @"<table>
                                        <tr>
                                            <td>
                                                <h3>Holy Store Book Store</h3>
                                                <h4>Thanking you for ordering books online</h4>
                                             
                                                <table border=" + 1 + @">
                                                    <tr>
                                                        <td>
                                                            S.No
                                                        </td>
                                                        <td>Book Title</td>
                                                        <td>Book Description</td>
                                                        <td>Quantity</td>
                                                        <td>Price</td>
                                                        <td>Sub Total</td>
                                                    </tr>" + itemsList.ToString() + @"</table>
                                                </td>
                                            </tr>
                                            <tr>
											<td colspan="+3+@">Name</td>
											<td colspan=" + 4 + @">" + list[0].name + " " + list[0].sname + @"</td>
											</tr>
											<tr>
											<td colspan=" + 3 + @">Mobile No</td>
											<td colspan=" + 4 + @">" + list[0].mobileno + @"</td>
											</tr>
											<tr>
											<td colspan=" + 3 + @">Email Id</td>
											<td colspan=" + 4 + @">" + list[0].email + @"</td>
											
											</tr>
											<tr>
											<td colspan=" + 3 + @">Address</td>
											<td colspan=" + 4 + @">" + list[0].address + @"</td>
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
                SqlTransaction tras = null;
               
                if (list.Count != 0) {
                    int quantitycount=0,totalamount=0;
                    for (int i = 0; i < list.Count; i++) {
                        quantitycount = quantitycount + list[i].quantity;
                       totalamount=totalamount+(list[i].quantity *list[i].BookPrice );
                    }
                    cmd.CommandText = "InsUpdDelAddressBook";
                    cmd.Connection = conn;
                    conn.Open();
                    tras = conn.BeginTransaction();
                    cmd.Transaction = tras;
                    // @CustomerId int,@Address varchar(max)=null,@zipcode varchar(100)=null,@landmark varchar(250)=null,@addressfor varchar(100)=null
                    cmd.Parameters.Add(new SqlParameter("@Address", SqlDbType.VarChar, 250)).SqlValue = list[0].address;
                    cmd.Parameters.Add(new SqlParameter("@CustomerId", SqlDbType.Int)).SqlValue = list[0].customerId;
                    cmd.Parameters.Add(new SqlParameter("@landmark", SqlDbType.VarChar, 250)).SqlValue = list[0].landmark;
                    cmd.Parameters.Add(new SqlParameter("@addressfor", SqlDbType.VarChar, 100)).SqlValue = "Home";
                    cmd.Parameters.Add(new SqlParameter("@zipcode", SqlDbType.VarChar, 25)).SqlValue = list[0].zipcode;

                    SqlDataAdapter da1 = new SqlDataAdapter(cmd);
                    da1.Fill(dt1);
                    Id1 = Convert.ToInt16(dt1.Rows[0]["Id1"]);
                   
                    cmd.Parameters.Clear();
                    cmd.CommandText = "InsOrder";
                    cmd.Connection = conn;
                   
                  
                    cmd.Parameters.Add(new SqlParameter("@Quantity", SqlDbType.VarChar, 250)).SqlValue = quantitycount;
                    cmd.Parameters.Add(new SqlParameter("@StatusId", SqlDbType.VarChar, 250)).SqlValue = 4;
                    cmd.Parameters.Add(new SqlParameter("@Total", SqlDbType.VarChar, 250)).SqlValue = totalamount;
                    cmd.Parameters.Add(new SqlParameter("@CustomerId", SqlDbType.Int)).SqlValue = list[0].customerId;
                    cmd.Parameters.Add(new SqlParameter("@flag", SqlDbType.VarChar)).SqlValue = "I";
                    cmd.Parameters.Add(new SqlParameter("@ShippingAddressId", SqlDbType.Int)).SqlValue = Id1;
                    

                    SqlDataAdapter da=new SqlDataAdapter(cmd);
                    da.Fill(dt);


                   Id=Convert.ToInt16(dt.Rows[0]["Id"]);
                    cmd.Parameters.Clear();

                    

                }
                cmd.Parameters.Clear();
                cmd.CommandText = "InsOrderDeails";
                cmd.Connection = conn;
              

                foreach (Orderlist ol in list)
                {

                   
                     cmd.Parameters.Add(new SqlParameter("@qunatity", SqlDbType.Int)).SqlValue = ol.quantity;
                     cmd.Parameters.Add(new SqlParameter("@BookId", SqlDbType.Int)).SqlValue = ol.Id;
                     cmd.Parameters.Add(new SqlParameter("@orderId", SqlDbType.BigInt)).SqlValue = Id;
                     cmd.Parameters.Add(new SqlParameter("@price", SqlDbType.Decimal)).SqlValue = ol.BookPrice;
                     cmd.Parameters.Add(new SqlParameter("@subtotal", SqlDbType.Decimal)).SqlValue = (ol.BookPrice * ol.quantity);
                     cmd.Parameters.Add(new SqlParameter("@flag", SqlDbType.VarChar)).SqlValue = "I";
                    cmd.ExecuteScalar();
                    cmd.Parameters.Clear();
                }
                tras.Commit();
            }
            catch (Exception ex) {
               // tras.Rollback();
                throw ex;
            }
            return dt;
        }
    }
}
