<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StatPlata.aspx.cs" Inherits="Salarizare.WebForm3" %><%@ Register assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <p>
    <br />
    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="50pt" ForeColor="#003399" Text="Stat plata"></asp:Label>
</p>
<p>
</p>
<p>
    <asp:Button ID="Button1" runat="server" BackColor="#003399" BorderColor="Black" BorderStyle="Solid" BorderWidth="2px" ForeColor="White" Height="61px" OnClick="Button1_Click" Text="Listare Raport" Width="196px" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="TextBox1" runat="server" Width="277px"></asp:TextBox>
    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Salvare PDF" Width="155px" />
&nbsp;&nbsp;&nbsp;
    <asp:Label ID="Label3" runat="server"></asp:Label>
</p>
    <p>
        &nbsp;</p>
    <p>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" ToolPanelView="None" />
    <p>
        &nbsp;</p>
</asp:Content>
