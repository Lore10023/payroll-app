using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OracleClient;
using System.Data;
using System.Security.Cryptography;
using System.Collections.Specialized;
using Microsoft.Ajax.Utilities;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;

namespace Salarizare
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        string connstr = ConfigurationManager.ConnectionStrings["OracleConn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected string HashFunction(string password_text)
        {
            if (string.IsNullOrEmpty(password_text))
            {
                return string.Empty;
            }
            using(SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes= Encoding.UTF8.GetBytes(password_text);
                byte[] hash_byte = sha256.ComputeHash(bytes);
                StringBuilder sb = new StringBuilder();
                foreach (byte b in hash_byte)
                {
                    sb.Append(b.ToString("X2"));
                }
                return sb.ToString();
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            using(OracleConnection conn = new OracleConnection(connstr))
            {
                conn.Open();
                string query = "select id,cas,cass,impozit from procente";
                string pass_query = "select parola from procente";
                string password_hash;
                string password_text = TextBox1.Text;
                int ok=0;
                password_hash = HashFunction(password_text);

                using(OracleCommand cmd = new OracleCommand(pass_query, conn))
                {
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        string db_password = result.ToString();
                        if(string.Equals(password_hash, db_password, StringComparison.OrdinalIgnoreCase))
                        {
                            ok = 1;
                        }
                        else
                        {
                            ok = 0;
                        }
                    }
                }

                using (OracleCommand cmd = new OracleCommand(query, conn))
                {
                    using(OracleDataAdapter da = new OracleDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        da.Fill(ds, "procente");

                        if(ds.Tables[0].Rows.Count > 0 && ok==1)
                        {
                            GridView1.DataSource = ds.Tables["procente"].DefaultView;
                            GridView1.DataBind();
                            Button1.Visible = false;
                            TextBox1.Visible = false;
                            Label3.Text = "Parola corecta!";
                            Label3.ForeColor = System.Drawing.Color.Green;
                        }
                        else
                        {
                            Label3.Text = "Parola incorecta! Incercati inca o data:";
                            Label3.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
        }
        protected void UploadData()
        {
            string query = "select id,cas,cass,impozit from procente";
            using (OracleConnection conn = new OracleConnection(connstr))
            {
                conn.Open();
                using(OracleCommand cmd = new OracleCommand(query, conn))
                {
                    using(OracleDataAdapter da = new OracleDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        da.Fill(ds, "procente");
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            GridView1.DataSource = ds.Tables["procente"].DefaultView;
                            GridView1.DataBind();
                            
                        }
                    }
                }
            }
        }
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            UploadData();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            UploadData();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            object Id = GridView1.DataKeys[e.RowIndex].Value;
            if (Id != null)
            {
                int Cas = Convert.ToInt32(e.NewValues["CAS"] ?? 0);
                int Cass = Convert.ToInt32(e.NewValues["CASS"] ?? 0);
                int Impozit = Convert.ToInt32(e.NewValues["IMPOZIT"] ?? 0);

                using (OracleConnection conn = new OracleConnection(connstr))
                {
                    conn.Open();
                    string query = "update procente set cas = :cas, cass = :cass, impozit = :impozit where id = :id";

                    using (OracleCommand cmd = new OracleCommand(query, conn))
                    {
                        OracleParameter id = cmd.Parameters.Add("id",OracleType.Int16);
                        OracleParameter cas = cmd.Parameters.Add("cas", OracleType.Int16);
                        OracleParameter cass = cmd.Parameters.Add("cass", OracleType.Int16);
                        OracleParameter impozit = cmd.Parameters.Add("impozit", OracleType.Int16);
                        id.Value = Convert.ToInt32(Id);
                        cas.Value = Cas;
                        cass.Value = Cass;
                        impozit.Value = Impozit;
                        cmd.ExecuteNonQuery();
                    }

                    string select_query = "select nr_crt,salar_baza,spor,premii_brute,retineri from angajati";
                    DataTable dt = new DataTable();
                    using(OracleDataAdapter da = new OracleDataAdapter(select_query, conn))
                    {
                        da.Fill(dt);
                    }

                    using (OracleCommand procedura = new OracleCommand("Calcule", conn))
                    {
                        
                        int nr_crt,salar_baza,spor,premii_brute,retineri;
                        using (OracleCommand cmd = new OracleCommand(select_query, conn))
                        {
                            procedura.CommandType = CommandType.StoredProcedure;
                            var pid = procedura.Parameters.Add("p_id", OracleType.Int32);
                            var psalarbaza = procedura.Parameters.Add("p_salarBaza", OracleType.Int32);
                            var pspor = procedura.Parameters.Add("p_spor", OracleType.Int32);
                            var ppremiibrute = procedura.Parameters.Add("p_premiiBrute", OracleType.Int32);
                            var pretineri = procedura.Parameters.Add("p_retineri", OracleType.Int32);

                            foreach(DataRow dr in dt.Rows )
                            {
                                pid.Value = Convert.ToInt32(dr["nr_crt"]);
                                psalarbaza.Value = Convert.ToInt32(dr["salar_baza"]);
                                pspor.Value = Convert.ToInt32(dr["spor"]);
                                ppremiibrute.Value = Convert.ToInt32(dr["premii_brute"]);
                                pretineri.Value = Convert.ToInt32(dr["retineri"]);
                                procedura.ExecuteNonQuery();
                            }
                        }    
                    }
                }
                Label3.Text = "Valoriile din baza de date au fost modificate cu succes";
                Label3.ForeColor = System.Drawing.Color.Green;
                GridView1.EditIndex = -1;
                UploadData();
            }
        }
    }
}