<%@ Page Title="Organization Edit" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="OrganizationEdit.aspx.vb" Inherits="zakat.icclmd.org.OrganizationEdit" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><b>Edit Organization</b></h4>
    <br />
    <div class="well well-sm">
      <h5><b>Edit Existing Organization:</b></h5>
    </div>
    <div class="row">
      <div class="col-lg-6">
        <div class="form-horizontal">
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtOrganizationName" CssClass="col-lg-2 control-label" ToolTip="Organization Name" Style="white-space: nowrap">Name:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtOrganizationName" CssClass="form-control" ToolTip="Organization Name" MaxLength="30" TabIndex="1" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOrganizationName" CssClass="text-danger" ErrorMessage="The organization name is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-lg-2 control-label" ToolTip="Organization Email" Style="white-space: nowrap">Email:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="email@domain.org" AutoCompleteType="Email" ToolTip="Organization Email" MaxLength="60" AutoPostBack="False" TabIndex="2" />
              <asp:RegularExpressionValidator ID="valEmailValid" runat="server" ErrorMessage="A valid email is required." ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" CssClass="text-danger" Display="Dynamic" ValidationGroup="Head"></asp:RegularExpressionValidator>
              <asp:RequiredFieldValidator ID="valEmailRequired" runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The organization email is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>              
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtPhone" CssClass="col-lg-2 control-label" ToolTip="Organization Phone Number" Style="white-space: nowrap">Phone #:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" ToolTip="Organization Phone Number" MaxLength="12" placeholder="555-555-1234" TabIndex="3" />
              <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ValidationExpression="^(1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$" ErrorMessage="Please enter a valid phone number." Display="Dynamic" ValidationGroup="Head"></asp:RegularExpressionValidator>
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ErrorMessage="The organization phone # is required." Display="Static" ValidationGroup="Head" />
              <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtPhone" Mask="(999) 999-9999" MaskType="None" ClearMaskOnLostFocus="False" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtWebsite" CssClass="col-lg-2 control-label" ToolTip="Organization Website" Style="white-space: nowrap">Website:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtWebsite" CssClass="form-control" placeholder="email@domain.org" AutoCompleteType="Email" ToolTip="Organization Website" MaxLength="60" AutoPostBack="False" TabIndex="4" />
              <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="A valid website is required." ControlToValidate="txtWebsite" ValidationExpression="^(https?:\/\/)?(www\.)?([a-zA-Z0-9]+(-?[a-zA-Z0-9])*\.)+[\w]{2,}(\/\S*)?$" CssClass="text-danger" Display="Dynamic" ValidationGroup="Head"></asp:RegularExpressionValidator>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtWebsite" CssClass="text-danger" ErrorMessage="The organization website is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-6">
        <div class="form-horizontal">
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtStreet" CssClass="col-lg-2 control-label" ToolTip="Organization Address Street" Style="white-space: nowrap">Street:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtStreet" CssClass="form-control" ToolTip="Address Street" MaxLength="100" TabIndex="5" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStreet" CssClass="text-danger" ErrorMessage="The address street is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtCity" CssClass="col-lg-2 control-label" ToolTip="Organization Address City" Style="white-space: nowrap">City:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtCity" CssClass="form-control" ToolTip="Address City" MaxLength="50" TabIndex="6" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity" CssClass="text-danger" ErrorMessage="The address city is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="drpState" CssClass="col-lg-2 control-label" ToolTip="Organization Address State" Style="white-space: nowrap; position: relative; top: 0px;">State:</asp:Label>
            <div class="col-lg-10">
              <asp:DropDownList ID="drpState" runat="server" ToolTip="Address State" CssClass="form-control" TabIndex="7"></asp:DropDownList>
              <asp:RequiredFieldValidator runat="server" ControlToValidate="drpState" CssClass="text-danger" ErrorMessage="The address state is required." InitialValue="0" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtZip" CssClass="col-lg-2 control-label" ToolTip="Organization Address Zip" Style="white-space: nowrap">Zip Code:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtZip" CssClass="form-control" ToolTip="Address Zip" MaxLength="5" TabIndex="8" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtZip" CssClass="text-danger" ErrorMessage="The address zip code is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <div class="col-lg-2"></div>
            <div class="col-lg-10">
              <asp:Button ID="btnSaveOrganization" runat="server" Text="Save Organization" CssClass="btn btn-success" TabIndex="9" Width="150" ValidationGroup="Head" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <br />
  <br />
</asp:Content>
