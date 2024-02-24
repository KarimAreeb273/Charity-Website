<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Discussion.aspx.vb" Inherits="zakat.icclmd.org.Discussion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <br />
  <br />
  <br />
  <table style="width:100%" border="1">
    <tr>
      <td id="colNavigate" style="width: 20%;">
        &nbsp;
        <asp:Panel ID="pnlNavigate" runat="server">
          <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
          <asp:LinkButton ID="btnExpand" runat="server"><img src="Images/double.right.png" style="width:20px; height: 20px" /></asp:LinkButton>
          <asp:LinkButton ID="btnCollapse" runat="server"><img src="Images/double.left.png" style="width:20px; height: 20px" /></asp:LinkButton>
        </asp:Panel>
        <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" TargetControlID="pnlNavigate" CollapsedSize="0" ExpandedSize="300" CollapsedText="Show Details..." ExpandedText="Hide Details..." CollapsedImage="Images/double.right.png" ExpandedImage="Images/double.left.png" ExpandDirection="Horizontal"  ExpandControlID="btnExpand" CollapseControlID="btnCollapse" />
        
        <br />
        
      </td>
      <td id="colMain" style="width: 80%">&nbsp;</td>
    </tr>
  </table>
</asp:Content>
