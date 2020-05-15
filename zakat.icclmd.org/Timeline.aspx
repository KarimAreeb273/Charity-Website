<%@ Page Title="Timeline" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Timeline.aspx.vb" Inherits="zakat.icclmd.org.Timeline" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <br />
  <div class="row">
    <div class="col-lg-12">
      <div class="well well-sm" style="text-align:justify; background-color: darkgreen; color: white">
        <table style="width: 100%" border="0">
          <tr>
            <th style="width: 100%; text-align:center; background-color:darkgreen; color:white">
              <asp:Label ID="lblReportName" runat="server" Text="Application Review Interval Timeline Between Actions"></asp:Label>
            </th>
        </table>
      </div>
      <asp:PlaceHolder ID="phReport" runat="server"></asp:PlaceHolder>
      <div id="timeline" style="width: 100%; height: 300px;"></div>
      <table class="table table-hover" border="0">
        <asp:Repeater ID="rptReviewHistory" runat="server">
          <HeaderTemplate>
            <tr style="height: 30px; border: solid solid solid solid">
              <th style="text-align: left; width: 20%">Name</th>
              <th style="text-align: left; width: 15%">Action</th>
              <th style="text-align: left; width: 20%;">Date of Action</th>
              <th style="text-align: left; width: 45%">Reviewed By Organization</th>
            </tr>
          </HeaderTemplate>
          <ItemTemplate>
            <tr>
              <td style="text-align: left; vertical-align: top">
                <%# DataBinder.Eval(Container.DataItem, "USER.firstName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "USER.middleName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "USER.lastName")%>
              </td>
              <td style="text-align: left; vertical-align: top; white-space: nowrap">
                <%# DataBinder.Eval(Container.DataItem, "reviewAction")%>
              </td>
              <td style="text-align: left; vertical-align: top">
                <%# FormatDateTime(DataBinder.Eval(Container.DataItem, "reviewDate"), DateFormat.GeneralDate)%>
              </td>
              <td style="text-align: left; vertical-align: top">
                <%# DataBinder.Eval(Container.DataItem, "APPLICATION.ORGANIZATION.name")%>
              </td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>
      </table>
    </div>
  </div>  
  
  
</asp:Content>
