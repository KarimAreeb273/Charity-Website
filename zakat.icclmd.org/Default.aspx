﻿<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="zakat.icclmd.org._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  <br />
  <br />
  <br />
  <div class="jumbotron">
    <div class="row">
      <div class="col-md-6">
        <table style="width:100%" border="0">
          <tr>
            <td style="width:100%; text-align: center">
              <h3>Zakat Network</h3>
              <br />
              <img src="Images/zakatlogo.png" style='width:150px; height:300px'  />
            </td> 
          </tr>
        </table>
      </div>
      <div class="col-md-6">
        <div class="form-horizontal">
          <asp:Panel ID="pnlAnonymous" runat="server" Visible="true">
            <h3>Login</h3>
            <br />
            <div class="form-group">
              <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-md-2 control-label">Username:</asp:Label>
              <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="email@domain.com" ToolTip="Email/Username" MaxLength="60" TabIndex="1" autocomplete="off" ValidationGroup="Login" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The email/username is required." Display="Dynamic" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="A valid email/username is required." ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" CssClass="text-danger" Display="Dynamic"></asp:RegularExpressionValidator>                
              </div>
            </div>
            <div class="form-group">
              <asp:Label runat="server" AssociatedControlID="txtPassword" CssClass="col-md-2 control-label">Password:</asp:Label>
              <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" CssClass="form-control" TabIndex="2" Text="12121212" ValidationGroup="Login" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" CssClass="text-danger" ErrorMessage="The password is required." />
              </div>
            </div>
            <div class="form-group">
              <div class="col-md-2"></div>
              <div class="col-md-10">
                <table style="width: 100%" border="0">
                  <tr>
                    <td style="text-align: left">
                      <asp:Button runat="server" ID="btnLogin" Text="Login" Width="133px" CssClass="btn btn-primary" TabIndex="3" ValidationGroup="Login" />&nbsp;
                      <a href="forgot" class="btn btn-default" style="width: 133px;"  TabIndex="4">Forgot Password</a>
                    </td>
                  </tr>
                </table>
                <asp:CustomValidator ID="valBadLogin" runat="server" CssClass="text-danger" ControlToValidate="txtEmail" ErrorMessage="Check your username/password combination." Display="Dynamic" />
              </div>
            </div>
            <div class="form-group">
              <div class="col-md-2"></div>
              <div class="col-md-10">
                <br />
                <table style="width: 100%">
                  <tr>
                    <td style="width: 100%; text-align: left">                
                       <%-- Or, <a href="zakatform">Submit an Zakat Network Application!</a>--%>
                        <asp:LinkButton ID="btnGoToApplication" runat="server" Text="Submit an Zakat Network Application!" Width="275px" CssClass="btn btn-primary" TabIndex="5" PostBackUrl="zakatform" CausesValidation="False"></asp:LinkButton>
                    </td>
                  </tr>
                </table>
              </div>
            </div>
          </asp:Panel>
          <asp:Panel ID="pnlApplicant" runat="server" Visible="false">
            <table style="width: 100%" border="0">
              <tr>
                <td style="width: 100%; text-align: center">
                  <br />
                  <a href="zakatform">
                    <i class='fas fa-clipboard-list' style='color:black; font-size:100px'></i>
                    <br />
                    <h3 style='color:black; line-height: 1.5'>Complete Zakat<br />Application</h3>
                  </a>
                </td>
              </tr>
            </table>
          </asp:Panel>
          <asp:Panel ID="pnlApprover" runat="server" Visible="false">
            <table style="width: 100%" border="0">
              <tr>
                <td style="width: 100%; text-align: center">
                  <br />
                  <a href="inbox">
                    <i class='fas fas fa-inbox' style='color:black; font-size:100px'></i>
                    <br />
                    <h3 style='color:black; line-height: 1.5'>Review Zakat<br />Applications</h3>
                  </a>
                </td>
              </tr>
            </table>
          </asp:Panel>
          <asp:Panel ID="pnlAdministrator" runat="server" Visible="false">
            <table style="width: 100%" border="0">
              <tr>
                <td style="width: 100%; text-align: center">
                  <br />
                  <i class='fas fa-cogs' style='color:black; font-size:100px'></i>
                  <br />
                  <h3 style='color:black; line-height: 1.5'>Administer Zakat<br />System</h3>
                </td>
              </tr>
            </table>
          </asp:Panel>
          <asp:Panel ID="pnlMetrics" runat="server" Visible="true">
            <table style="width: 100%" border="0">
              <tr>
                <td style="width: 100%; text-align: center">
                  <br />
                  Current Average Duration To Process A Zakat Application: <b><asp:Label ID="lblAverageDuration" runat="server" Text="0 Days"></asp:Label></b>
                  <br />
                    (Average Duration Is From Application Submission to 2nd Qualification)
                </td>
              </tr>
            </table>
          </asp:Panel>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-md-6">
      <h4>Advantages of the Zakat Network System</h4>
      <ul>
        <li>Save your Zakat Network application data electronically and securely</li>
        <li>Submit Zakat Network application(s) to one or more Islamic organizations</li>
        <li>Correspondence is sent/received via email when decisions are made</li>
        <li>Edit your saved profile as often as necessary</li>
        <li>Track the progress of your submitted Zakat Network application</li>
        <li>Translate the Zakat Network system in a language you understand</li>
      </ul>

    </div>
    <div class="col-md-6">
      <h4>Required Zakat Network Protocols</h4>
      <ul style="list-style: none">
        <li><b>Applicants</b>, prior to your completing an Online</li>
        <li>Zakat Application, please review and adhere to the</li>
        <li><a href="protocols">Required Zakat Network Protocols</a></li>
      </ul>
    </div>
  </div>
  <br /><br />
</asp:Content>
