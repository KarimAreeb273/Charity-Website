<%@ Page Title="Organizations" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Organizations.aspx.vb" Inherits="zakat.icclmd.org.Organizations" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h3>Organizations Affiliated with Zakat Network</h3>
    <br />
    <div class="well well-sm">
      <h5><b>View Affiliated Organizations:</b></h5>
    </div>
    <table class="table table-hover" border="0" style="font-size: 14px">
      <asp:Repeater ID="rptOrganizations" runat="server">
        <HeaderTemplate>
          <tr style="height: 30px; border: solid solid solid solid">
            <th style="text-align: left; width: 30%">Name</th>
            <th style="text-align: left; width: 10%">Phone</th>
            <th style="text-align: left; width: 20%">Email</th>                      
            <th style="text-align: left; width: 30%">Website</th>
            <th style="text-align: center; width: 5%;">View</th>
          </tr>
        </HeaderTemplate>
        <ItemTemplate>
          <tr>
            <td style="text-align: left; vertical-align: middle">
              <asp:LinkButton ID="btnView1" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "organizationId")%>' runat="server" CausesValidation="false" OnClick="btnView_Click" ToolTip='<%# "View more details about " & DataBinder.Eval(Container.DataItem, "name")%>'>
                <asp:Label ID="lblName" runat="server" ToolTip='<%# "View more details about " & DataBinder.Eval(Container.DataItem, "name")%>'><%# DataBinder.Eval(Container.DataItem, "name")%> (<%# DataBinder.Eval(Container.DataItem, "abbreviation")%>)</asp:Label>
              </asp:LinkButton>
            </td>
            <td style="vertical-align: middle">
              <%# getFormattedPhone(DataBinder.Eval(Container.DataItem, "phone"))%>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl='<%# "mailto:" & DataBinder.Eval(Container.DataItem, "email")%>'><%# DataBinder.Eval(Container.DataItem, "email")%></asp:HyperLink>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "website")%>'><%# DataBinder.Eval(Container.DataItem, "website")%></asp:HyperLink>
            </td>
            <td style="text-align: center; vertical-align: middle">
              <asp:LinkButton ID="btnView2" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "organizationId")%>' runat="server" CausesValidation="false" OnClick="btnView_Click" ToolTip='<%# "Click to view more details about " & DataBinder.Eval(Container.DataItem, "name")%>'>
                <span class="fas fa-info-circle" style="font-size:20px; color:black"></span>
              </asp:LinkButton>
            </td>
          </tr>
        </ItemTemplate>
      </asp:Repeater>
    </table>
    <asp:LinkButton ID="btnView" runat="server" Visible="false" Text="temp"></asp:LinkButton>
  </div>
  <br />
  <br />
</asp:Content>
