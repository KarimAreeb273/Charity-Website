<%@ Page Title="Administer" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="AdminFunctions.aspx.vb" Inherits="zakat.icclmd.org.AdminFunctions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <br /><br /><br />
    <table style="width:100%">
      <tr>
        <td style="width:100%; text-align: center">
          <asp:Button ID="btnEncryptUserSSNs" runat="server" Text="Encrypt User SSNs" CssClass="btn btn-primary" />
          <br />
          <br />
          <asp:Button ID="btnEncryptUserPasswords" runat="server" Text="Encrypt User Passwords" CssClass="btn btn-primary" />
          <br />
          <br />
          <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
        </td>
      </tr>
    </table>    
  <br /><br />
</asp:Content>
