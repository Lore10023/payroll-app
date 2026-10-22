using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OracleClient;
using System.Data;
using CrystalDecisions.CrystalReports.Engine;
using System.Configuration;

namespace Salarizare
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        string connstr = ConfigurationManager.ConnectionStrings["OracleConn"].ConnectionString;
        ReportDocument report = new ReportDocument();
        protected void Page_Load(object sender, EventArgs e)
        {
           if (!IsPostBack)
            {
                Label5.Visible = false;
                Label6.Visible = false;
                Button3.Visible = false;
                TextBox3.Visible = false;
                TextBox4.Visible = false;
            }
            else
            {
                string mod = (string)ViewState["mod"];
                if (mod == "toti")
                    UploadCrystalReport();
                else if (mod == "filtrat")
                    Button3_Click(sender, e);
            }
        }

        protected void UploadCrystalReport()
        {
            using (OracleConnection conn = new OracleConnection(connstr))
            {
                try
                {
                    conn.Open();
                    string query = "select nr_crt, nume, prenume, functie, salar_baza, spor, premii_brute, total_brut, brut_impozabil, impozit, cas, cass, retineri, virat_card from angajati";
                    using (OracleCommand cmd = new OracleCommand(query, conn))
                    {
                        using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                        {
                            DataSet ds = new DataSet();
                            da.Fill(ds,"angajati");
                            string cale = Server.MapPath("FluturasReport.rpt");
                            report.Load(cale);
                            report.SetDataSource(ds.Tables["angajati"]);
                            CrystalReportViewer1.ReportSource = report;
                        }
                    }
                }
                catch (Exception ex)
                {
                    Label3.Text = ex.Message;
                }
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            ViewState["mod"] = "toti";
            CrystalReportViewer1.Visible = true;
            UploadCrystalReport();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            ViewState["mod"] = null;
            Label5.Visible = true;
            Label6.Visible = true;
            Button3.Visible = true;
            TextBox3.Visible = true;
            TextBox4.Visible = true;
            CrystalReportViewer1.Visible = false;
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            ViewState["mod"] = "filtrat";
            CrystalReportViewer1.Visible = true;
            using (OracleConnection conn = new OracleConnection(connstr))
            {
                try
                {
                    conn.Open();
                    string query = "select nr_crt, nume, prenume, functie, salar_baza, spor, premii_brute, total_brut, brut_impozabil, impozit, cas, cass, retineri, virat_card from angajati where nume = :nume and prenume = :prenume";
                    using(OracleCommand cmd = new OracleCommand(query, conn))
                    {
                        OracleParameter nume = cmd.Parameters.Add("nume", OracleType.VarChar,50);
                        OracleParameter prenume = cmd.Parameters.Add("prenume", OracleType.VarChar,50);
                        nume.Value = TextBox4.Text.Trim();
                        prenume.Value = TextBox3.Text.Trim();
                        using(OracleDataAdapter da = new OracleDataAdapter(cmd))
                        {
                            DataSet ds = new DataSet();
                            da.Fill(ds, "angajati");

                            if (ds.Tables["angajati"].Rows.Count == 0)
                            {
                                Label3.Text = "Nu a fost găsit niciun angajat cu acest nume și prenume!";
                                Label3.ForeColor = System.Drawing.Color.Red;
                                CrystalReportViewer1.Visible = false;
                                return;
                            }

                            string cale = Server.MapPath("FluturasReport.rpt");
                            report.Load(cale);
                            report.SetDataSource(ds.Tables["angajati"]);
                            CrystalReportViewer1.ReportSource = report;
                        }
                    }
                }
                catch (Exception ex)
                {
                    Label3.Text = ex.Message;
                }
            }
        }
    }
}