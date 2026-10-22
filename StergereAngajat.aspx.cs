using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OracleClient;
using System.Data;
using System.Configuration;

namespace Salarizare
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
      
        }

        string connstr = ConfigurationManager.ConnectionStrings["OracleConn"].ConnectionString;

        protected void RefreshDataGridView()
        {
            try
            {
                OracleConnection conn = new OracleConnection(connstr);
                conn.Open();

                string query = "select * from angajati where nume = :nume and prenume = :prenume";
                OracleCommand cmd = new OracleCommand(query, conn);
                OracleParameter nume = cmd.Parameters.Add("nume", OracleType.Char, 50);
                OracleParameter prenume = cmd.Parameters.Add("prenume", OracleType.Char, 50);

                nume.Value = TextBox1.Text;
                prenume.Value = TextBox2.Text;

                OracleDataAdapter da = new OracleDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds, "angajati");
                GridView1.DataSource = ds.Tables["angajati"].DefaultView;
                GridView1.DataBind();
                conn.Close();
            }
            catch (Exception ex)
            {
                Label6.Text = "Eroare" + ex.Message;
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                OracleConnection conn = new OracleConnection(connstr);
                conn.Open();

                string query = "select * from angajati where nume = :nume and prenume = :prenume";
                OracleCommand cmd = new OracleCommand(query, conn);
                OracleParameter nume = cmd.Parameters.Add("nume", OracleType.Char, 50);
                OracleParameter prenume = cmd.Parameters.Add("prenume", OracleType.Char, 50);

                nume.Value = TextBox1.Text;
                prenume.Value = TextBox2.Text;

                OracleDataAdapter da = new OracleDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds, "angajati");
                int totalRows = ds.Tables[0].Rows.Count;

                if (totalRows > 0 )
                {
                    GridView1.DataSource = ds.Tables["angajati"].DefaultView;
                    GridView1.DataBind();
                    Label5.Text = "Numarul de inregistrari gasite: " + totalRows;
                }
                else
                {
                    Label5.ForeColor = System.Drawing.Color.Red;
                    Label5.Text = "Nu exista un angajat cu numele si prenumele inserate!";
                }
                conn.Close();
            }
            catch (Exception ex)
            {
                Label6.Text = "Eroare" + ex.Message;
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            object id = GridView1.DataKeys[e.RowIndex].Value;
            if( id != null )
            {
                int nrCrt = Convert.ToInt32(id);
                using (OracleConnection conn = new OracleConnection(connstr))
                {
                    conn.Open();

                    string query = "delete from angajati where nr_crt = :nr_crt";
                    using (OracleCommand cmd = new OracleCommand(query, conn))
                    {
                        OracleParameter nr_crt = cmd.Parameters.Add("nr_crt", OracleType.Int32);
                        nr_crt.Value = nrCrt;
                        int rowaffected = cmd.ExecuteNonQuery();
                        if (rowaffected > 0)
                        {
                            Label5.ForeColor = System.Drawing.Color.Green;
                            Label5.Text = "Inregistrarea a fost stearsa cu succes!";
                            RefreshDataGridView();
                        }
                    }
                }
                
                    
            }
        }
    }
}