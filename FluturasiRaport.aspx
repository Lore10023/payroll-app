<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FluturasiRaport.aspx.cs" Inherits="Salarizare.WebForm4" %><%@ Register assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <p>
    <br />
    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="50pt" ForeColor="#003399" Text="Fluturaşi"></asp:Label>
</p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Button ID="Button1" runat="server" BackColor="#003399" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" ForeColor="White" Height="56px" OnClick="Button1_Click" Text="Listare Fluturasi" Width="223px" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button2" runat="server" BackColor="#003399" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" ForeColor="White" Height="56px" OnClick="Button2_Click" Text="Listare Fluturas Pentru Un Singur Angajat" Width="370px" />
</p>
    <p>
        <asp:Label ID="Label3" runat="server"></asp:Label>
</p>
    <p>
        <asp:Label ID="Label5" runat="server" Text="Nume"></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
</p>
    <asp:Label ID="Label6" runat="server" Text="Prenume"></asp:Label>
&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
    <br />
    <p>
        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Cauta" />
</p>
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" ToolPanelView="None" />
    <br />
</asp:Content>
