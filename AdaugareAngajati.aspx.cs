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
    public partial class AdaugareAngajati : System.Web.UI.Page
    {
        string connstr = ConfigurationManager.ConnectionStrings["OracleConn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            int default_value = 0;
            TextBox5.Text = default_value.ToString();
            TextBox6.Text = default_value.ToString();
            TextBox7.Text = default_value.ToString();
        }
        protected byte[] GetUploadedFile()
        {
            if (FileUpload1.PostedFile != null)
            {
                HttpPostedFile File = FileUpload1.PostedFile;
                byte[] Data = new Byte[File.ContentLength];

                File.InputStream.Read(Data, 0, File.ContentLength);
                return Data;
            }
            return null;
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                byte[] image = GetUploadedFile();

                OracleConnection conn = new OracleConnection(connstr);
                conn.Open();

                string query= @"insert into angajati (nume, prenume, functie, salar_baza, spor, premii_brute, retineri, poza) values (:p1, :p2, :p3, :p4, :p5, :p6, :p7, :p8) returning nr_crt into :newId";
                OracleCommand cmd = new OracleCommand(query, conn);
                OracleParameter p1 = cmd.Parameters.Add("p1", OracleType.Char, 50);
                OracleParameter p2 = cmd.Parameters.Add("p2", OracleType.Char, 50);
                OracleParameter p3 = cmd.Parameters.Add("p3", OracleType.Char, 50);
                OracleParameter p4 = cmd.Parameters.Add("p4", OracleType.Int32, 9);
                OracleParameter p5 = cmd.Parameters.Add("p5", OracleType.Int32, 9);
                OracleParameter p6 = cmd.Parameters.Add("p6", OracleType.Int32, 9);
                OracleParameter p7 = cmd.Parameters.Add("p7", OracleType.Int32, 9);
                OracleParameter p8 = new OracleParameter("p8", OracleType.Blob);
                p8.Value = (object)image ?? DBNull.Value;
                cmd.Parameters.Add(p8);

                p1.Value = TextBox1.Text;
                p2.Value = TextBox2.Text;
                p3.Value = TextBox3.Text;
                p4.Value = TextBox4.Text;
                p5.Value = Convert.ToInt64(TextBox5.Text);
                p6.Value = Convert.ToInt64(TextBox6.Text);
                p7.Value = Convert.ToInt64(TextBox7.Text);

                OracleParameter output_id = new OracleParameter(":newId", OracleType.Int32)
                {
                    Direction = ParameterDirection.Output
                };
                cmd.Parameters.Add(output_id);

                cmd.ExecuteNonQuery();

                int id = Convert.ToInt32(output_id.Value);

                //apelare procedura stocata Calcule
                OracleCommand procedura = new OracleCommand("Calcule", conn);
                procedura.CommandType = CommandType.StoredProcedure;

                procedura.Parameters.Add("p_id", OracleType.Int32).Value = id;
                procedura.Parameters.Add("p_salarBaza", OracleType.Int32).Value = int.Parse(TextBox4.Text);
                procedura.Parameters.Add("p_spor", OracleType.Int32).Value = int.Parse(TextBox5.Text);
                procedura.Parameters.Add("p_premiiBrute", OracleType.Int32).Value = int.Parse(TextBox6.Text);
                procedura.Parameters.Add("p_retineri", OracleType.Int32).Value = int.Parse(TextBox7.Text);

                procedura.ExecuteNonQuery();

                //afisare in gridview a angajatului nou adaugat
                string str = "select * from angajati where nr_crt= :id";
                OracleCommand gridview_cmd = new OracleCommand(str,conn);
                gridview_cmd.Parameters.Add("id",OracleType.Int32).Value=id;

                OracleDataAdapter da = new OracleDataAdapter(gridview_cmd);
                DataSet ds = new DataSet();
                da.Fill(ds, "angajati");
                GridView1.DataSource = ds.Tables["angajati"].DefaultView;
                GridView1.DataBind();

                if(image != null && image.Length > 0)
                {
                    string base64String = Convert.ToBase64String(image);
                    Image3.ImageUrl = "data:image/jpeg;base64," + base64String;
                    Image3.Visible = true;
                }
                else
                {
                    Image3.Visible=false;
                }

                Label9.Text = "Angajat adaugat cu succes!!";

                TextBox1.Text = "";
                TextBox2.Text = "";
                TextBox3.Text = "";
                TextBox4.Text = "";
                TextBox5.Text = Convert.ToString(0);
                TextBox6.Text = Convert.ToString(0); ;
                TextBox7.Text = Convert.ToString(0); ;

                conn.Close();
            }
            catch (Exception ex) {
                Label9.Text = "Eroare: " + ex.Message;
            }
        }
    }
}