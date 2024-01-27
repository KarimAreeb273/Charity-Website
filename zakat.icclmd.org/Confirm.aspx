<%@ Page Title="Confirmation" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Confirm.aspx.vb" Inherits="zakat.icclmd.org.Confirm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><b>Donation Confirmation</b></h4>
    <br />
    <div class="row">
      <div class="col-lg-12">
        <%--<div class="alert alert-success">--%>
        <div class="well well-sm">
          <h5>
            Assalaamu Alaikum <asp:Label ID="lblFirstName" runat="server" Text="First"></asp:Label>,<br /><br />
            Your Donation has been received for organization: <b><asp:Label ID="lblOrgName" runat="server" Text="ICCL"></asp:Label></b>.<br /><br />
            <b>Donation #:</b> <asp:Label ID="lblDonationId" runat="server" Text="03452"></asp:Label><br />
            <b>Donater Name:</b> <asp:Label ID="lblFullName" runat="server" Text="First Middle Last"></asp:Label><br />
            <b>Donation Amount:</b> <asp:Label ID="lblDonationAmount" runat="server" Text="$90.00"></asp:Label><br />
            <b>Donation Date:</b> <asp:Label ID="lblDonationDate" runat="server" Text="1/5/2019"></asp:Label><br />
            <b>Donation Method:</b> <asp:Label ID="lblDonationMethod" runat="server" Text="PayPal"></asp:Label><br /><br />
            This site is not responsible for providing any end of year tax information. Please coordinate with the organization you are donating to in order to receive these documents.<br /><br />
            
            Thank you,<br /><br />
            The ICCL Zakat Administrator<br />
            <a href="https://zakat.icclmd.org">https://zakat.icclmd.org</a><br />
            7306 Contee Road<br />
            Laurel, MD 20707<br />
            <a href="mailto:zakat@icclmd.org">zakat@icclmd.org</a>
          </h5>
        </div>
        <br />
        <a href="default" class="btn btn-default" style="width: 100px">Go Home</a>&nbsp;<%--<a href="profile" class="btn btn-primary" style="width: 100px">Profile</a>--%>
        <asp:LinkButton ID="btnProfile" CssClass="btn btn-primary" Width="100" runat="server" Visible="False">Profile</asp:LinkButton>
        <%--</div>--%>
      </div>
    </div>
  </div>
</asp:Content>
