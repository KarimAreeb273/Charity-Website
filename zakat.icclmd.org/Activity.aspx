<%@ Page Title="My Activity" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Activity.aspx.vb" Inherits="zakat.icclmd.org.Activity" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><span style="font-size:20px; color:darkgreen" class="fas fa-clipboard-list"></span>&nbsp;&nbsp;<b>My Activity</b></h4>
    <br />

    <table class="table table-hover" border="0" style="font-size: 14px">
      <asp:Repeater ID="rptInbox" runat="server">
        <HeaderTemplate>
          <tr style="height: 30px; border: solid solid solid solid">
            <th style="text-align: left; width: 5%">App #</th>
            <th style="text-align: left; width: 15%">Name</th>
            <th style="text-align: left; width: 10%">Submitted</th>
            <th style="text-align: left; width: 10%">Status</th>
            <th style="text-align: left; width: 25%">Organization Submitted To</th>          
            <th style="text-align: left; width: 30%">Progress</th>
            <th style="text-align: center; width: 5%;">Timeline</th>
          </tr>
        </HeaderTemplate>
        <ItemTemplate>
          <tr>
            <td style="vertical-align: middle">
              <asp:LinkButton ID="btnViewTimelineTop_Click" runat="server" OnClick="btnViewTimeline_Click" ToolTip="View Timeline" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "applicationId")%>'>
                <%# getFormattedNumber(DataBinder.Eval(Container.DataItem, "applicationId"))%>
              </asp:LinkButton>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <%# DataBinder.Eval(Container.DataItem, "USER.firstName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "USER.middleName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "USER.lastName")%>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <%# IIf(DataBinder.Eval(Container.DataItem, "isSubmitted"), FormatDateTime(DataBinder.Eval(Container.DataItem, "submittedOn"), DateFormat.ShortDate), "")%>
            </td>
            <td style="text-align: left; vertical-align: middle; white-space:nowrap">
              <%# DataBinder.Eval(Container.DataItem, "applicationStatus")%>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <%# DataBinder.Eval(Container.DataItem, "ORGANIZATION.name")%>
            </td>
            
            <td style="text-align: left; vertical-align: middle">
              <span title="Rejected" style="font-size:20px; color:red" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isRejected"), "glyphicon glyphicon-remove", "")%>'></span>
              &nbsp;<span title="Drafted" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isDrafted"), "fas fa-save", "")%>'></span>
              &nbsp;<span title="Submitted" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isSubmitted"), "fas fa-clipboard-list", "")%>'></span>
              &nbsp;<span title="Validated" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isValidated"), "fas fa-check", "")%>'></span>
              &nbsp;<span title="Investigated" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isInvestigated"), "fas fa-search", "")%>'></span>
              &nbsp;<span title="Qualified (Initial)" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isQualified1"), "far fa-clipboard", "")%>'></span>
              &nbsp;<span title="Qualified (Final)" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isQualified2"), "fas fa-clipboard-check", "")%>'></span>
              &nbsp;<span title="Dispersed" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isDispersed"), "fas fa-money-bill-wave", "")%>'></span>
            </td>
            <td style="text-align: center; vertical-align: middle">
              <asp:LinkButton ID="btnViewTimelineBot_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "applicationId")%>' runat="server" CausesValidation="false" OnClick="btnViewTimeline_Click" ToolTip="View Timeline"><span class="far fa-clock" style="font-size:20px; color:darkgreen"></span></asp:LinkButton>
            </td>
          </tr>
        </ItemTemplate>
      </asp:Repeater>
    </table>
  </div>
  <br />
  <br />
</asp:Content>
