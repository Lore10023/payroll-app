using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OracleClient;
using System.Data;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.ComponentModel;
using System.Globalization;
using System.Configuration;

namespace Salarizare
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        string connstr = ConfigurationManager.ConnectionStrings["OracleConn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TextBox1.Visible = false;
                Button2.Visible = false;
            }
            else
            {
                using(OracleConnection conn = new OracleConnection(connstr))
                {
                    try
                    {
                        conn.Open();
                        UploadReport(conn);
                    }catch (Exception ex)
                    {
                        Label3.Text = ex.Message;
                    }
                }
            }
        }

        ReportDocument report = new ReportDocument();
        
        protected void UploadReport(OracleConnection conn)
        {
            string query = "select nr_crt, nume, prenume, functie, salar_baza, spor, premii_brute, total_brut, brut_impozabil, impozit, cas, cass, retineri, virat_card from angajati";
            using (OracleCommand cmd = new OracleCommand(query, conn))
            {
                using (OracleDataAdapter da = new OracleDataAdapter(cmd))
                {     
                    DataSet ds = new DataSet();
                    da.Fill(ds, "angajati");
                    string cale = Server.MapPath("StatPlataReport.rpt");
                    report.Load(cale);
                    report.SetDataSource(ds.Tables["angajati"]);
                    CrystalReportViewer1.ReportSource = report;
                }
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            using (OracleConnection conn = new OracleConnection(connstr))
            {
                try
                {
                    conn.Open();
                    UploadReport(conn);
                }
                catch (Exception ex) {
                    Label3.Text = ex.Message;
                }
            }
            TextBox1.Visible = true;
            Button2.Visible = true;
            string lunaCurenta = DateTime.Now.ToString("MMMM", new CultureInfo("ro-RO"));
            TextBox1.Text = "Stat_Plata_Luna_" + lunaCurenta.ToUpper();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                using(OracleConnection conn = new OracleConnection(connstr)){
                    conn.Open();
                    UploadReport(conn);
                }
                DiskFileDestinationOptions fisier = new DiskFileDestinationOptions();
                report.ExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
                report.ExportOptions.ExportFormatType = ExportFormatType.PortableDocFormat;
                fisier.DiskFileName = Server.MapPath("~/PDF/" + TextBox1.Text + ".pdf");
                report.ExportOptions.DestinationOptions = fisier;
                report.Export();
                Label3.Text = "Fisierul \"" + TextBox1.Text + "\" a fost salvat cu succes in folderul PDF!";
                Label3.ForeColor = System.Drawing.Color.Green;
            }catch (Exception ex)
            {
                Label3.Text = ex.Message;
            }
        }
    }
}