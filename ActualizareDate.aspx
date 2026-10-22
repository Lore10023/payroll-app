<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActualizareDate.aspx.cs" Inherits="Salarizare.ActualizareDate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <p>
    <br />
    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="50pt" ForeColor="#003399" Text="Actualizare date"></asp:Label>
</p>
<table style="border: 1px solid #003366; padding: 10px; width: 713px; background-color: #CCFFFF;">
    <tr>
        <td style="border: 1px solid #003366; width: 506px; height: 78px;">
            <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="15pt" Text="NUME"></asp:Label>
        </td>
        <td style="border: 1px solid #003366; width: 1194px; height: 78px;">
            <asp:TextBox ID="TextBox1" runat="server" Width="461px"></asp:TextBox>
            <br />
        </td>
    </tr>
    <tr>
        <td style="width: 506px; height: 78px">
            <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="15pt" Text="PRENUME"></asp:Label>
        </td>
        <td style="border: 1px solid #003366; width: 1194px; height: 78px">
            <asp:TextBox ID="TextBox2" runat="server" style="margin-left: 45" Width="460px"></asp:TextBox>
            <br />
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
    <asp:Label ID="Label5" runat="server"></asp:Label>
    <br />
<br />
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="NR_CRT" CellPadding="10" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating">
    <Columns>
        <asp:CommandField ButtonType="Button" ShowEditButton="True" />
        <asp:BoundField DataField="NR_CRT" HeaderText="NR_CRT" ReadOnly="True" SortExpression="NR_CRT" />
        <asp:TemplateField HeaderText="NUME" SortExpression="NUME">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("NUME") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="Trebuie sa introduceti numele angajatului!" ForeColor="Red"></asp:RequiredFieldValidator>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("NUME") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="PRENUME" SortExpression="PRENUME">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("PRENUME") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="Trebuie sa introduceti prenumele angajatului!" ForeColor="Red"></asp:RequiredFieldValidator>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("PRENUME") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="FUNCTIE" SortExpression="FUNCTIE">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("FUNCTIE") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="Trebuie sa introduceti functia angajatului!" ForeColor="Red"></asp:RequiredFieldValidator>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Bind("FUNCTIE") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="SALAR_BAZA" SortExpression="SALAR_BAZA">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("SALAR_BAZA") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox4" Display="Dynamic" ErrorMessage="Trebuie sa introduceti o valoare numerica!" ForeColor="Red"></asp:RequiredFieldValidator>
                <br />
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="TextBox4" Display="Dynamic" ErrorMessage="Introduceti o valoare numerica valida pentru salariul de baza!" ForeColor="Red" Operator="GreaterThan" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# Bind("SALAR_BAZA") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="SPOR" SortExpression="SPOR">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("SPOR") %>'></asp:TextBox>
                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TextBox5" Display="Dynamic" ErrorMessage="Sporul trebuie sa fie un numar intreg între 0 si 100!" ForeColor="Red" MaximumValue="100" MinimumValue="0" Type="Integer"></asp:RangeValidator>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox5" Display="Dynamic" ErrorMessage="Trebuie sa introduceti o valoare numerica!" ForeColor="Red"></asp:RequiredFieldValidator>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label5" runat="server" Text='<%# Bind("SPOR") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="PREMII_BRUTE" SortExpression="PREMII_BRUTE">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("PREMII_BRUTE") %>'></asp:TextBox>
                <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="TextBox6" Display="Dynamic" ErrorMessage="Introduceti o suma valida pentru premii brute!" ForeColor="Red" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TextBox6" Display="Dynamic" ErrorMessage="Trebuie sa introduceti o valoare numerica!" ForeColor="Red"></asp:RequiredFieldValidator>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label6" runat="server" Text='<%# Bind("PREMII_BRUTE") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="TOTAL_BRUT" HeaderText="TOTAL_BRUT" SortExpression="TOTAL_BRUT" InsertVisible="False" ReadOnly="True" />
        <asp:BoundField DataField="BRUT_IMPOZABIL" HeaderText="BRUT_IMPOZABIL" InsertVisible="False" SortExpression="BRUT_IMPOZABIL" ReadOnly="True" />
        <asp:BoundField DataField="IMPOZIT" HeaderText="IMPOZIT" InsertVisible="False" SortExpression="IMPOZIT" ReadOnly="True" />
        <asp:BoundField DataField="CAS" HeaderText="CAS" InsertVisible="False" SortExpression="CAS" ReadOnly="True" />
        <asp:BoundField DataField="CASS" HeaderText="CASS" InsertVisible="False" SortExpression="CASS" ReadOnly="True" />
        <asp:TemplateField HeaderText="RETINERI" SortExpression="RETINERI">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("RETINERI") %>'></asp:TextBox>
                <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="TextBox7" Display="Dynamic" ErrorMessage="Introduceti o suma valida pentru retineri!" ForeColor="Red" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0"></asp:CompareValidator>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TextBox7" Display="Dynamic" ErrorMessage="Trebuie sa introduceti o valoare numerica!" ForeColor="Red"></asp:RequiredFieldValidator>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label7" runat="server" Text='<%# Bind("RETINERI") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="VIRAT_CARD" HeaderText="VIRAT_CARD" InsertVisible="False" SortExpression="VIRAT_CARD" ReadOnly="True" />
    </Columns>
</asp:GridView>
<p>
    <asp:Label ID="Label6" runat="server"></asp:Label>
    </p>
</asp:Content>
