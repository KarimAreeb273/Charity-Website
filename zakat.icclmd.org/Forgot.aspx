<%@ Page Title="Reset Password" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Forgot.aspx.vb" Inherits="zakat.icclmd.org.Forgot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><b>Reset Password</b></h4>
    <hr />
    <div class="row">
      <div class="col-lg-9">
        <div class="form-horizontal">
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-lg-3 control-label" ToolTip="Email/Username" Style="white-space: nowrap">Email/Username:</asp:Label>
            <div class="col-lg-9">
              <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" ToolTip="Email/Username" placeholder="email@domain.com"  MaxLength="60" TabIndex="1" />
              <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="A valid email/username is required." ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" CssClass="text-danger" Display="Dynamic"></asp:RegularExpressionValidator>
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The email/username is required." Display="Static" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" CssClass="col-lg-3 control-label" Style="white-space: nowrap">&nbsp;</asp:Label>
            <div class="col-lg-9">
              <asp:Button ID="btnResetPassword" runat="server" Text="Reset Password" CssClass="btn btn-success" TabIndex="5" Width="150" />
            </div>
          </div>
          <br />
          <div class="form-group">
            <asp:Label runat="server" CssClass="col-lg-3 control-label" Style="white-space: nowrap">&nbsp;</asp:Label>
            <div class="col-lg-9">
              <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
                <div class="alert alert-info">
                  <span class="glyphicon glyphicon-ok" style="font-size:15px;">&nbsp;</span><strong>Your password reset was successfully performed.  Please check your email.</strong>
                </div>
              </asp:Panel>
              <asp:Panel ID="pnlFailed" runat="server" Visible="false">
                <div class="alert alert-danger">
                  <span class="glyphicon glyphicon-remove" style="font-size:15px;">&nbsp;</span><strong>Your password reset was unsuccessful.  Please check your email account.</strong>
                </div>
              </asp:Panel>
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" CssClass="col-lg-3 control-label" Style="white-space: nowrap">&nbsp;</asp:Label>
            <div class="col-lg-9">
              <strong>Go Back to the <a href="default">Login</a>&nbsp;Page</strong>
            </div>
          </div> 
        </div>
      </div>
    </div>
  </div>
</asp:Content>
