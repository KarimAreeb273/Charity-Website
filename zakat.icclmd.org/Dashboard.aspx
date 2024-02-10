<%@ Page Title="Zakat Dashboard" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Dashboard.aspx.vb" Inherits="zakat.icclmd.org.Dashboard" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><span style="font-size:20px; color:black" class="fas fa-chart-area"></span>&nbsp;&nbsp;<b>Zakat Network Dashboard</b></h4>
    <br />
    <table style="width:100%" border="0" >
      <tr>
        <td style="width:750px; height:375px; text-align:left; vertical-align:top; padding:5px" colspan="2">
          <asp:PlaceHolder ID="phChartRow1Left" runat="server"></asp:PlaceHolder>
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
          <asp:PlaceHolder ID="phChartRow1Right" runat="server"></asp:PlaceHolder>
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
          <asp:PlaceHolder ID="phChartRow2Left" runat="server"></asp:PlaceHolder>
        </td>
        <td style="width:750px; height:375px; text-align:left; vertical-align:top; padding:5px" colspan="2">
          <asp:PlaceHolder ID="phChartRow2Right" runat="server"></asp:PlaceHolder>
        </td>
      </tr>
    </table>
    <table style="width:100%" border="0">
      <tr>
        <td style="width:100%; height:375px; text-align:center; vertical-align:top; padding:5px">
          <div id="div2" class="well well-sm" runat="server">
            <table>
              <tr>
                <td>
                  <b>Select Year:</b>&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                  <asp:DropDownList CssClass="form-control" ID="drpAverageProcessingDaysByMonth" runat="server" Width="100%" AutoPostBack="True"></asp:DropDownList>
                </td>
              </tr>
            </table>
          </div>          
          <asp:PlaceHolder ID="phChartRow3Left" runat="server"></asp:PlaceHolder>
        </td>
      </tr>
    </table>
    <table style="width:100%" border="0">
      <tr>
        <td style="width:100%; height:375px; text-align:center; vertical-align:top; padding:5px">
          <div id="div3" class="well well-sm" runat="server">
            <table>
              <tr>
                <td>
                  <b>Select Year:</b>&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                  <asp:DropDownList CssClass="form-control" ID="drpTotalDispersedByMonth" runat="server" Width="100%" AutoPostBack="True"></asp:DropDownList>
                </td>
              </tr>
            </table>
          </div>          
          <asp:PlaceHolder ID="phChartRow4Left" runat="server"></asp:PlaceHolder>
        </td>
      </tr>
    </table>
  </div>
  <br />
  <br />
</asp:Content>
