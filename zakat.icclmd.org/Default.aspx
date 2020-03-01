<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="zakat.icclmd.org._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


  <div class="jumbotron">
    <div class="row">
      <div class="col-md-6">
        <table style="width:100%" border="0">
          <tr>
            <td style="width:100%; text-align: center">
              <h3>Online Zakat</h3>
              <br />
              <i class="fas fa-dollar-sign" style='font-size:200px; color: darkgreen'></i>
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
                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="email@domain.com" ToolTip="Email/Username" MaxLength="60" TabIndex="1" autocomplete="off" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The email/username is required." Display="Dynamic" />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="A valid email/username is required." ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" CssClass="text-danger" Display="Dynamic"></asp:RegularExpressionValidator>                
              </div>
            </div>
            <div class="form-group">
              <asp:Label runat="server" AssociatedControlID="txtPassword" CssClass="col-md-2 control-label">Password:</asp:Label>
              <div class="col-md-10">
                <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" CssClass="form-control" TabIndex="2" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" CssClass="text-danger" ErrorMessage="The password field is required." />
              </div>
            </div>
            <div class="form-group">
              <div class="col-md-2"></div>
              <div class="col-md-10">
                <table style="width: 100%" border="0">
                  <tr>
                    <td style="text-align: left">
                      <asp:Button runat="server" ID="btnLogin" Text="Login" Width="133px" CssClass="btn btn-success" TabIndex="3" />&nbsp;
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
                    <td style="width: 100%; text-align: left">Or, <a href="zakatform">Submit an Online Zakat Application!</a>
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
                    <i class='fas fa-clipboard-list' style='color:darkgreen; font-size:100px'></i>
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
                    <i class='fas fa-file-signature' style='color:darkgreen; font-size:100px'></i>
                    <br />
                    <h3 style='color:black; line-height: 1.5'>Approve Zakat<br />Applications</h3>
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
                  <i class='fas fa-cogs' style='color:darkgreen; font-size:100px'></i>
                  <br />
                  <h3 style='color:black; line-height: 1.5'>Administer Zakat<br />System</h3>
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
      <h4>Advantages of the Online Zakat System</h4>
      <ul>
        <li>Submit online zakat applciations without having to register an account</li>
        <li>Save your online zakat applciation data electronically and securely</li>
        <li>Submit online zakat application(s) to one or more Islamic organizations</li>
        <li>Correspondence is sent/received via email when decisions are made</li>
        <li>Edit your saved profile as often as necessary</li>
        <li>Track the progress of your submitted online zakat applciation (with an account)</li>
      </ul>
    </div>
    <div class="col-md-6">
      <h4>&nbsp;</h4>
    </div>
  </div>
  <br /><br />

</asp:Content>
