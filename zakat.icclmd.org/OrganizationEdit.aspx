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
              <asp:TextBox runat="server" ID="txtOrganizationName" CssClass="form-control" ToolTip="Organization Name" MaxLength="100" TabIndex="1" AutoCompleteType="Disabled" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOrganizationName" CssClass="text-danger" ErrorMessage="The organization name is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtOrganizationAbbreviation" CssClass="col-lg-2 control-label" ToolTip="Organization Abbreviation" Style="white-space: nowrap">Abbr:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtOrganizationAbbreviation" CssClass="form-control" ToolTip="Organization Abbreviation" MaxLength="100" TabIndex="2" AutoCompleteType="Disabled" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOrganizationAbbreviation" CssClass="text-danger" ErrorMessage="The organization abbreviation is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-lg-2 control-label" ToolTip="Organization Email" Style="white-space: nowrap">Email:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="email@domain.org" ToolTip="Organization Email" MaxLength="60" AutoPostBack="False" TabIndex="3" AutoCompleteType="Disabled" />
              <asp:RegularExpressionValidator ID="valEmailValid" runat="server" ErrorMessage="A valid email is required." ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" CssClass="text-danger" Display="Dynamic" ValidationGroup="Head"></asp:RegularExpressionValidator>
              <asp:RequiredFieldValidator ID="valEmailRequired" runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The organization email is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtPhone" CssClass="col-lg-2 control-label" ToolTip="Organization Phone Number" Style="white-space: nowrap">Phone #:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" ToolTip="Phone #" MaxLength="12" placeholder="555-555-1234" TabIndex="4" AutoPostBack="false" ValidationGroup="Submit" AutoCompleteType="Disabled" />
              <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ValidationExpression="^(1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$" ErrorMessage="Please enter a valid phone number" Display="Dynamic" ValidationGroup="Head"></asp:RegularExpressionValidator>
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ErrorMessage="The organization phone # is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtWebsite" CssClass="col-lg-2 control-label" ToolTip="Organization Website" Style="white-space: nowrap">Website:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtWebsite" CssClass="form-control" placeholder="https://domain.com" ToolTip="Organization Website" MaxLength="60" AutoPostBack="False" TabIndex="5" AutoCompleteType="Disabled" />
              <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="A valid website is required." ControlToValidate="txtWebsite" ValidationExpression="^(https?:\/\/)?(www\.)?([a-zA-Z0-9]+(-?[a-zA-Z0-9])*\.)+[\w]{2,}(\/\S*)?$" CssClass="text-danger" Display="Dynamic" ValidationGroup="Head"></asp:RegularExpressionValidator>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtWebsite" CssClass="text-danger" ErrorMessage="The organization website is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtPayPalImg" CssClass="col-lg-2 control-label" ToolTip="PayPal Image Url" Style="white-space: nowrap">Image Url:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtPayPalImg" CssClass="form-control" placeholder="https://domain.com" ToolTip="PayPal Image Url" TabIndex="11" AutoCompleteType="Disabled" Enabled="False" />
              <asp:RegularExpressionValidator ID="valPayPalImgUrl" runat="server" ControlToValidate="txtPayPalImg" ValidationExpression="^(https?:\/\/)?(www\.)?([a-zA-Z0-9]+(-?[a-zA-Z0-9])*\.)+[\w]{2,}(\/\S*)?$" ErrorMessage="A valid Image Url is required." CssClass="text-danger" Display="Dynamic" ValidationGroup="Head" Enabled="False"></asp:RegularExpressionValidator>
              <asp:RequiredFieldValidator ID="valPayPalImg" runat="server" ControlToValidate="txtPayPalImg" CssClass="text-danger" ErrorMessage="The PayPal Image is required." Display="Static" ValidationGroup="Head" Enabled="False" />
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-6">
        <div class="form-horizontal">
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtStreet" CssClass="col-lg-2 control-label" ToolTip="Organization Address Street" Style="white-space: nowrap">Street:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtStreet" CssClass="form-control" ToolTip="Address Street" MaxLength="100" TabIndex="6" AutoCompleteType="Disabled" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStreet" CssClass="text-danger" ErrorMessage="The address street is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtCity" CssClass="col-lg-2 control-label" ToolTip="Organization Address City" Style="white-space: nowrap">City:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtCity" CssClass="form-control" ToolTip="Address City" MaxLength="50" TabIndex="7" AutoCompleteType="Disabled" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity" CssClass="text-danger" ErrorMessage="The address city is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="drpState" CssClass="col-lg-2 control-label" ToolTip="Organization Address State" Style="white-space: nowrap; position: relative; top: 0px;">State:</asp:Label>
            <div class="col-lg-10">
              <asp:DropDownList ID="drpState" runat="server" ToolTip="Address State" CssClass="form-control" TabIndex="8"></asp:DropDownList>
              <asp:RequiredFieldValidator runat="server" ControlToValidate="drpState" CssClass="text-danger" ErrorMessage="The address state is required." InitialValue="0" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtZip" CssClass="col-lg-2 control-label" ToolTip="Organization Address Zip" Style="white-space: nowrap">Zip Code:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtZip" CssClass="form-control" ToolTip="Address Zip" MaxLength="5" TabIndex="9" AutoCompleteType="Disabled" />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="txtZip" CssClass="text-danger" ErrorMessage="The address zip code is required." Display="Static" ValidationGroup="Head" />
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="chkAcknowledgement" CssClass="col-lg-2 control-label" ToolTip="Organization Accepts Donation" Style="white-space: nowrap">&nbsp;</asp:Label>
            <div class="col-lg-10">
              <asp:CheckBox runat="server" ID="chkAcknowledgement" TabIndex="10" AutoPostBack="True"></asp:CheckBox>
              <label for="chkAcknowledgement" runat="server"><b>Accepts Donation?</b></label>
            </div>
            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="CustomValidator"></asp:CustomValidator>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtPayPalToken" CssClass="col-lg-2 control-label" ToolTip="PayPal Token" Style="white-space: nowrap">PayPal Token:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtPayPalToken" CssClass="form-control" ToolTip="PayPal Token" TabIndex="12" AutoCompleteType="Disabled" Enabled="False" />
              <asp:RequiredFieldValidator runat="server" ID="valPayPalToken" ControlToValidate="txtPayPalToken" CssClass="text-danger" ErrorMessage="The PayPal token is required." Display="Static" ValidationGroup="Head" Enabled="False" />
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="form-group">
        <asp:Label runat="server" AssociatedControlID="txtZip" CssClass="col-lg-1 control-label" ToolTip="Organization Mission Statement" Style="white-space: nowrap">Org Mission:</asp:Label>
        <div class="col-lg-11">
          <asp:TextBox runat="server" ID="txtMission" CssClass="form-control" ToolTip="Organization Mission Statement" MaxLength="4000" TabIndex="13" AutoCompleteType="Disabled" Width="1040" TextMode="MultiLine" Rows="5" ValidateRequestMode="Disabled" />
          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMission" CssClass="text-danger" ErrorMessage="The organization mission statement is required." Display="Static" ValidationGroup="Head" />
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-7">
      </div>
      <div class="col-lg-5">
        <div class="form-group">
          <asp:Button ID="btnSaveOrganization" runat="server" Text="Save Organization" CssClass="btn btn-primary" TabIndex="14" Width="150" ValidationGroup="Head" />
        </div>
      </div>
    </div>
  </div>
  <br />
  <br />
</asp:Content>
