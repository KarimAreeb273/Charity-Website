<%@ Page Title="User Forum" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Discussion.aspx.vb" Inherits="zakat.icclmd.org.Discussion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <br />
  <br />
  <br />
   <table style="width:100%" border="0">
     <tr>
      <td style="width: 20%;">
        <asp:Panel ID="pnlNavigateShow" runat="server" Visible="true" Width="170px" Height="800px" BorderStyle="Solid">
           <table style="width:100%" border="0">
            <tr>
              <td style="width:100%">
                &nbsp;&nbsp;
              </td>
              <td style="width:1%">
                <asp:LinkButton ID="btnCollapse" runat="server" Visible="true" ToolTip="Collapse Navigation Bar"><img src="Images/double.left.png" style="width:15px; height: 15px" /></asp:LinkButton>&nbsp;
              </td>
              <td style="width:1%">
                &nbsp;&nbsp;
              </td>
            </tr>
          </table>
           <div class="well well-sm">
             <table style="width: 100%">
                <tr>
                  <td style="text-align: center; width: 100%">
                    <b>Post Search Tools</b>
                  </td>
                </tr>
              </table>
         </div>
          <b>Search By Keyword(s):</b><br />
          <table>
            <tr>
              <td>&nbsp;</td>
              <td style="text-align:center">
                <div class="form-group has-feedback has-search">
                  <span class="glyphicon glyphicon-search form-control-feedback"></span>
                  <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="type & click enter" AutoPostBack="True" AutoCompleteType="Disabled" width="155px"></asp:TextBox>
                </div>
              </td>
              <td>&nbsp;</td>
            </tr>
          </table>
          <br />
          <b>Search By Category:</b><br />
          <table class="table table-hover" border="0" style="font-size: 14px">
            <asp:Repeater ID="rptPostCategories" runat="server">
              <ItemTemplate>
                <tr>
                  <td style="text-align: left; vertical-align: middle">
                    <asp:LinkButton ID="btnViewPostCategory" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "postCategoryId")%>' runat="server" CausesValidation="false" OnClick="btnViewPostCategory_Click" ToolTip='<%# "View more details about " & DataBinder.Eval(Container.DataItem, "name") & " posts"  %>'>
                      <%# DataBinder.Eval(Container.DataItem, "name")%> <%# " (" & DataBinder.Eval(Container.DataItem, "countOfPosts") & ")"%>
                    </asp:LinkButton>
                  </td>
                  <td style="vertical-align: middle">
                    
                  </td>
                </tr>
              </ItemTemplate>
            </asp:Repeater>
          </table>          
        </asp:Panel>
      </td>
       <td style="width: 20%;">
        <asp:Panel ID="pnlNavigateHide" runat="server" Visible="false" Width="40px" Height="800px" BorderStyle="Solid">
         <table style="width:100%" border="0">
          <tr>
            <td style="width:100%">&nbsp;&nbsp;</td>
            <td style="width:1%">
              <asp:LinkButton ID="btnExpand" runat="server" Visible="false" ToolTip="Expand Navigation Bar"><img src="Images/double.right.png" style="width:15px; height: 15px" /></asp:LinkButton>
            </td>
            <td style="width:1%">&nbsp;&nbsp;</td>
          </tr>
        </table>
        </asp:Panel>
      </td>
      <td style="width: 80%">
        <asp:Panel ID="pnlBody" runat="server" Visible="true" Width="1000px" Height="800px" BorderStyle="Solid" ScrollBars="Auto">
          
        </asp:Panel> 
      </td>
    </tr>
   </table>
  <br />
  <br />
</asp:Content>
