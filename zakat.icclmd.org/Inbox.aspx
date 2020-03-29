<%@ Page Title="Inbox" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Inbox.aspx.vb" Inherits="zakat.icclmd.org.Inbox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><span style="font-size:20px; color:darkgreen" class="fas fa-inbox"></span>&nbsp;&nbsp;<b>Online Zakat Inbox</b></h4>
    <br />
    <div class="row">
      <div class="col-lg-12">
        <div class="well well-sm" style="text-align:justify; background-color: darkgreen; color: white">
          <table style="width: 100%">
            <tr>
              <td style="width: 60%; text-align: right">
                <h5>
                  Filter By Workflow Step:
                </h5>
              </td>
              <td style="width: 5%; text-align: right">
                &nbsp;
              </td>
              <td style="width: 35%; text-align: left; white-space: nowrap;">
                <asp:DropDownList ID="drpWorkflow" runat="server" ToolTip="Select one to Filter" CssClass="form-control" TabIndex="1" Width="350px" AutoPostBack="True">
                  <asp:ListItem Text="All" Value="All"></asp:ListItem>
                  <asp:ListItem Text="Drafted" Value="Drafted"></asp:ListItem>
                  <asp:ListItem Text="Submitted" Value="Submitted" Selected="True"></asp:ListItem>
                  <asp:ListItem Text="Validated" Value="Validated"></asp:ListItem>
                  <asp:ListItem Text="Investigated" Value="Investigated"></asp:ListItem>
                  <asp:ListItem Text="Qualified 1" Value="Qualified 1"></asp:ListItem>
                  <asp:ListItem Text="Qualified 2" Value="Qualified 2"></asp:ListItem>
                  <asp:ListItem Text="Dispersed" Value="Dispersed"></asp:ListItem>
                </asp:DropDownList>
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>

    <table class="table table-hover" border="0" style="font-size: 14px">
      <asp:Repeater ID="rptInbox" runat="server">
        <HeaderTemplate>
          <tr style="height: 30px; border: solid solid solid solid">
            <th style="text-align: left; width: 5%">App #</th>
            <th style="text-align: left; width: 15%">Name</th>
            <th style="text-align: left; width: 20%">Email</th>
            <th style="text-align: left; width: 10%">Phone</th>
            <th style="text-align: center; width: 5%">Gender</th>
            <th style="text-align: center; width: 5%">Age</th>
            <th style="text-align: left; width: 10%">Submitted</th>
            <th style="text-align: left; width: 25%">Progress</th>
            <th style="text-align: center; width: 5%;">View</th>
          </tr>
        </HeaderTemplate>
        <ItemTemplate>
          <tr>
            <td style="vertical-align: middle">
              <asp:LinkButton ID="btnViewApplicationTop" runat="server" OnClick="btnViewApplication_Click" ToolTip="View Application" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "applicationId")%>'>
                <%# getFormattedNumber(DataBinder.Eval(Container.DataItem, "applicationId"))%>
              </asp:LinkButton>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <%# DataBinder.Eval(Container.DataItem, "USER.firstName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "USER.middleName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "USER.lastName")%>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl='<%# "mailto:" & DataBinder.Eval(Container.DataItem, "USER.email")%>'><%# DataBinder.Eval(Container.DataItem, "USER.email")%></asp:HyperLink>
            </td>
            <td style="text-align: left; vertical-align: middle; white-space: nowrap">
              <%# getFormattedPhone(DataBinder.Eval(Container.DataItem, "USER.phone"))%>
            </td>
            <td style="text-align: center; vertical-align: middle">
              <%# IIf(DataBinder.Eval(Container.DataItem, "USER.gender") = "Male", "Male", "Female")%>
            </td>
            <td style="text-align: center; vertical-align: middle">
              <%#getAge(DataBinder.Eval(Container.DataItem, "USER.dob"))%>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <%# FormatDateTime(DataBinder.Eval(Container.DataItem, "submittedOn"), DateFormat.ShortDate)%>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <span title="Drafted" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isDrafted"), "fas fa-save", "")%>'></span>&nbsp;
              <span title="Submitted" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isSubmitted"), "fas fa-clipboard-list", "")%>'></span>&nbsp;
              <span title="Validated" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isValidated"), "fas fa-check", "")%>'></span>&nbsp;
              <span title="Investigated" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isInvestigated"), "fas fa-search", "")%>'></span>&nbsp;
              <span title="Qualified 1" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isQualified1"), "far fa-clipboard", "")%>'></span>&nbsp;
              <span title="Qualified 2" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isQualified2"), "fas fa-clipboard-check", "")%>'></span>&nbsp;
              <span title="Dispersed" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isDispersed"), "fas fa-money-bill-wave", "")%>'></span>&nbsp;
              <%--
                fas fa-clipboard
                far fa-clipboard
                fas fa-money-bill-alt
                fas fa-money-bill-wave
                fas fa-money-check-alt
              --%>
            </td>
            <td style="text-align: center; vertical-align: middle">
              <asp:LinkButton ID="btnViewApplicationBot" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "applicationId")%>' runat="server" CausesValidation="false" OnClick="btnViewApplication_Click" ToolTip="View Application"><span class="fas fa-glasses" style="font-size:20px; color:darkgreen"></span></asp:LinkButton>
            </td>
          </tr>
        </ItemTemplate>
      </asp:Repeater>
    </table>
  </div>
  <br />
  <br />
</asp:Content>
