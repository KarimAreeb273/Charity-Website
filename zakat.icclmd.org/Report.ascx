<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Report.ascx.vb" Inherits="zakat.icclmd.org.Report" %>
<table style="width:100%; height:100%; text-align:left; vertical-align:top;">
  <tr>
    <td style="width:100%; height:100%; text-align:left; vertical-align:top;">
      <div id="divTitle" class="well well-sm" runat="server" visible="true" style="height: 54px" >
        <b><asp:Label ID="lblTitle" runat="server" Text="Label"></asp:Label></b>        
      </div>
      <div class="well well-lg">
        <asp:PlaceHolder ID="phScript" runat="server"></asp:PlaceHolder>
      </div>
    </td>
  </tr>
</table>