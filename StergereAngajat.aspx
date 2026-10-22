<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="StergereAngajat.aspx.cs" Inherits="Salarizare.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
<asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="50pt" ForeColor="#003399" Text=" Ştergere angajaţi"></asp:Label>
<br />
<br />
<table style="border: 1px solid #003366; padding: 10px; width: 713px; background-color: #CCFFFF;">
    <tr>
        <td style="border: 1px solid #003366; width: 506px; height: 78px;">
            <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="15pt" Text="NUME"></asp:Label>
        </td>
        <td style="border: 1px solid #003366; width: 1194px; height: 78px;">
            <asp:TextBox ID="TextBox1" runat="server" Width="461px"></asp:TextBox>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" BackColor="Red" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Introduceti un nume!" ForeColor="White"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td style="width: 506px; height: 78px">
            <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="15pt" Text="PRENUME"></asp:Label>
        </td>
        <td style="border: 1px solid #003366; width: 1194px; height: 78px">
            <asp:TextBox ID="TextBox2" runat="server" style="margin-left: 45" Width="460px"></asp:TextBox>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" BackColor="Red" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Introduceti un prenume!" ForeColor="White"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td style="border: 1px solid #003366; width: 506px; height: 61px;"></td>
        <td style="border: 1px solid #003366; width: 1194px; height: 61px;">
            <asp:Button ID="Button1" runat="server" BackColor="#003399" BorderStyle="None" Font-Size="13pt" ForeColor="White" Height="43px" Text="Cautare Angajat" Width="179px" OnClick="Button1_Click" />
        </td>
    </tr>
</table>
<br />
<br />
<asp:Label ID="Label5" runat="server" ForeColor="#993333"></asp:Label>
    <br />
<br />
<asp:GridView ID="GridView1" runat="server" CellPadding="10" AutoGenerateColumns="False" DataKeyNames="NR_CRT" OnRowDeleting="GridView1_RowDeleting">
    <Columns>
        <asp:CommandField ShowDeleteButton="True" ButtonType="Button" DeleteText="Stergere" />
        <asp:BoundField DataField="NR_CRT" HeaderText="NR_CRT" ReadOnly="True" SortExpression="NR_CRT" />
        <asp:BoundField DataField="NUME" HeaderText="NUME" SortExpression="NUME" />
        <asp:BoundField DataField="PRENUME" HeaderText="PRENUME" SortExpression="PRENUME" />
        <asp:BoundField DataField="FUNCTIE" HeaderText="FUNCTIE" SortExpression="FUNCTIE" />
        <asp:BoundField DataField="SALAR_BAZA" HeaderText="SALAR_BAZA" SortExpression="SALAR_BAZA" />
        <asp:BoundField DataField="SPOR" HeaderText="SPOR" SortExpression="SPOR" />
        <asp:BoundField DataField="PREMII_BRUTE" HeaderText="PREMII_BRUTE" SortExpression="PREMII_BRUTE" />
        <asp:BoundField DataField="TOTAL_BRUT" HeaderText="TOTAL_BRUT" SortExpression="TOTAL_BRUT" />
        <asp:BoundField DataField="BRUT_IMPOZABIL" HeaderText="BRUT_IMPOZABIL" SortExpression="BRUT_IMPOZABIL" />
        <asp:BoundField DataField="IMPOZIT" HeaderText="IMPOZIT" SortExpression="IMPOZIT" />
        <asp:BoundField DataField="CAS" HeaderText="CAS" SortExpression="CAS" />
        <asp:BoundField DataField="CASS" HeaderText="CASS" SortExpression="CASS" />
        <asp:BoundField DataField="RETINERI" HeaderText="RETINERI" SortExpression="RETINERI" />
        <asp:BoundField DataField="VIRAT_CARD" HeaderText="VIRAT_CARD" SortExpression="VIRAT_CARD" />
    </Columns>
</asp:GridView>
    <asp:Label ID="Label6" runat="server"></asp:Label>
    <br />
<br />
</asp:Content>
