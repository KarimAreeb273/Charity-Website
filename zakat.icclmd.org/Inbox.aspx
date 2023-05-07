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
              <td style="width: 20%; text-align: right">
                <h5>
                  Filter By Submission Year:
                </h5>
              </td>
              <td style="width: 5%; text-align: right">
                &nbsp;
              </td>
              <td style="width: 20%; text-align: left">
                <%--<asp:TextBox runat="server" ID="txtNumber" CssClass="form-control" ToolTip="Filter on Application #" MaxLength="10" TabIndex="1" AutoPostBack="True" />
                <ajaxToolkit:FilteredTextBoxExtender ID="ftbe1" runat="server" TargetControlID="txtNumber" FilterType="Numbers" />--%>
                <asp:DropDownList ID="drpSubmissionYear" runat="server" ToolTip="Filter By Submission Year" CssClass="form-control" TabIndex="1" Width="350px" AutoPostBack="True">
                  <asp:ListItem Text="2022" Value="All" Selected="True"></asp:ListItem>
                  <asp:ListItem Text="2000" Value="Drafted"></asp:ListItem>
                  <asp:ListItem Text="2021" Value="2021"></asp:ListItem>
                  <asp:ListItem Text="2023" Value="Validated"></asp:ListItem>
                </asp:DropDownList>
              </td>
              <td style="width: 5%; text-align: right">
                &nbsp;
              </td>
              <td style="width: 20%; text-align: right">
                <h5>
                  Filter By Workflow Step:
                </h5>
              </td>
              <td style="width: 5%; text-align: left">
                &nbsp;
              </td>
              <td style="width: 20%; text-align: left; white-space: nowrap;">
                <asp:DropDownList ID="drpWorkflow" runat="server" ToolTip="Select one to Filter" CssClass="form-control" TabIndex="2" Width="350px" AutoPostBack="True">
                  <asp:ListItem Text="All" Value="All" Selected="True"></asp:ListItem>
                  <asp:ListItem Text="Drafted" Value="Drafted"></asp:ListItem>
                  <asp:ListItem Text="Submitted" Value="Submitted"></asp:ListItem>
                  <asp:ListItem Text="Validated" Value="Validated"></asp:ListItem>
                  <asp:ListItem Text="Investigated" Value="Investigated"></asp:ListItem>
                  <asp:ListItem Text="Qualified" Value="Qualified"></asp:ListItem>
                  <asp:ListItem Text="Dispersed" Value="Dispersed"></asp:ListItem>
                  <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
                </asp:DropDownList>
              </td>
              <td style="width: 5%; text-align: right">
                &nbsp;
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
            <th style="text-align: left; width: 10%" title="Created or Submitted Date">Submitted</th>
            <th style="text-align: left; width: 10%">Status</th>
            <th style="text-align: left; width: 20%">Submitted To</th>          
            <th style="text-align: left; width: 20%">Progress</th>
            <th style="text-align: center; width: 7%;">Timeline</th>
              <th style="text-align: center; width: 7%;">Requests</th>
            <th style="text-align: center; width: 7%;">Review</th>
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
              <asp:LinkButton ID="btnViewProfile" runat="server" OnClick="btnViewProfile_Click" ToolTip="View Profile" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "userId")%>'>
                <%# DataBinder.Eval(Container.DataItem, "USER.firstName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "USER.middleName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "USER.lastName")%>
              </asp:LinkButton>              
            </td>
            <td style="text-align: left; vertical-align: middle">
              <%# IIf(DataBinder.Eval(Container.DataItem, "isSubmitted"), FormatDateTime(DataBinder.Eval(Container.DataItem, "submittedOn"), DateFormat.ShortDate), FormatDateTime(DataBinder.Eval(Container.DataItem, "createdOn"), DateFormat.ShortDate))%>
            </td>
            <td style="text-align: left; vertical-align: middle; white-space:nowrap">
              <%# DataBinder.Eval(Container.DataItem, "applicationStatus")%>
            </td>
            <td style="text-align: left; vertical-align: middle">
              <%# DataBinder.Eval(Container.DataItem, "ORGANIZATION.abbreviation")%>
            </td>            
            <td style="text-align: left; vertical-align: middle">
              <span title="Rejected" style="font-size:20px; color:red" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isRejected"), "glyphicon glyphicon-remove", "")%>'></span>
              &nbsp;<span title="Drafted" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isDrafted"), "fas fa-save", "")%>'></span>
              &nbsp;<span title="Submitted" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isSubmitted"), "fas fa-clipboard-list", "")%>'></span>
              &nbsp;<span title="Validated" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isValidated"), "fas fa-clipboard-check", "")%>'></span>
              &nbsp;<span title="Investigated" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isInvestigated"), "fas fa-search", "")%>'></span>
              &nbsp;<span title="Qualified (Initial)" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isQualified1"), "fas fa-check", "")%>'></span>
              &nbsp;<span title="Qualified (Final)" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isQualified2"), "fas fa-check-double", "")%>'></span>
              &nbsp;<span title="Dispersed" style="font-size:20px; color:darkgreen" class='<%# IIf(DataBinder.Eval(Container.DataItem, "isDispersed"), "fas fa-money-bill-wave", "")%>'></span>
            </td>
            <td style="text-align: center; vertical-align: middle">
              <asp:LinkButton ID="btnViewTimeline_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "applicationId")%>' runat="server" CausesValidation="false" OnClick="btnViewTimeline_Click" ToolTip="View Timeline"><span class="far fa-clock" style="font-size:20px; color:darkgreen"></span></asp:LinkButton>
            <td style="text-align: center; vertical-align: middle">
              <asp:LinkButton ID="btnViewRequests" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "userId")%>' runat="server" CausesValidation="false" OnClick="btnViewRequests_Click" ToolTip="View all zakat requests from this user"><span class="fas fa-filter" style="font-size:20px; color:darkgreen"></span></asp:LinkButton>
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
