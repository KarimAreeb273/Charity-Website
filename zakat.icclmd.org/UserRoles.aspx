<%@ Page Title="User Roles" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="UserRoles.aspx.vb" Inherits="zakat.icclmd.org.UserRoles" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><b>Manage User Roles</b></h4>
    <br />
    <div class="well well-sm">
      <h5><b>Click on a User to Manage the User's Role(s):</b></h5>
    </div>
    <div class="row">
      <div class="col-lg-6">
          <div class="input-group">
            <table style="width: 100%">
              <tr>
                <td style="width: 100%">
                  <asp:TextBox ID="txtSearchUser" runat="server" class="form-control" placeholder="Filter/Search Users" AutoPostBack="True"></asp:TextBox>
                </td>
                <td style="width: 58px; border: solid; border-color:darkgray; border-width:1px">
                  <asp:LinkButton ID="btnSearch" runat="server" ToolTip="Search">
                    <i class="glyphicon glyphicon-search" style="color: darkgreen; font-size:20px"></i>
                  </asp:LinkButton>
                </td>
                <td>
                  &nbsp;
                </td>
                <td style="width: 58px; border: solid; border-color:darkgray; border-width:1px">
                  <asp:LinkButton ID="btnClear" runat="server" ToolTip="Clear">
                    <i class="glyphicon glyphicon-remove" style="color: darkgreen; font-size:20px"></i>
                  </asp:LinkButton>
                </td>
              </tr>
            </table>
          </div>
          <br />
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="lstUsers" CssClass="col-lg-2 control-label" ToolTip="System Users" Style="white-space: nowrap">Users:</asp:Label>
            <div class="col-lg-10">
              <asp:ListBox ID="lstUsers"  runat="server" AutoPostBack="True" Rows="21" Width="210px"></asp:ListBox>
            </div>
          </div>
      </div>
      <div class="col-lg-6">
        <table style="width: 210px; white-space: nowrap">
          <tr>
            <td style="width: 50%">
              <h5><b><asp:Label ID="lblUser" runat="server" Text="Select a User" ToolTip="Currently Modifying Roles for this Individual"></asp:Label></b></h5>
              <h5><b><asp:Label ID="lblEmail" runat="server" Text="" ToolTip="Currently Modifying Roles for this Individual">&nbsp;</asp:Label></b></h5>&nbsp;
            </td>
          </tr>
          <tr>
            <td style="width: 100%" colspan="2">
              <b>Available Roles:</b><br />
              <asp:ListBox ID="lstAvailable"  runat="server" AutoPostBack="False" Rows="6" Width="210px"></asp:ListBox>
            </td>
          </tr>
          <tr>
            <td style="width: 100%" colspan="2">
              <br />
              <table style="width: 100%">
                <tr>
                  <td style="width: 50%; text-align: left">
                    <asp:LinkButton ID="btnAddRole" runat="server" ToolTip="Add the Role">
                      <span class="fas fa-arrow-alt-circle-down" style="color: darkgreen; font-size: 30px" ></span>
                    </asp:LinkButton>
                  </td>
                  <td style="width: 50%; text-align: right">
                    <asp:LinkButton ID="btnDeleteRole" runat="server" ToolTip="Remove the Role">
                      <span class="fas fa-arrow-alt-circle-up" style="color: darkgreen; font-size: 30px" ></span>
                    </asp:LinkButton>
                  </td>
                </tr>
              </table>
              <br />
            </td>
          </tr>
          <tr>
            <td style="width: 100%">
              <b>Assigned Roles:</b><br />
              <asp:ListBox ID="lstAssigned"  runat="server" AutoPostBack="False" Rows="6" Width="210px"></asp:ListBox>
            </td>
          </tr>
        </table>
      </div>
    </div>
  </div>
  <br />
  <br />
</asp:Content>
