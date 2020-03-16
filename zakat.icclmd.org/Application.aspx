<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Application.aspx.vb" Inherits="zakat.icclmd.org.Application1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
    <h4><span style="font-size:20px; color:darkgreen" class="fas fa-clipboard-list"></span>&nbsp;&nbsp;<b>Online Zakat Application</b></h4>
    <br />
    <div class="well well-sm">
      <h5><b>Review the Online Zakat Application and Take Action:</b></h5>
    </div>
    <%--<asp:Label ID="lblApplication" runat="server" Text="Label"></asp:Label>--%>
    <br /><br />
    <div class="container">
      <div class="row">
        <div class="col-lg-6">
          <table style="width: 100%">
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="control-label" Style="white-space: nowrap">Email:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtEmail" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">First Name:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtFirstName" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Middle Name:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtMiddleName" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Last Name:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtLastName" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">SSN:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtSocialSecurity" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">DOB:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtDOB" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Phone:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtPhone" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Gender:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtGender" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Marital Status:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtMaritalStatus" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Street:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtStreet" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">City:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtCity" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">State:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtState" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Zip:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtZip" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Began Living:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtBeganLiving" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Other Type:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtHomeType" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Specified Other:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtOtherHomeType" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
          </table>
        </div>
        <div class="col-lg-6">
          <table style="width: 100%">
            
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Nationality:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtNationality" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Citizenship:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtCitizenship" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Highest Education:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtHighestEducation" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">School Name:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtSchoolName" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">School Street:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtSchoolStreet" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">School City:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtSchoolCity" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">School State:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtSchoolState" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">School Zip:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtSchoolZip" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Husband First:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtHusbandFirstName" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Husband Middle:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtHusbandMiddleName" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtHusbandLastName" CssClass="control-label" Style="white-space: nowrap">Husband Last:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtHusbandLastName" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Husband Applied?:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtHusbandApplied" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Husband Explanation:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtHusbandExplanation" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Masjid Name:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtMasjidName" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
            <tr>
              <td>
                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="control-label" Style="white-space: nowrap">Masjid Phone:</asp:Label>
              </td>
              <td>
                <asp:Label runat="server" ID="txtMasjidPhone" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>
    <br /><br />
    <div class="row">
      <div class="form-group">
        <div class="col-lg-12">
          <table style="width:100%">
            <tr>
              <td style="width:96%; text-align:right">
                <asp:CustomValidator ID="valUserRequiredSave" runat="server" CssClass="text-danger" ErrorMessage="You must enter your email and name before saving the form." Display="Static" ValidationGroup="Save" Enabled="True" />
              </td>
              <td style="width:1%; text-align:right">
                &nbsp;
              </td>
              <td style="width:1%; text-align:right">
                <asp:Button ID="btnValidate" runat="server" Text="Application Validated" CssClass="btn btn-success" TabIndex="1" Width="200" Enabled="true" Visible="true" />
              </td>
              <td style="width:1%; text-align:right">
                &nbsp;
              </td>
              <td style="width:1%; text-align:right">
                <asp:Button ID="btnInvestigate" runat="server" Text="Application Investigated" CssClass="btn btn-success" TabIndex="2" Width="200" Enabled="false" Visible="true" />
              </td>
              <td style="width:1%; text-align:right">
                &nbsp;
              </td>
              <td style="width:1%; text-align:right">
                <asp:Button ID="btnQualify" runat="server" Text="Application Qualified" CssClass="btn btn-success" TabIndex="3" Width="200" Enabled="false" Visible="true" />
              </td>              
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>
  <br />
  <br />
</asp:Content>
