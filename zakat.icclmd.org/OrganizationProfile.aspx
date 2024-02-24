<%@ Page Title="Organization" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="OrganizationProfile.aspx.vb" Inherits="zakat.icclmd.org.OrganizationProfile" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <h3>Organization Profile Page</h3>
        <br />
        <div class="well well-sm">
          <table style="width:100%">
            <tr>
              <td><a href="organizations" target="_self"><span class="fas fa-arrow-alt-circle-left" style="font-size:20px; color:black"></span></a></td>
              <td><h5><b><asp:Label ID="lblOrganizationName" runat="server"></asp:Label>:</b></h5></td>
            </tr>
          </table>
        </div>

        <strong>Email:&nbsp;&nbsp;</strong><asp:HyperLink ID="hypEmail" runat="server" Target="_blank"></asp:HyperLink><br />
        <strong>Phone:&nbsp;&nbsp;</strong><asp:Label ID="lblPhone" runat="server"></asp:Label><br />
        <strong>Website:&nbsp;&nbsp;</strong><asp:HyperLink ID="hypWebsite" runat="server" Target="_blank"></asp:HyperLink><br />
        <address>
          <strong>Address:&nbsp;&nbsp;</strong><asp:Label ID="lblAddress" runat="server"></asp:Label><br />
        </address>
        <strong>Mission:&nbsp;&nbsp;</strong><asp:Label ID="lblMission" runat="server"></asp:Label><br />
        <div>
          <iframe id="ifrMap" runat="server" title="Map Location" src="" style="width: 100%; height: 400px; border: none"></iframe>
        </div>
      </div>
    </div>
  </div>
  <br />
  <br />

</asp:Content>