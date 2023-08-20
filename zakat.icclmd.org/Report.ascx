<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Report.ascx.vb" Inherits="zakat.icclmd.org.Report" %>
<table style="width:100%; height:375px; text-align:left; vertical-align:top; padding:5px">
  <tr>
    <td style="width:100%; height:100%; text-align:left; vertical-align:top; padding:5px">
      <div class="well well-sm">
        <b><asp:Label ID="lblTitle" runat="server" Text="Label"></asp:Label></b>
      </div>
      <div class="well well-lg">
        <asp:PlaceHolder ID="phScript" runat="server"></asp:PlaceHolder>
      </div>
    </td>
  </tr>
  <%--<tr>
    <td width="100%">
      <div class="well well-lg">
        <asp:PlaceHolder ID="phScript" runat="server"></asp:PlaceHolder>
      </div>
    </td>
  </tr>--%>
</table>