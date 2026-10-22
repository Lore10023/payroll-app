<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdaugareAngajati.aspx.cs" Inherits="Salarizare.AdaugareAngajati" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="50pt" ForeColor="#003399" Text="Adăugare angajaţi"></asp:Label>
<br />
<br />
<br />
<br />
&nbsp;&nbsp;&nbsp;
<asp:Label ID="Label2" runat="server" Text="NUME"></asp:Label>
&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="TextBox1" runat="server" Width="211px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" BackColor="#FFFF66" ControlToValidate="TextBox1" ErrorMessage="Trebuie sa introduceti numele angajatului!" ForeColor="Red"></asp:RequiredFieldValidator>
<br />
<br />
&nbsp;&nbsp;&nbsp;
<asp:Label ID="Label3" runat="server" Text="PRENUME"></asp:Label>
&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="TextBox2" runat="server" Width="212px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" BackColor="#FFFF66" ControlToValidate="TextBox2" ErrorMessage="Trebuie sa introduceti prenumele angajatului!" ForeColor="Red"></asp:RequiredFieldValidator>
<br />
<br />
&nbsp;&nbsp;&nbsp;
<asp:Label ID="Label4" runat="server" Text="FUNCTIE"></asp:Label>
&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="TextBox3" runat="server" Width="212px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" BackColor="#FFFF66" ControlToValidate="TextBox3" ErrorMessage="Trebuie sa introduceti functia angajatului!" ForeColor="Red"></asp:RequiredFieldValidator>
<br />
<br />
&nbsp;&nbsp;&nbsp;
<asp:Label ID="Label5" runat="server" Text="SALAR DE BAZA"></asp:Label>
&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="TextBox4" runat="server" Width="212px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
<asp:CompareValidator ID="CompareValidator3" runat="server" BackColor="#FFFF66" ControlToValidate="TextBox4" Display="Dynamic" ErrorMessage="Introduceti o valoare numerica valida pentru salariul de baza!" ForeColor="Red" Operator="GreaterThan" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
&nbsp;&nbsp;&nbsp;
    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" BackColor="#FFFF66" ControlToValidate="TextBox4" ErrorMessage="Trebuie sa introduceti o valoare numerica!" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
<br />
<br />
&nbsp;&nbsp;&nbsp;
<asp:Label ID="Label6" runat="server" Text="SPOR (%)"></asp:Label>
&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="TextBox5" runat="server" Width="212px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:RangeValidator ID="RangeValidator1" runat="server" BackColor="#FFFF66" ControlToValidate="TextBox5" ErrorMessage="Sporul trebuie sa fie un numar intreg între 0 si 100!" ForeColor="Red" MaximumValue="100" MinimumValue="0" Type="Integer" Display="Dynamic"></asp:RangeValidator>
&nbsp;&nbsp;&nbsp;
    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" BackColor="#FFFF66" ControlToValidate="TextBox5" ErrorMessage="Trebuie sa introduceti o valoare numerica!" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
<br />
<br />
&nbsp;&nbsp;&nbsp;
<asp:Label ID="Label7" runat="server" Text="PREMII BRUTE"></asp:Label>
&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="TextBox6" runat="server" Width="212px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
<asp:CompareValidator ID="CompareValidator1" runat="server" BackColor="#FFFF66" ControlToValidate="TextBox6" ErrorMessage="Introduceti o suma valida pentru premii brute!" ForeColor="Red" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0" Display="Dynamic"></asp:CompareValidator>
&nbsp;&nbsp;&nbsp;
    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" BackColor="#FFFF66" ControlToValidate="TextBox6" ErrorMessage="Trebuie sa introduceti o valoare numerica!" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
<br />
<br />
&nbsp;&nbsp;&nbsp;
<asp:Label ID="Label8" runat="server" Text="RETINERI"></asp:Label>
&nbsp;&nbsp;&nbsp;
<asp:TextBox ID="TextBox7" runat="server" Width="210px"></asp:TextBox>
    &nbsp;&nbsp;&nbsp;
    <asp:CompareValidator ID="CompareValidator2" runat="server" BackColor="#FFFF66" ControlToValidate="TextBox7" ErrorMessage="Introduceti o suma valida pentru retineri!" ForeColor="Red" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0" Display="Dynamic"></asp:CompareValidator>
    &nbsp;&nbsp;&nbsp;
    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" BackColor="#FFFF66" ControlToValidate="TextBox7" ErrorMessage="Trebuie sa introduceti o valoare numerica!" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
    <br />
    <br />
&nbsp;&nbsp;&nbsp;
<asp:Label ID="Label10" runat="server" Text="POZA"></asp:Label>
&nbsp;&nbsp;&nbsp;
    <asp:FileUpload ID="FileUpload1" runat="server" />
&nbsp;&nbsp;&nbsp;
    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" BackColor="#FFFF66" ControlToValidate="FileUpload1" ErrorMessage="Trebuie sa incarcati poza angajatului!" ForeColor="Red"></asp:RequiredFieldValidator>
<br />
<br />
&nbsp;&nbsp;&nbsp;
<asp:Button ID="Button1" runat="server" Text="Adaugare angajat" OnClick="Button1_Click" BackColor="#003399" BorderStyle="None" Font-Bold="True" ForeColor="White" Height="52px" Width="193px" />
<br />
<br />
&nbsp;&nbsp;&nbsp;
<asp:Label ID="Label9" runat="server" Font-Bold="True" ForeColor="#CC3300"></asp:Label>
<br />
<br />
<asp:GridView ID="GridView1" runat="server" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" CellPadding="10" GridLines="Vertical">
    <EditRowStyle BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
    <HeaderStyle BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
    <PagerStyle BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
</asp:GridView>
    <br />
&nbsp;&nbsp;&nbsp;
    <asp:Image ID="Image3" runat="server" Height="147px" Width="165px" />
    <br />
<br />
</asp:Content>
