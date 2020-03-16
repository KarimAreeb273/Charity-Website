<%@ Page Title="Inbox" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Inbox.aspx.vb" Inherits="zakat.icclmd.org.Inbox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><span style="font-size:20px; color:darkgreen" class="fas fa-inbox"></span>&nbsp;&nbsp;<b>Online Zakat Inbox</b></h4>
    <br />
    <div class="well well-sm">
      <h5><b>Click on an Online Zakat Application to review and take action:</b></h5>
    </div>
    <table class="table table-hover" border="0" style="font-size: 14px">
      <asp:Repeater ID="rptInbox" runat="server">
        <HeaderTemplate>
          <tr style="height: 30px; border: solid solid solid solid">
            <th style="text-align: left; width: 15%">Name</th>
            <th style="text-align: left; width: 20%">Email</th>
            <th style="text-align: left; width: 10%">Phone</th>
            <th style="text-align: center; width: 10%">Gender</th>
            <th style="text-align: center; width: 5%">Age</th>
            <th style="text-align: left; width: 20%">Submitted</th>
            <th style="text-align: left; width: 15%">Progress</th>
            <th style="text-align: center; width: 5%;">View</th>
          </tr>
        </HeaderTemplate>
        <ItemTemplate>
          <tr>
            <td style="text-align: left; vertical-align: middle">
              <%# DataBinder.Eval(Container.DataItem, "USER.firstName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "USER.middleName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "USER.lastName")%>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl='<%# "mailto:" & DataBinder.Eval(Container.DataItem, "USER.email")%>'><%# DataBinder.Eval(Container.DataItem, "USER.email")%></asp:HyperLink>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <%# getFormattedPhone(DataBinder.Eval(Container.DataItem, "USER.phone"))%>
            </td>
            <td style="text-align: center; vertical-align: middle">
              <%# IIf(DataBinder.Eval(Container.DataItem, "USER.gender") = "Male", "Male", "Female")%>
            </td>
            <td style="text-align: center; vertical-align: middle">
              <%#getAge(DataBinder.Eval(Container.DataItem, "USER.dob"))%>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <%# FormatDateTime(DataBinder.Eval(Container.DataItem, "submittedDate"), DateFormat.LongDate)%>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <span title="Saved" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isSaved"), "fas fa-save", "")%>'></span>&nbsp;
              <span title="Submitted" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isSubmitted"), "fas fa-clipboard-list", "")%>'></span>&nbsp;
              <span title="Validated" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isValidated"), "fas fa-check", "")%>'></span>&nbsp;
              <span title="Investigated" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isInvestigated"), "fas fa-search", "")%>'></span>&nbsp;
              <span title="Qualified" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isQualified"), "fas fa-clipboard-check", "")%>'></span>&nbsp;
            </td>
            <td style="text-align: center; vertical-align: middle">
              <asp:LinkButton ID="btnViewApplication" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "applicationId")%>' runat="server" CausesValidation="false" OnClick="btnViewApplication_Click" ToolTip="View Application"><span class="fas fa-glasses" style="font-size:20px; color:darkgreen"></span></asp:LinkButton>
            </td>
          </tr>
        </ItemTemplate>
      </asp:Repeater>
    </table>
  </div>
  <br />
  <br />
</asp:Content>
