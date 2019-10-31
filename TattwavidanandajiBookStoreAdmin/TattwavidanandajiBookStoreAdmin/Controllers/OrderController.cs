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
        [HttpPost]
        public DataTable SaveOrder(List<Orderlist> list)
        {
            DataTable dt = new DataTable();
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();
            try
            {

                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "ValidationUserLogins";
                cmd.Connection = conn;
                cmd.Connection.Open();

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
                    mail.Subject = "User registration - Email OTP";
                    mail.IsBodyHtml = true;

                    StringBuilder itemsList = new StringBuilder();
                    DateTime dtime = DateTime.Now;
                    dtime.AddDays(5);

                    int cnt = 1;
                    foreach (Orderlist m in list)
                    {
                        itemsList.Append("<tr>");

                        itemsList.Append("<td>");
                        itemsList.Append(cnt++);
                        itemsList.Append("</td>");

                        itemsList.Append("<td>");
                        itemsList.Append(m.BookTitle);
                        itemsList.Append("</td>");

                        itemsList.Append("<td>");
                        itemsList.Append(m.BookType);
                        itemsList.Append("</td>");

                        itemsList.Append("<td>");
                        itemsList.Append(m.quantity);
                        itemsList.Append("</td>");

                        //int subtotal = m.qty * m.perunit;

                        itemsList.Append("<td>");
                        itemsList.Append(m.BookStock);
                        itemsList.Append("</td>");

                        itemsList.Append("<td>");
                        itemsList.Append(m.BookDescription);
                        itemsList.Append("</td>");

                        itemsList.Append("<td>");
                        itemsList.Append(m.address);
                        itemsList.Append("</td>");

                        itemsList.Append("<td>");
                        itemsList.Append(m.name);
                        itemsList.Append("</td>");

                        itemsList.Append("<td>");
                        itemsList.Append(m.landmark);
                        itemsList.Append("</td>");

                        //int total = subtotal + m.tax + m.dis;

                        itemsList.Append("<td>");
                        itemsList.Append(m.mobileno);
                        itemsList.Append("</td>");

                        itemsList.Append("</tr>");
                    }
                    string verifcodeMail = @"<table>
                                        <tr>
                                            <td>
                                                <h3>Tender & sales order management demo</h3>
                                                <h4>Supplier Pricing quote</h4>
                                                <span>Please check the pricing quotes for below items</span>
                                                <table border=" + 1 + @">
                                                    <tr>
                                                        <td>
                                                            S.No
                                                        </td>
                                                        <td>Item name</td>
                                                        <td>Item description</td>
                                                        <td>No.Of Units</td>
                                                        <td>Perunit price</td>
                                                        <td>Sub Total</td>
                                                        <td>Tax</td>
                                                        <td>Discount</td>
                                                        <td>Total</td>                                                        
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











                //foreach (Orderlist ol in list)
                //{

                //    cmd.Parameters.Add(new SqlParameter("@BookDescription", SqlDbType.VarChar, 250)).SqlValue = ol.BookDescription;
                //    cmd.Parameters.Add(new SqlParameter("@BookImage", SqlDbType.VarChar, -1)).SqlValue = ol.BookImage;
                //    cmd.Parameters.Add(new SqlParameter("@BookPrice", SqlDbType.Int)).SqlValue = ol.BookPrice;
                //    cmd.Parameters.Add(new SqlParameter("@BookTitle", SqlDbType.VarChar, 250)).SqlValue = ol.BookTitle;
                //    cmd.Parameters.Add(new SqlParameter("@BookType", SqlDbType.VarChar, 250)).SqlValue = ol.BookType;
                //    cmd.Parameters.Add(new SqlParameter("@quantity", SqlDbType.Int)).SqlValue = ol.quantity;
                //    cmd.Parameters.Add(new SqlParameter("@Id", SqlDbType.Int)).SqlValue = ol.Id;
                //    cmd.Parameters.Add(new SqlParameter("@address", SqlDbType.VarChar, 250)).SqlValue = ol.address;
                //    cmd.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar, 250)).SqlValue = ol.email;
                //    cmd.Parameters.Add(new SqlParameter("@landmark", SqlDbType.VarChar, 250)).SqlValue = ol.landmark;
                //    cmd.Parameters.Add(new SqlParameter("@mobileno", SqlDbType.VarChar, 25)).SqlValue = ol.mobileno;
                //    cmd.Parameters.Add(new SqlParameter("@name", SqlDbType.VarChar, 100)).SqlValue = ol.name;
                //    cmd.Parameters.Add(new SqlParameter("@sname", SqlDbType.VarChar, 100)).SqlValue = ol.sname;
                //    cmd.Parameters.Add(new SqlParameter("@zipcode", SqlDbType.VarChar, 25)).SqlValue = ol.zipcode;

                //    cmd.ExecuteScalar();
                //    cmd.Parameters.Clear();
                //}
            }
            catch (Exception ex) {

                throw ex;
            }
            return dt;
        }
    }
}
