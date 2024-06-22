<%@ Page Title="Manage User" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="UserEdit.aspx.vb" Inherits="zakat.icclmd.org.UserEdit" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><b>Edit User</b></h4>
    <br />
    <div class="well well-sm">
      <h5><b>Edit Existing User:</b></h5>
    </div>
    <div class="row">
      <div class="col-lg-6">
        <div class="form-horizontal">
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtUserId" CssClass="col-lg-2 control-label" ToolTip="User Id" Style="white-space: nowrap;">User #:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtUserId" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="User Id" MaxLength="30" TabIndex="1" ValidationGroup="Save" Enabled="False" />
              <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="CustomValidator"></asp:CustomValidator>
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="col-lg-2 control-label" ToolTip="First Name" Style="white-space: nowrap">First Name:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtFirstName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="First Name" MaxLength="30" TabIndex="2" AutoPostBack="False" ValidationGroup="Save" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" CssClass="text-danger" ErrorMessage="The first name is required." Display="Static" ValidationGroup="Save" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtMiddleName" CssClass="col-lg-2 control-label" ToolTip="Middle Name" Style="white-space: nowrap">Middle Name:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtMiddleName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Middle Name" MaxLength="30" TabIndex="3" AutoPostBack="False" ValidationGroup="Save" />
              <asp:CustomValidator ID="CustomValidator5" runat="server" CssClass="text-danger" ControlToValidate="txtMiddleName" ErrorMessage="middle" Display="Static" ValidationGroup="Save" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtLastName" CssClass="col-lg-2 control-label" ToolTip="Last Name" Style="white-space: nowrap">Last Name:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtLastName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Last Name" MaxLength="30" TabIndex="4" AutoPostBack="False" ValidationGroup="Save" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" CssClass="text-danger" Display="Static" ErrorMessage="The last name is required." ValidationGroup="Save" />
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-6">
        <div class="form-horizontal">
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtCreatedOn" CssClass="col-lg-2 control-label" ToolTip="Created Date" Style="white-space: nowrap;">Created On:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtCreatedOn" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Created Date" MaxLength="30" TabIndex="5" ValidationGroup="Save" Enabled="False" />
              <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="CustomValidator"></asp:CustomValidator>
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-lg-2 control-label" ToolTip="Email/Username" Style="white-space: nowrap">Email:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtEmail" AutoCompleteType="Disabled" CssClass="form-control" placeholder="email@domain.com" ToolTip="Email/Username" MaxLength="60" AutoPostBack="True" TabIndex="6" ValidationGroup="Save" />
              <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="A valid email/username is required." ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" CssClass="text-danger" Display="Dynamic" ValidationGroup="Save"></asp:RegularExpressionValidator>
              <asp:CustomValidator ID="valDuplicateEmail" runat="server" CssClass="text-danger" ControlToValidate="txtEmail" ErrorMessage="This username/email is already registered." Display="Dynamic" ValidationGroup="Save" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The email/username is required." Display="Static" ValidationGroup="Save" />
            </div>
          </div> 
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtPhone" CssClass="col-lg-2 control-label" ToolTip="Organization Phone Number" Style="white-space: nowrap">Phone #:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtPhone" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Phone #" MaxLength="12" placeholder="555-555-1234" TabIndex="7" AutoPostBack="false" ValidationGroup="Save" />
              <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ValidationExpression="^(1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$" ErrorMessage="Please enter a valid phone number" Display="Dynamic" ValidationGroup="Save"></asp:RegularExpressionValidator>
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ErrorMessage="The phone # is required." Display="Static" ValidationGroup="Save" />
            </div>
          </div>
          <div class="form-group">
            <div class="col-lg-2"></div>
            <div class="col-lg-10">
              <asp:HyperLink ID="btnCancel" runat="server" NavigateUrl="users" CssClass="btn btn-default" TabIndex="8" Width="140">Cancel</asp:HyperLink>
              <asp:Button ID="btnSaveUser" runat="server" Text="Save User" CssClass="btn btn-primary" TabIndex="9" Width="140" ValidationGroup="Save" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <br />
  <br />
</asp:Content>
