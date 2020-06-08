<%@ Page Title="Manage Applicants" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Applicants.aspx.vb" Inherits="zakat.icclmd.org.Applicants" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><b>Manage Applicants</b></h4>
    <br />
    <div class="well well-sm">          
      <table style="width: 100%" border="0">
        <tr>
          <td style="text-align: left; width: 75%">
            <h5><b>Manage Registered Applicants:</b></h5>
          </td>
          <td style="text-align: right; width: 24%">
            <asp:TextBox runat="server" ID="txtFilter" CssClass="form-control" ToolTip="Filter on All Fields" MaxLength="30" TabIndex="2" placeholder="Filter" AutoPostBack="True" style="padding-left:2px; padding-right:2px" />
          </td>
          <td style="text-align: center; width: 1%">
            &nbsp;
          </td>
          <td style="text-align: center; width: 1%">
            <asp:LinkButton ID="btnClearFilter" runat="server">
              <span title="clear filter/reset list" class="glyphicon glyphicon-refresh" style="font-size:20px; color:darkgreen"></span>
            </asp:LinkButton>
          </td>
        </tr>
      </table> 
    </div>
    <table class="table table-hover" border="0" style="font-size: 14px">
      <tr style="height: 30px; border: solid solid solid solid">
        <th style="text-align: left; width: 10%">User #</th>
        <th style="text-align: left; width: 25%">Name&nbsp;
          <asp:LinkButton ID="btnSortName" runat="server" CommandArgument="name">
            <span title="sort by name" class="fas fa-sort-alpha-down" style="font-size:17px; color:black"></span>
          </asp:LinkButton>
        </th>
        <th style="text-align: left; width: 15%">Phone&nbsp;
          <asp:LinkButton ID="btnSortPhone" runat="server" CommandArgument="phone">
            <span title="sort by phone" class="fas fa-sort-alpha-down" style="font-size:17px; color:black"></span>
          </asp:LinkButton>
        </th>
        <th style="text-align: left; width: 30%">Email&nbsp;
          <asp:LinkButton ID="btnSortEmail" runat="server" CommandArgument="email">
            <span title="sort by email" class="fas fa-sort-alpha-down" style="font-size:17px; color:black"></span>
          </asp:LinkButton>
        </th>
        <th style="text-align: center; width: 10%;">Edit</th>
        <th style="text-align: center; width: 10%;">Delete</th>
      </tr>
      <asp:Repeater ID="rptApplicant" runat="server">
        <%--<HeaderTemplate>          
        </HeaderTemplate>--%>
        <ItemTemplate>
          <tr>
            <td style="vertical-align: middle">
              <%#GetFormattedNumber(DataBinder.Eval(Container.DataItem, "userId"))%>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <%# DataBinder.Eval(Container.DataItem, "fullName")%>
            </td>
            <td style="vertical-align: middle">
              <%# getFormattedPhone(DataBinder.Eval(Container.DataItem, "phone"))%>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl='<%# "mailto:" & DataBinder.Eval(Container.DataItem, "email")%>'><%# DataBinder.Eval(Container.DataItem, "email")%></asp:HyperLink>
            </td>
            <td style="text-align: center; vertical-align: middle">
              <asp:LinkButton ID="btnEdit3" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "userId")%>' runat="server" CausesValidation="false" OnClick="btnEditApplicant_Click" ToolTip='<%# "Edit " & DataBinder.Eval(Container.DataItem, "fullName")%>'><span class="fas fa-edit" style="font-size:15px; color:darkgreen"></span></asp:LinkButton>
            </td>
            <td style="text-align: center; vertical-align: middle">
              <asp:LinkButton ID="btnDelete3" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "userId")%>' runat="server" CausesValidation="false" OnClick="btnDeleteApplicant_Click" ToolTip='<%# "Delete " & DataBinder.Eval(Container.DataItem, "fullName")%>'><span class="glyphicon glyphicon-remove" style="font-size:15px; color:red"></span></asp:LinkButton>
            </td>
          </tr>
        </ItemTemplate>
      </asp:Repeater>
    </table>
  </div>
  <br /><br />
</asp:Content>
