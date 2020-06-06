<%@ Page Title="Manage Users" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Users.aspx.vb" Inherits="zakat.icclmd.org.Users" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><b>Manage Users</b></h4>
    <br />
    <ul class="nav nav-tabs">
      <li class="active">
        <a data-toggle="tab" href="#addUser"><b>Register User</b></a>
      </li> 
      <li>
        <a data-toggle="tab" href="#manageUsers"><b>Manage Users</b>&nbsp;
          <span class="label label-primary"><asp:Label ID="lblUsersCountBadge" runat="server" Text="0"></asp:Label></span>
        </a>
      </li>
    </ul>
    <div class="tab-content">
      <div id="addUser" class="tab-pane fade in active">
        <br />
        <div class="well well-sm">
          <h5><b>Register New User:</b></h5>
        </div>
        <div class="row">
          <div class="col-lg-6">
            <div class="form-horizontal">                               
              <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="col-lg-2 control-label" ToolTip="First Name" Style="white-space: nowrap">First Name:</asp:Label>
                <div class="col-lg-10">
                  <asp:TextBox runat="server" ID="txtFirstName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="First Name" MaxLength="30" TabIndex="1" AutoPostBack="False" ValidationGroup="Submit" />
                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" CssClass="text-danger" ErrorMessage="The first name is required." Display="Static" ValidationGroup="Submit" />
                </div>
              </div>
              <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtMiddleName" CssClass="col-lg-2 control-label" ToolTip="Middle Name" Style="white-space: nowrap">Middle Name:</asp:Label>
                <div class="col-lg-10">
                  <asp:TextBox runat="server" ID="txtMiddleName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Middle Name" MaxLength="30" TabIndex="2" AutoPostBack="False" ValidationGroup="Submit" />
                  <asp:CustomValidator ID="CustomValidator5" runat="server" CssClass="text-danger" ControlToValidate="txtMiddleName" ErrorMessage="middle" Display="Static" ValidationGroup="Submit" />
                </div>
              </div>
              <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtLastName" CssClass="col-lg-2 control-label" ToolTip="Last Name" Style="white-space: nowrap">Last Name:</asp:Label>
                <div class="col-lg-10">
                  <asp:TextBox runat="server" ID="txtLastName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Last Name" MaxLength="30" TabIndex="3" AutoPostBack="False" ValidationGroup="Submit" />
                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" CssClass="text-danger" Display="Static" ErrorMessage="The last name is required." ValidationGroup="Submit" />
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="form-horizontal">
              <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-lg-2 control-label" ToolTip="Email/Username" Style="white-space: nowrap">Email:</asp:Label>
                <div class="col-lg-10">
                  <asp:TextBox runat="server" ID="txtEmail" AutoCompleteType="Disabled" CssClass="form-control" placeholder="email@domain.com" ToolTip="Email/Username" MaxLength="60" AutoPostBack="True" TabIndex="4" ValidationGroup="Submit" />
                  <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="A valid email/username is required." ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" CssClass="text-danger" Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                  <asp:CustomValidator ID="valDuplicateEmail" runat="server" CssClass="text-danger" ControlToValidate="txtEmail" ErrorMessage="This username/email is already registered." Display="Dynamic" ValidationGroup="Submit" />
                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The email/username is required." Display="Static" ValidationGroup="Submit" />
                </div>
              </div> 
              <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtPhone" CssClass="col-lg-2 control-label" ToolTip="Organization Phone Number" Style="white-space: nowrap">Phone #:</asp:Label>
                <div class="col-lg-10">
                  <asp:TextBox runat="server" ID="txtPhone" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Phone #" MaxLength="12" placeholder="555-555-1234" TabIndex="5" AutoPostBack="false" ValidationGroup="Submit" />
                  <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ValidationExpression="^(1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$" ErrorMessage="Please enter a valid phone number" Display="Dynamic" ValidationGroup="Head"></asp:RegularExpressionValidator>
                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ErrorMessage="The phone # is required." Display="Static" ValidationGroup="Submit" />
                </div>
              </div>
              <div class="form-group">
                <div class="col-lg-2"></div>
                <div class="col-lg-10">
                  <asp:Button ID="btnAddUser" runat="server" Text="Add User" CssClass="btn btn-success" TabIndex="6" Width="150" ValidationGroup="Submit" />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div id="manageUsers" class="tab-pane fade">
        <br />
        <div class="well well-sm">
          <h5><b>Manage Registered User:</b></h5>
        </div>
        <asp:Panel ID="pnlManageUsers" runat="server" Visible="true">
          <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
              <table class="table table-hover" border="0" style="font-size: 14px">
                <asp:Repeater ID="rptUsers" runat="server">
                  <HeaderTemplate>
                    <tr style="height: 30px; border: solid solid solid solid">
                      <th style="text-align: left; width: 10%">User #</th>
                      <th style="text-align: left; width: 30%">Name</th>
                      <th style="text-align: left; width: 15%">Phone</th>
                      <th style="text-align: left; width: 35%">Email</th>
                      <th style="text-align: center; width: 10%;">Edit</th>
                    </tr>
                  </HeaderTemplate>
                  <ItemTemplate>
                    <tr>
                      <td style="vertical-align: middle">
                        <%#GetFormattedNumber(DataBinder.Eval(Container.DataItem, "userId"))%>
                      </td>
                      <td style="text-align: left; vertical-align: middle">
                        <%# DataBinder.Eval(Container.DataItem, "fullName")%>
                      </td>
                      <td style="vertical-align: middle">
                        <%# getFormattedPhone(DataBinder.Eval(Container.DataItem, "phone"))%>
                      </td>
                      <td style="text-align: left; vertical-align: middle">
                        <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" NavigateUrl='<%# "mailto:" & DataBinder.Eval(Container.DataItem, "email")%>'><%# DataBinder.Eval(Container.DataItem, "email")%></asp:HyperLink>
                      </td>
                      <td style="text-align: center; vertical-align: middle">
                        <asp:LinkButton ID="btnEdit2" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "userId")%>' runat="server" CausesValidation="false" OnClick="btnEdit_Click" ToolTip='<%# "Edit " & DataBinder.Eval(Container.DataItem, "fullName")%>'><span class="fas fa-edit" style="font-size:15px; color:darkgreen"></span></asp:LinkButton>
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
    </div>
  </div>
  <br />
  <br />
</asp:Content>
