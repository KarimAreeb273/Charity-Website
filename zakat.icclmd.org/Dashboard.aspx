<%@ Page Title="Zakat Dashboard" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Dashboard.aspx.vb" Inherits="zakat.icclmd.org.Dashboard" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><span style="font-size:20px; color:darkgreen" class="fas fa-chart-area"></span>&nbsp;&nbsp;<b>Online Zakat Dashboard</b></h4>
    <br />
    <table style="width:100%" border="0" >
      <tr>
        <td style="width:750px; height:375px; text-align:left; vertical-align:top; padding:5px" colspan="2">
          <asp:PlaceHolder ID="phChartTopLeft" runat="server"></asp:PlaceHolder>
        </td>
        <td style="width:375px; height:375px; text-align:center; vertical-align:top; padding:5px">
          <div id="divTitle" class="well well-sm" runat="server">
            <table>
              <tr>
                <td>
                  <b>Select Year:</b>&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                  <asp:DropDownList CssClass="form-control" ID="drpApplicationsByGenderByYear" runat="server" Width="150" AutoPostBack="True"></asp:DropDownList>
                </td>
              </tr>
            </table>
          </div>
          <asp:PlaceHolder ID="phChartTopRight" runat="server"></asp:PlaceHolder>
        </td>
      </tr>
      <tr>
        <td style="width:375px; height:375px; text-align:center; vertical-align:top; padding:5px">
          <div id="div1" class="well well-sm" runat="server">
            <table>
              <tr>
                <td>
                  <b>Select Year:</b>&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                  <asp:DropDownList CssClass="form-control" ID="drpApplicationsByGenderByNationalityByYear" runat="server" Width="150" AutoPostBack="True"></asp:DropDownList>
                </td>
              </tr>
            </table>
          </div>          
          <asp:PlaceHolder ID="phChartBottomLeft" runat="server"></asp:PlaceHolder>
        </td>
        <td style="width:750px; height:375px; text-align:left; vertical-align:top; padding:5px" colspan="2">
          <asp:PlaceHolder ID="phChartBottomRight" runat="server"></asp:PlaceHolder>
        </td>
      </tr>
    </table>
  </div>
  <br />
  <br />
</asp:Content>
