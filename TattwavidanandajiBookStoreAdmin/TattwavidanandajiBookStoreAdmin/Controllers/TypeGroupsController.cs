using TattwavidanandajiBookStoreAdmin.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Tracing;

namespace TattwavidanandajiBookStoreAdmin.Controllers
{
    public class TypeGroupsController : ApiController
    {
        [HttpGet]
        [Route("api/TypeGroups/GetTypeGroupsconfig")]
        public DataTable gettypegroups()
        {
            DataTable Tbl = new DataTable();
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();
            try
            {
                
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "GetTypeGroupsconfig";
                cmd.Connection = conn;
                
                SqlDataAdapter db = new SqlDataAdapter(cmd);
                db.Fill(Tbl);
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
           
            return Tbl;
        }
         [HttpGet]
         [Route("api/TypeGroups/gettypegroups")]
        public DataSet gettypegroups(int curpage,int maxrows)
        {
            DataTable Tbl = new DataTable();

           // LogTraceWriter traceWriter = new LogTraceWriter();
           // traceWriter.Trace(Request, "0", TraceLevel.Info, "{0}", "gettypegroups credentials....");
            //connect to database
            SqlConnection conn = new SqlConnection();
            //connetionString="Data Source=ServerName;Initial Catalog=DatabaseName;User ID=UserName;Password=Password"
            conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();

            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "GetTypegroups";
            cmd.Connection = conn;


            cmd.Parameters.Add(new SqlParameter("@curpage", SqlDbType.Int)).SqlValue = curpage;
            cmd.Parameters.Add(new SqlParameter("@maxrows", SqlDbType.Int)).SqlValue = maxrows;


            DataSet ds = new DataSet();
            SqlDataAdapter db = new SqlDataAdapter(cmd);
            db.Fill(ds);
        
           // traceWriter.Trace(Request, "0", TraceLevel.Info, "{0}", "gettypegroups Credentials completed.");
            // int found = 0;
            return ds;
        }
          [HttpPost]
         public HttpResponseMessage savetypegroups(TypeGroups b)
        {

            //LogTraceWriter traceWriter = new LogTraceWriter();
           // traceWriter.Trace(Request, "0", TraceLevel.Info, "{0}", "savetypegroups credentials....");

            //connect to database
            SqlConnection conn = new SqlConnection();
              try
              { 
            //connetionString="Data Source=ServerName;Initial Catalog=DatabaseName;User ID=UserName;Password=Password"
                  conn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["VIHE_DB_Connection"].ToString();
          
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "InsUpdTypeGroups";
            cmd.Connection = conn;
            conn.Open();
         

            SqlParameter Gid = new SqlParameter();
            Gid.ParameterName = "@Name";
            Gid.SqlDbType = SqlDbType.VarChar;
            Gid.Value = b.Name;
            cmd.Parameters.Add(Gid);

            SqlParameter Gim = new SqlParameter();
            Gim.ParameterName = "@Id";
            Gim.SqlDbType = SqlDbType.Int;
            Gim.Value = Convert.ToString(b.Id);
            cmd.Parameters.Add(Gim);

            SqlParameter pid = new SqlParameter();
            pid.ParameterName = "@Description";
            pid.SqlDbType = SqlDbType.VarChar;
            pid.Value = b.Description;
            cmd.Parameters.Add(pid);

            SqlParameter llid = new SqlParameter();
            llid.ParameterName = "@Active";
            llid.SqlDbType = SqlDbType.Int;
            llid.Value = 1;// b.Active;
            //llid.Value = b.Active;
            cmd.Parameters.Add(llid);

            SqlParameter flag = new SqlParameter();
            flag.ParameterName = "@insupdflag";
            flag.SqlDbType = SqlDbType.VarChar;
            flag.Value = b.insupddelflag;
            cmd.Parameters.Add(flag);
           
           
          
            //DataSet ds = new DataSet();
            //SqlDataAdapter db = new SqlDataAdapter(cmd);
            //db.Fill(ds);
           // Tbl = Tables[0];
            cmd.ExecuteScalar();
            conn.Close();
            //traceWriter.Trace(Request, "0", TraceLevel.Info, "{0}", "savetypegroups Credentials completed.");
            return new HttpResponseMessage(HttpStatusCode.OK);
              }
              catch (Exception ex)
              {
                  if (conn != null && conn.State == ConnectionState.Open)
                  {
                      conn.Close();
                  }
                  string str = ex.Message;

                 // traceWriter.Trace(Request, "1", TraceLevel.Info, "{0}", "Error in savetypegroups:" + ex.Message);
                  return Request.CreateErrorResponse(HttpStatusCode.NotFound, ex);
              }
        }
        public void Options() { }

    }
    }

