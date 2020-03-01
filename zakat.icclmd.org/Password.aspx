<%@ Page Title="Change Password" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Password.aspx.vb" Inherits="zakat.icclmd.org.Password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><b>Change Password</b></h4>
    <hr />
    <div class="row">
      <div class="col-lg-6">
        <div class="form-horizontal">
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-lg-3 control-label" ToolTip="Email/Username" Style="white-space: nowrap">Email:</asp:Label>
            <div class="col-lg-9">
              <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" ReadOnly="true" ToolTip="Email/Username" MaxLength="60" TabIndex="1" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The email/username is required." Display="Static" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtCurrentPassword" CssClass="col-lg-3 control-label" Style="white-space: nowrap" ToolTip="Current Password">Current Password:</asp:Label>
            <div class="col-lg-9">
              <asp:TextBox runat="server" ID="txtCurrentPassword" TextMode="Password" CssClass="form-control" ToolTip="Current Password" MaxLength="20" TabIndex="2" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCurrentPassword" CssClass="text-danger" ErrorMessage="Your current password is required." Display="Static" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" CssClass="col-lg-3 control-label" Style="white-space: nowrap">&nbsp;</asp:Label>
            <div class="col-lg-9">
              <div class="alert alert-success">
                <span class="glyphicon glyphicon-info-sign" style="font-size:15px;">&nbsp;</span><strong>Passwords are eight (8) characters minimum</strong>
              </div>
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtNewPassword" CssClass="col-lg-3 control-label" Style="white-space: nowrap" ToolTip="New Password">New Password:</asp:Label>
            <div class="col-lg-9">
              <asp:TextBox runat="server" ID="txtNewPassword" TextMode="Password" CssClass="form-control" ToolTip="New Password" MaxLength="20" TabIndex="3" />
              <asp:CustomValidator ID="valMinChars" runat="server" CssClass="text-danger" ErrorMessage="A password must have 8 characters" Display="Dynamic"></asp:CustomValidator>
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNewPassword" CssClass="text-danger" ErrorMessage="A new password is required." Display="Static" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtConfirmPassword" CssClass="col-lg-3 control-label" Style="white-space: nowrap" ToolTip="Confirm Password">Confirm Password:</asp:Label>
            <div class="col-lg-9">
              <asp:TextBox runat="server" ID="txtConfirmPassword" TextMode="Password" CssClass="form-control" ToolTip="Confirm Password" MaxLength="20" TabIndex="4" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirmPassword" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please confirm the new password." />
              <asp:CompareValidator runat="server" ControlToCompare="txtNewPassword" ControlToValidate="txtConfirmPassword" CssClass="text-danger" Display="Static" ErrorMessage="The new and confirmation password do not match." />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" CssClass="col-lg-3 control-label" Style="white-space: nowrap">&nbsp;</asp:Label>
            <div class="col-lg-9">
              <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" CssClass="btn btn-success" TabIndex="5" Width="150" />
            </div>
          </div>
          <br />
          <div class="form-group">
            <asp:Label runat="server" CssClass="col-lg-3 control-label" Style="white-space: nowrap">&nbsp;</asp:Label>
            <div class="col-lg-9">
              <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
                <div class="alert alert-success">
                  <span class="glyphicon glyphicon-ok" style="font-size:15px;">&nbsp;</span><strong>Your password was successfully changed.</strong>
                </div>
              </asp:Panel>
              <asp:Panel ID="pnlFailed" runat="server" Visible="false">
                <div class="alert alert-danger">
                  <span class="glyphicon glyphicon-remove" style="font-size:15px;">&nbsp;</span><strong>Your password change was not successful.</strong>
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
