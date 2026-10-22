using System;
using System.Collections.Generic;
using System.Drawing;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OracleClient;
using System.Data;
using System.Reflection.Emit;
using System.Configuration;

namespace Salarizare
{
    public partial class ActualizareDate : System.Web.UI.Page
    {
        string connstr = ConfigurationManager.ConnectionStrings["OracleConn"].ConnectionString;
        protected void UploadData()
        {
            using (OracleConnection conn = new OracleConnection(connstr))
            {
                conn.Open();
                string query = "select * from angajati";
                using(OracleCommand cmd = new OracleCommand(query, conn))
                {
                    using(OracleDataAdapter da = new OracleDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        da.Fill(ds, "angajati");
                        GridView1.DataSource = ds.Tables["angajati"];
                        GridView1.DataBind();
                    }
                }
            }
        }

        protected void LoadData()
        {
            string nume_text = TextBox1.Text.Trim();
            string prenume_text = TextBox2.Text.Trim();

            using (OracleConnection conn = new OracleConnection(connstr))
            {
                string query;
                if(nume_text.Length > 0 && prenume_text.Length > 0)
                {
                    query = "SELECT * FROM ANGAJATI WHERE NUME = :nume AND PRENUME = :prenume";
                }
                else
                {
                    query = "SELECT * FROM ANGAJATI";
                }
                using (OracleCommand cmd = new OracleCommand(query, conn))
                {
                    if(nume_text.Length > 0 && prenume_text.Length > 0)
                    {
                        OracleParameter nume = cmd.Parameters.Add("nume", OracleType.Char, 50);
                        OracleParameter prenume = cmd.Parameters.Add("prenume", OracleType.Char, 50);

                        nume.Value = nume_text;
                        prenume.Value = prenume_text;
                    }

                    using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        da.Fill(ds, "angajati");
                        GridView1.DataSource = ds.Tables["angajati"];
                        GridView1.DataBind();

                        if(nume_text.Length > 0 && prenume_text.Length > 0)
                        {
                            int totalRows = ds.Tables[0].Rows.Count;
                            if (totalRows > 0)
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
                        }
                    }
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            LoadData();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            LoadData();
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            GridView1.EditIndex = -1;
            LoadData();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            object id = GridView1.DataKeys[e.RowIndex].Value;
            if (id != null)
            {
                int nrCrt = Convert.ToInt32(id);
                string Nume = e.NewValues["NUME"]?.ToString() ?? "";
                string Prenume = e.NewValues["PRENUME"]?.ToString() ?? "";
                string Functie = e.NewValues["FUNCTIE"]?.ToString() ?? "";
                int Salarbaza = Convert.ToInt32(e.NewValues["SALAR_BAZA"] ?? 0);
                int Spor = Convert.ToInt32(e.NewValues["SPOR"] ?? 0);
                int Premiibrute = Convert.ToInt32(e.NewValues["PREMII_BRUTE"] ?? 0);
                int Retineri = Convert.ToInt32(e.NewValues["RETINERI"] ?? 0);

                using (OracleConnection conn = new OracleConnection(connstr))
                {
                    conn.Open();

                    using (OracleCommand procedura = new OracleCommand("Calcule", conn))
                    {
                        procedura.CommandType = CommandType.StoredProcedure;
                        procedura.Parameters.Add("p_id", OracleType.Int32).Value = nrCrt;
                        procedura.Parameters.Add("p_salarBaza", OracleType.Int32).Value = Salarbaza;
                        procedura.Parameters.Add("p_spor", OracleType.Int32).Value = Spor;
                        procedura.Parameters.Add("p_premiiBrute", OracleType.Int32).Value = Premiibrute;
                        procedura.Parameters.Add("p_retineri", OracleType.Int32).Value = Retineri;
                        procedura.ExecuteNonQuery();
                    }

                    string query = "update angajati set nume = :nume, prenume = :prenume, functie = :functie, salar_baza = :salar_baza, spor = :spor, premii_brute = :premii_brute, retineri = :retineri where nr_crt = :nr_crt";
                    using (OracleCommand cmd = new OracleCommand(query, conn))
                    {
                        OracleParameter nr_crt = cmd.Parameters.Add("nr_crt", OracleType.Int32);
                        nr_crt.Value = nrCrt;
                        OracleParameter nume = cmd.Parameters.Add("nume", OracleType.Char);
                        nume.Value = Nume;
                        OracleParameter prenume = cmd.Parameters.Add("prenume", OracleType.Char);
                        prenume.Value = Prenume;
                        OracleParameter functie = cmd.Parameters.Add("functie", OracleType.Char);
                        functie.Value = Functie;
                        OracleParameter salar_baza = cmd.Parameters.Add("salar_baza", OracleType.Int32);
                        salar_baza.Value = Salarbaza;
                        OracleParameter spor = cmd.Parameters.Add("spor", OracleType.Int32);
                        spor.Value = Spor;
                        OracleParameter premii_brute = cmd.Parameters.Add("premii_brute", OracleType.Int32);
                        premii_brute.Value = Premiibrute;
                        OracleParameter retineri = cmd.Parameters.Add("retineri", OracleType.Int32);
                        retineri.Value = Retineri;
                        cmd.ExecuteNonQuery();
                    }
                }
                GridView1.EditIndex = -1;
                UploadData();
                TextBox1.Text = "";
                TextBox2.Text = "";
                Label5.Text = "";
            }
        }  
    }
}