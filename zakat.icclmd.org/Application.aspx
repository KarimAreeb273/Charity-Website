<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Application.aspx.vb" Inherits="zakat.icclmd.org.Application1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><span style="font-size:20px; color:darkgreen" class="fas fa-clipboard-list"></span>&nbsp;&nbsp;<b>Online Zakat Application</b></h4>
    <br />
    <div class="well well-sm">
      <h5><b>Review the Online Zakat Application and Take Action:</b></h5>
    </div>

    <ul class="nav nav-tabs">
      <li class="active">
        <a data-toggle="tab" href="#tabAppData">
          <b>Application Data</b>
        </a>
      </li>
      <li>
        <a data-toggle="tab" href="#tabAppHist">
          <b>Application History</b>&nbsp;
          <span class="label label-primary"><asp:Label ID="lblReviewsCountBadge" runat="server" Text="0"></asp:Label></span>
        </a>
      </li>
    </ul>
    
    <div class="tab-content">
      <div id="tabAppData" class="tab-pane fade in active">
        <br />
        <div class="row">
          <div class="col-lg-6">
            <table style="width: 100%">
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtOrganization" CssClass="control-label" Style="white-space: nowrap">Submitted To:</asp:Label>
                </td>
                <td>
                  <asp:HiddenField ID="txtOrganizationId" runat="server" />
                  <asp:Label runat="server" ID="txtOrganization" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="control-label" Style="white-space: nowrap">Email:</asp:Label>
                </td>
                <td>
                  <asp:HyperLink ID="btnEmail" runat="server" Target="_blank"></asp:HyperLink>
                  <asp:Label runat="server" ID="txtEmail" CssClass="control-label" Visible="false"></asp:Label>
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
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtValueCash" CssClass="control-label" Style="white-space: nowrap">Cash:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtValueCash" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtValueGold" CssClass="control-label" Style="white-space: nowrap">Gold:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtValueGold" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtValueSilver" CssClass="control-label" Style="white-space: nowrap">Silver:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtValueSilver" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtValueInvestment" CssClass="control-label" Style="white-space: nowrap">Investment:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtValueInvestment" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtValueRetirement" CssClass="control-label" Style="white-space: nowrap">Retirement:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtValueRetirement" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtValueLifeInsurance" CssClass="control-label" Style="white-space: nowrap">Life Insurance:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtValueLifeInsurance" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtValueDebt" CssClass="control-label" Style="white-space: nowrap">Outstanding Debt:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtValueDebt" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtValueChildSupport" CssClass="control-label" Style="white-space: nowrap">Child Support:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtValueChildSupport" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtChildSupportFrequency" CssClass="control-label" Style="white-space: nowrap">Child Support Frequency:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtChildSupportFrequency" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtValueFoodStamps" CssClass="control-label" Style="white-space: nowrap">Food Stamps:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtValueFoodStamps" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtFoodStampFrequency" CssClass="control-label" Style="white-space: nowrap">Food Stamp Frequency:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtFoodStampFrequency" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtValueAssistance" CssClass="control-label" Style="white-space: nowrap">Temporary Assistance:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtValueAssistance" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtWhoAssisted" CssClass="control-label" Style="white-space: nowrap">Who Assisted?:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtWhoAssisted" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr style="vertical-align: top">
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtLanguages" CssClass="control-label">Languages:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtLanguages" CssClass="control-label"></asp:Label>
                </td>
              </tr>
            </table>
          </div>
          <div class="col-lg-6">
            <table style="width: 100%">
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtApplicationsSubmitted" CssClass="control-label" Style="white-space: nowrap">Submitted Applications:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtApplicationsSubmitted" CssClass="control-label" Style="white-space: nowrap" Text="0"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtInsuranceProvider" CssClass="control-label" Style="white-space: nowrap">Insurance Provider:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtInsuranceProvider" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
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
                  <asp:Label runat="server" ID="txtHusbandExplanation" CssClass="control-label"></asp:Label>
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
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtPolicyNumber" CssClass="control-label" Style="white-space: nowrap">Policy Number:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtPolicyNumber" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtMedicare" CssClass="control-label" Style="white-space: nowrap">Medicare #:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtMedicare" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtMedicaid" CssClass="control-label" Style="white-space: nowrap">Medicaid #:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtMedicaid" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtEmployerName" CssClass="control-label" Style="white-space: nowrap">Employer Name:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtEmployerName" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtEmploymentStart" CssClass="control-label" Style="white-space: nowrap">Employment Start:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtEmploymentStart" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtEmploymentEnd" CssClass="control-label" Style="white-space: nowrap">Employment End:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtEmploymentEnd" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtPosition" CssClass="control-label" Style="white-space: nowrap">Position:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtPosition" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtEmployerPhone" CssClass="control-label" Style="white-space: nowrap">Employer Phone:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtEmployerPhone" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtMonthlySalary" CssClass="control-label" Style="white-space: nowrap">Monthly Salary:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtMonthlySalary" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtEmployerStreet" CssClass="control-label" Style="white-space: nowrap">Employer Street:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtEmployerStreet" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtEmployerCity" CssClass="control-label" Style="white-space: nowrap">Employer City:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtEmployerCity" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtEmployerState" CssClass="control-label" Style="white-space: nowrap">Employer State:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtEmployerState" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td>
                  <asp:Label runat="server" AssociatedControlID="txtEmployerZip" CssClass="control-label" Style="white-space: nowrap">Employer Zip:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtEmployerZip" CssClass="control-label" Style="white-space: nowrap"></asp:Label>
                </td>
              </tr>
              <tr>
                <td style="vertical-align: top">
                  <asp:Label runat="server" AssociatedControlID="txtCertSkills" CssClass="control-label">Certificates/Skills:</asp:Label>
                </td>
                <td>
                  <asp:Label runat="server" ID="txtCertSkills" CssClass="control-label"></asp:Label>
                </td>
              </tr>
            </table>
          </div>
          <div class="col-lg-12">
            <table style="width: 100%">
              <tr>
                <td style="width: 21%; vertical-align: top">
                  <asp:Label runat="server" AssociatedControlID="txtDependents" CssClass="control-label" Style="white-space: nowrap">Dependents:</asp:Label>
                </td>
                <td style="width: 79%">
                  <asp:Label runat="server" ID="txtDependents" CssClass="control-label"></asp:Label>
                </td>
              </tr>
              <tr>
                <td style="width: 21%; vertical-align: top">
                  <asp:Label runat="server" AssociatedControlID="txtPersonalStatement" CssClass="control-label" Style="white-space: nowrap">Personal Statement:</asp:Label>
                </td>
                <td style="width: 79%; text-align:justify">
                  <asp:Label runat="server" ID="txtPersonalStatement" CssClass="control-label"></asp:Label>
                </td>
              </tr>
              <tr>
                <td style="width: 21%; vertical-align: top">
                  <asp:Label runat="server" AssociatedControlID="txtPersonalStatement" CssClass="control-label" Style="white-space: nowrap">References:</asp:Label>
                </td>
                <td style="width: 79%; vertical-align: top"">
                  <table class="table table-hover" border="0" style="font-size:12px">
                    <asp:Repeater ID="rptReferences" runat="server">
                      <HeaderTemplate>
                        <tr style="height: 30px; border: solid solid solid solid">
                          <th style="text-align: left; width: 20%">Name</th>
                          <th style="text-align: left; width: 15%">Relationship</th>
                          <th style="text-align: left; width: 15%;">Known Since</th>
                          <th style="text-align: left; width: 15%">Phone</th>
                          <th style="text-align: left; width: 35%;">Address</th>
                        </tr>
                      </HeaderTemplate>
                      <ItemTemplate>
                        <tr>
                          <td style="text-align: left; vertical-align: middle">
                            <%# DataBinder.Eval(Container.DataItem, "firstName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "middleName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "lastName")%>
                          </td>
                          <td style="text-align: left; vertical-align: middle">
                            <%# DataBinder.Eval(Container.DataItem, "relationship")%>
                          </td>
                          <td style="text-align: left; vertical-align: middle">
                            <%# FormatDateTime(DataBinder.Eval(Container.DataItem, "knownsince"), DateFormat.GeneralDate)%>
                          </td>
                          <td style="text-align: left; vertical-align: middle">
                            <%# getFormattedPhone(DataBinder.Eval(Container.DataItem, "phone"))%>
                          </td>
                          
                          <td style="text-align: left; vertical-align: middle">
                            <%# DataBinder.Eval(Container.DataItem, "street")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "city")%>,&nbsp;<%# DataBinder.Eval(Container.DataItem, "stateAbbr")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "zip")%>
                          </td>
                        </tr>
                      </ItemTemplate>
                    </asp:Repeater>
                  </table>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
      <div id="tabAppHist" class="tab-pane fade">
        <br />
        <table class="table table-hover" border="0">
          <asp:Repeater ID="rptReviewHistory" runat="server">
            <HeaderTemplate>
              <tr style="height: 30px; border: solid solid solid solid">
                <th style="text-align: left; width: 15%">Name</th>
                <th style="text-align: left; width: 10%">Action</th>
                <th style="text-align: left; width: 15%;">Date of Action</th>
                <th style="text-align: left; width: 60%">Comment</th>
              </tr>
            </HeaderTemplate>
            <ItemTemplate>
              <tr>
                <td style="text-align: left; vertical-align: top">
                  <%# DataBinder.Eval(Container.DataItem, "USER.firstName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "USER.middleName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "USER.lastName")%>
                </td>
                <td style="text-align: left; vertical-align: top; white-space: nowrap">
                  <%# DataBinder.Eval(Container.DataItem, "reviewAction")%>
                </td>
                <td style="text-align: left; vertical-align: top">
                  <%# FormatDateTime(DataBinder.Eval(Container.DataItem, "reviewDate"), DateFormat.GeneralDate)%>
                </td>
                <td style="text-align: left; vertical-align: top">
                  <%# DataBinder.Eval(Container.DataItem, "reviewComment")%>
                </td>
              </tr>
            </ItemTemplate>
          </asp:Repeater>
        </table>
      </div>
    </div>

    <div class="row">
      <div class="form-group">
        <div class="col-lg-12">
          <asp:Panel ID="pnlReviewComments" runat="server" Visible="true">
            <table style="width:100%">
              <tr>
                <td colspan="3" style="width:100%; text-align:left">
                  <b>Review Comments:</b>
                </td>
              </tr>
              <tr>
                <td colspan="4" style="width:100%; text-align:left">
                  <asp:TextBox ID="txtReviewComments" CssClass="form-control" style="max-width:100%" runat="server" TextMode="MultiLine" Rows="4" Width="100%" MaxLength="1000" TabIndex="1"></asp:TextBox>
                  <asp:CustomValidator ID="valQualifier" runat="server" CssClass="text-danger" ControlToValidate="txtReviewComments" ErrorMessage="You cannot be the intial and final qualifier." Display="Dynamic" ValidationGroup="Review" />
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger" runat="server" Display="Static" ErrorMessage="The review comments are required." ControlToValidate="txtReviewComments" ValidationGroup="Review"></asp:RequiredFieldValidator>
                </td>
              </tr>
            </table>
          </asp:Panel>          
          <asp:Panel ID="pnlValidated" runat="server" Visible="false">
            <table style="width:100%">
              <tr>
                <td style="width:97%;">
                  &nbsp;
                </td>
                <td style="width:1%; text-align:right">
                  <asp:Button ID="btnValidated" runat="server" Text="Validated" CssClass="btn btn-success" TabIndex="2" Width="200" ValidationGroup="Review" />
                </td>
                <td style="width:1%;">
                  &nbsp;
                </td>
                <td style="width:1%; text-align:right">
                  <asp:Button ID="btnRejectedVal" runat="server" Text="Rejected" CssClass="btn btn-danger" TabIndex="3" Width="200"  ValidationGroup="Review" />
                </td>
              </tr>
            </table>
          </asp:Panel>
          <asp:Panel ID="pnlInvestigated" runat="server" Visible="False">
            <table style="width:100%">
              <tr>
                <td style="width:97%;">
                  &nbsp;
                </td>
                <td style="width:1%; text-align:right">
                  <asp:Button ID="btnInvestigated" runat="server" Text="Investigated" CssClass="btn btn-success" TabIndex="2" Width="200" ValidationGroup="Review" />
                </td>
                <td style="width:1%;">
                  &nbsp;
                </td>
                <td style="width:1%; text-align:right">
                  <asp:Button ID="btnRejectedInv" runat="server" Text="Rejected" CssClass="btn btn-danger" TabIndex="3" Width="200" ValidationGroup="Review" />
                </td>
              </tr>
            </table>
          </asp:Panel>
          <asp:Panel ID="pnlQualified1" runat="server" Visible="False">
            <table style="width:100%">
              <tr>
                <td style="width:97%;">
                  &nbsp;
                </td>
                <td style="width:1%; text-align:right">
                  <asp:Button ID="btnQualified1" runat="server" Text="Qualified (Initial)" CssClass="btn btn-success" TabIndex="2" Width="200" ValidationGroup="Review" />
                </td>
                <td style="width:1%;">
                  &nbsp;
                </td>
                <td style="width:1%; text-align:right">
                  <asp:Button ID="btnRejectedQal1" runat="server" Text="Rejected" CssClass="btn btn-danger" TabIndex="3" Width="200" ValidationGroup="Review" />
                </td>
              </tr>
            </table>
          </asp:Panel>
          <asp:Panel ID="pnlQualified2" runat="server" Visible="False">
            <table style="width:100%">
              <tr>
                <td style="width:97%;">
                  &nbsp;
                </td>
                <td style="width:1%; text-align:right">
                  <asp:Button ID="btnQualified2" runat="server" Text="Qualified (Final)" CssClass="btn btn-success" TabIndex="2" Width="200" ValidationGroup="Review" />
                </td>
                <td style="width:1%;">
                  &nbsp;
                </td>
                <td style="width:1%; text-align:right">
                  <asp:Button ID="btnRejectedQal2" runat="server" Text="Rejected" CssClass="btn btn-danger" TabIndex="3" Width="200" ValidationGroup="Review" />
                </td>
              </tr>
            </table>
          </asp:Panel>
          <asp:Panel ID="pnlDispersed" runat="server" Visible="False">
            <table style="width:100%" border="0">
              <tr>
                <td style="width:97%;">
                  &nbsp;
                </td>
                <td style="width:1%;">
                  <div class="form-inline">
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtDOB" CssClass="col-lg-2 control-label" ToolTip="Date of Birth" Style="white-space: nowrap; position:relative; left: -25px">Dispersed:</asp:Label>
                      <div class="col-lg-10">
                        <table border="0" style="width: 280px">
                          <tr>
                            <td style="width: 60%">
                              <asp:TextBox runat="server" ID="txtDispersedDate" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Date of Dispersion" BackColor="White" placeholder="mm/dd/yyyy" TabIndex="2"  ValidationGroup="Submit" />
                            </td>
                            <td>
                              &nbsp;
                            </td>
                            <td style="width: 40%; text-align: left;">
                              <a href="#" runat="server" id="lnkCalendarDOB">
                                <span class="glyphicon glyphicon-calendar" style="font-size: 20px; color: darkgreen" tabindex="2"></span>
                              </a>
                            </td>
                          </tr>
                        </table>
                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Invalid date." CssClass="text-danger" Display="Dynamic" ValidationExpression="^(0?[1-9]|1[0-2])/(0?[1-9]|1[0-9]|2[0-9]|3[01])/\d{4}$" ControlToValidate="txtDispersedDate" ValidationGroup="Review"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDispersedDate" CssClass="text-danger" ErrorMessage="Dispersed date is required." Display="Static" ValidationGroup="Review" />
                        <ajaxToolkit:CalendarExtender ID="calDOB" runat="server" TargetControlID="txtDispersedDate" PopupButtonID="lnkCalendarDOB" PopupPosition="TopRight" />
                      </div>
                    </div>
                  </div>                  
                </td>
                <td style="width:1%;">
                  &nbsp;
                </td>
                <td style="width:1%; text-align:right; vertical-align:top">
                  <asp:Button ID="btnDispersed" runat="server" Text="Dispersed" CssClass="btn btn-success" TabIndex="3" Width="200" ValidationGroup="Review" />
                </td>
                <td style="width:1%;">
                  &nbsp;
                </td>
                <td style="width:1%; text-align:right; vertical-align:top">
                  <asp:Button ID="btnRejectedDis" runat="server" Text="Rejected" CssClass="btn btn-danger" TabIndex="4" Width="200" ValidationGroup="Review" />
                </td>
              </tr>
            </table>
          </asp:Panel>
        </div>
      </div>
    </div>
  </div>
  <br />
  <br />
</asp:Content>
