<%@ Page Title="Zakat Dashboard" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Dashboard.aspx.vb" Inherits="zakat.icclmd.org.Dashboard" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><span style="font-size:20px; color:darkgreen" class="fas fa-chart-area"></span>&nbsp;&nbsp;<b>Online Zakat Dashboard</b></h4>
    <br />
    <table style="width:100%" border="1" >
      <tr>
        <td style="width:750px; height:400px; text-align:left; vertical-align:top; padding:5px" colspan="2">
          <asp:PlaceHolder ID="phChartTopLeft" runat="server"></asp:PlaceHolder>
        </td>
        <td style="width:100%; width:375px; height:400px; text-align:center; vertical-align:middle">3</td>
      </tr>
      <tr>
        <td style="width:100%; width:375px; height:400px; text-align:center; vertical-align:middle">4</td>
        <td style="width:100%; width:375px; height:400px; text-align:center; vertical-align:middle">5</td>
        <td style="width:100%; width:375px; height:400px; text-align:center; vertical-align:middle">6</td>
      </tr>
    </table>
  </div>    
</asp:Content>
