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
              <td style="text-align: right">
                <b>1. Select Organization:</b>
              </td>
              <td>
                &nbsp;
              </td>
              <td style="text-align: left">
                <asp:DropDownList ID="drpOrganization" runat="server" ToolTip="Organization" CssClass="form-control" style="max-width: 100%; padding-left:0px; padding-right:0px" TabIndex="1" Width="300px" AutoPostBack="True"></asp:DropDownList>
              </td>
            </tr>
          </table>
        </div>
        <br /><br />
        <div class="input-group">
          <table style="width: 100%">
            <tr>
              <td style="width: 100%">
                <asp:TextBox ID="txtSearchUser" runat="server" class="form-control" style="max-width: 100%" Width="400px" placeholder="Filter/Search Users" AutoPostBack="True" TabIndex="2" Enabled="False"></asp:TextBox>&nbsp;<asp:LinkButton ID="btnSearch" runat="server" ToolTip="Search" style="text-decoration:none" TabIndex="3" Enabled="False">
                  <i class="glyphicon glyphicon-search" style="color: darkgreen; font-size:20px;"></i>
                </asp:LinkButton>&nbsp;<asp:LinkButton ID="btnClear" runat="server" ToolTip="Clear" style="text-decoration:none" TabIndex="4" Enabled="False">
                  <i class="glyphicon glyphicon-remove" style="color: darkgreen; font-size:20px"></i>
                </asp:LinkButton>
              </td>
            </tr>
          </table>
        </div>
        <br />
        <div class="form-group">
          <table style="max-width: 100%; width:100%; white-space: nowrap" border="0">
            <tr>
              <td style="width: 100%">
                <b>2. Select User:</b><br />
                <asp:ListBox ID="lstUsers" CssClass="form-control" style="max-width: 100%" runat="server" AutoPostBack="True" Rows="15" Width="450px" TabIndex="5" Enabled="False"></asp:ListBox>
              </td>
            </tr>
          </table>
        </div>
      </div>
      <div class="col-lg-6">
        <table style="width: 210px; white-space: nowrap">
          <tr>
            <td style="width: 50%">
              <h5><b>3. Assign User Roles:</b></h5>
              <h5><asp:Label ID="lblUser" runat="server" Text="Select a User" ToolTip="Currently Modifying Roles for this Individual"></asp:Label><br />
              <asp:Label ID="lblEmail" runat="server" Text="" ToolTip="Currently Modifying Roles for this Individual">&nbsp;</asp:Label></h5>&nbsp;
            </td>
          </tr>
          <tr>
            <td style="width: 100%" colspan="2">
              <b>Available Roles:</b><br />
              <asp:ListBox ID="lstAvailable"  runat="server" CssClass="form-control" AutoPostBack="False" Rows="6" Width="210px" TabIndex="6" Enabled="False"></asp:ListBox>
            </td>
          </tr>
          <tr>
            <td style="width: 100%" colspan="2">
              <br />
              <table style="width: 100%">
                <tr>
                  <td style="width: 50%; text-align: left">
                    <asp:LinkButton ID="btnAddRole" runat="server" ToolTip="Add the Role" TabIndex="7" Enabled="False">
                      <span class="fas fa-arrow-alt-circle-down" style="color: darkgreen; font-size: 30px" ></span>
                    </asp:LinkButton>
                  </td>
                  <td style="width: 50%; text-align: right">
                    <asp:LinkButton ID="btnDeleteRole" runat="server" ToolTip="Remove the Role" TabIndex="8" Enabled="False">
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
              <asp:ListBox ID="lstAssigned"  runat="server" CssClass="form-control" AutoPostBack="False" Rows="5" Width="210px" TabIndex="9" Enabled="False"></asp:ListBox>
            </td>
          </tr>
        </table>
      </div>
    </div>
  </div>
  <br />
  <br />
</asp:Content>
