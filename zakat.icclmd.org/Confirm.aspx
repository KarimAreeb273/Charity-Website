<%@ Page Title="Confirmation" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Confirm.aspx.vb" Inherits="zakat.icclmd.org.Confirm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><b>Donation Confirmation Confirmation</b></h4>
    <br />
    <div class="row">
      <div class="col-lg-12">
        <%--<div class="alert alert-success">--%>
        <div class="well well-sm">
          <h5>
            Assalaamu Alaikum <asp:Label ID="lblFirstName" runat="server" Text="First"></asp:Label>,<br /><br />
            Your Donation has been received for membership year: <b><asp:Label ID="lblYear1" runat="server" Text="9999"></asp:Label></b>. Please ensure that you print this page as a receipt.<br /><br />
            <b>Member #:</b> <asp:Label ID="lblMemberId" runat="server" Text="03452"></asp:Label><br />
            <b>Member Name:</b> <asp:Label ID="lblFullName" runat="server" Text="First Middle Last"></asp:Label><br />
            <b>Membership Type:</b> <asp:Label ID="lblMemberType" runat="server" Text="Single/Family"></asp:Label><br />
            <b>Membership Year:</b> <asp:Label ID="lblYear2" runat="server" Text="9999"></asp:Label><br />
            <b>Payment Amount:</b> <asp:Label ID="lblPayAmount" runat="server" Text="$90.00"></asp:Label><br />
            <b>Payment Date:</b> <asp:Label ID="lblPayDate" runat="server" Text="1/5/2019"></asp:Label><br />
            <b>Payment Method:</b> <asp:Label ID="lblPayMethod" runat="server" Text="PayPal"></asp:Label><br />
            <b>Payment Reference:</b> <asp:Label ID="lblReference" runat="server" Text="First Middle Last"></asp:Label><br />
            <b>Recorded By:</b> <asp:Label ID="lblRecordedBy" runat="server" Text="First Middle Last"></asp:Label><br /><br />
            Please note that ICCL Membership Dues are not tax deductible.  If you have issues regarding your account, please don’t hesitate to contact us.<br /><br />
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
