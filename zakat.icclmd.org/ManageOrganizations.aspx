<%@ Page Title="Organizations" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ManageOrganizations.aspx.vb" Inherits="zakat.icclmd.org.ManageOrganizations" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><b>Manage Organizations</b></h4>
    <br />
    <ul class="nav nav-tabs">
      <li class="active">
        <a data-toggle="tab" href="#manageOrganizations"><b>Manage Organizations</b></a>
      </li>
      <li>
        <a data-toggle="tab" href="#addOrganization"><b>Register Organization</b></a>
      </li>
    </ul>
    <div class="tab-content">
      <div id="manageOrganizations" class="tab-pane fade in active">
        <br />
        <div class="well well-sm">
          <h5><b>Manage Registered Organizations:</b></h5>
        </div>
        <asp:Panel ID="pnlManageOrganizations" runat="server" Visible="true">
          <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
              <table class="table table-hover" border="0" style="font-size: 14px">
                <asp:Repeater ID="rptOrganizations" runat="server">
                  <HeaderTemplate>
                    <tr style="height: 30px; border: solid solid solid solid">
                      <th style="text-align: left; width: 30%">Name</th>
                      <th style="text-align: left; width: 10%">Phone</th>
                      <th style="text-align: left; width: 20%">Email</th>                      
                      <th style="text-align: left; width: 30%">Website</th>
                      <th style="text-align: center; width: 5%;">Edit</th>
                    </tr>
                  </HeaderTemplate>
                  <ItemTemplate>
                    <tr>
                      <td style="text-align: left; vertical-align: middle">
                        <asp:Label ID="lblStatusName" runat="server" ToolTip='<%# DataBinder.Eval(Container.DataItem, "name")%>'><%# DataBinder.Eval(Container.DataItem, "name")%> (<%# DataBinder.Eval(Container.DataItem, "abbreviation")%>)</asp:Label>
                      </td>
                      <td style="vertical-align: middle">
                        <%# getFormattedPhone(DataBinder.Eval(Container.DataItem, "phone"))%>
                      </td>
                      <td style="text-align: left; vertical-align: middle">
                        <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl='<%# "mailto:" & DataBinder.Eval(Container.DataItem, "email")%>'><%# DataBinder.Eval(Container.DataItem, "email")%></asp:HyperLink>
                      </td>
                      <td style="text-align: left; vertical-align: middle">
                        <asp:HyperLink ID="HyperLink2" runat="server" Target="_blank" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "website")%>'><%# DataBinder.Eval(Container.DataItem, "website")%></asp:HyperLink>
                      </td>
                      <td style="text-align: center; vertical-align: middle">
                        <asp:LinkButton ID="btnEdit2" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "organizationId")%>' runat="server" CausesValidation="false" OnClick="btnEdit_Click" ToolTip='<%# "Edit " & DataBinder.Eval(Container.DataItem, "name")%>'><span class="fas fa-edit" style="font-size:15px; color:darkgreen"></span></asp:LinkButton>
                      </td>
                    </tr>
                  </ItemTemplate>
                </asp:Repeater>
              </table>
            </ContentTemplate>
            <Triggers>
              <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click" />
            </Triggers>
          </asp:UpdatePanel>
          <asp:LinkButton ID="btnEdit" runat="server" Visible="false" Text="temp"></asp:LinkButton>
        </asp:Panel>
      </div>
      <div id="addOrganization" class="tab-pane fade">
        <br />
        <div class="well well-sm">
          <h5><b>Register New Organization:</b></h5>
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
                  <asp:TextBox runat="server" ID="txtWebsite" CssClass="form-control" placeholder="email@domain.org" ToolTip="Organization Website" MaxLength="60" AutoPostBack="False" TabIndex="5" AutoCompleteType="Disabled" />
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
                <div class="checkbox">
                    <label><asp:CheckBox ID="chkAcknowledgement" runat="server" CssClass="checkbox" TabIndex="10" AutoPostBack="True" /><b>Accept Donations?</b></label>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="chkAcknowledgement" CssClass="text-danger" ErrorMessage="The PayPal token is required" Display="Static" ValidationGroup="Head" />
                </div>
              </div>
              <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtPayPalToken" CssClass="col-lg-2 control-label" ToolTip="Organization PayPal Token" Style="white-space: nowrap">PayPal Token:</asp:Label>
                <div class="col-lg-10">
                  <asp:TextBox runat="server" ID="txtPayPalToken" CssClass="form-control" ToolTip="PayPal Token" MaxLength="5" TabIndex="11" AutoCompleteType="Disabled" />
                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPayPalToken" CssClass="text-danger" ErrorMessage="The PayPal token is required" Display="Static" ValidationGroup="Head" />
                </div>
              </div>
             <%-- <div class="form-group">
                <div id="hiddenForm" runat="server" style="display:none;">
                    <asp:TextBox runat="server"  ID="imgName" placeholder="Enter your Image URL"></asp:TextBox>
                    <asp:TextBox ID="tokenName" runat="server" placeholder="Enter your org PayPal Token"></asp:TextBox>
                </div>
              </div>--%>
              <div class="form-group">
                <div class="col-lg-2"></div>
                <div class="col-lg-10">
                    <asp:Button ID="btnAddOrganization" runat="server" Text="Add Organization" CssClass="btn btn-success" TabIndex="10" Width="150" ValidationGroup="Head" />
                </div>
              </div>
            </div>
          </div>
        </div>      
      </div>
    </div>
  </div>
  <br />
  <br />
</asp:Content>
