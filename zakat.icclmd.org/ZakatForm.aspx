 <%@ Page Title="Zakat Form" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ZakatForm.aspx.vb" Inherits="zakat.icclmd.org.ZakatForm" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  
  <style type="text/css">
    body
    {
        font-family: inherit;
        font-size: 12px;
    }
    /* Accordion */
    .accordionHeader
    {
        border: 1px solid #2F4F4F;
        color: black;
        background-color: #f5f5f5;
        font-family: inherit;
        font-size: 12px;
        font-weight: bold;
        padding: 5px;
        margin-top: 5px;
        cursor: pointer;
        overflow:hidden;
    }
 
    #master_content .accordionHeader a
    {
        color: #FFFFFF;
        background: none;
        text-decoration: none;
    }
 
        #master_content .accordionHeader a:hover
        {
            background: none;
            text-decoration: underline;
        }
 
    .accordionHeaderSelected
    {
        border: 1px solid #2F4F4F;
        color: white;
        background-color: darkgreen;
        font-family: inherit;
        font-size: 12px;
        font-weight: bold;
        padding: 5px;
        margin-top: 5px;
        cursor: pointer;
        overflow:hidden;
    }
    .accordionContent
    {
      overflow:hidden;
    }
</style>

  <div class="container">
    <h4><b>New Zakat Application</b></h4>
    <div class="row">
      <div class="col-lg-12">
        <div class="well well-sm" style="text-align:justify">
          <div class="checkbox">
            <label><asp:CheckBox ID="chkAcknowledgement" runat="server" CssClass="checkbox" AutoPostBack="True" /><b>I Acknowledge and Consent:</b> By filling out or having the formed filled on my behalf and submitting this zakat application, I authorize the organization to verify the information contained therein. I understand I may be required to present proof of all the statements in this application upon request. I understand a representative of the organization will verify the necessary information in order to render any assistance to me in a timely and discreet manner. I am aware due to unforeseen circumstances, assistance I requested may be unavailable. When I submit this zakat application for review, I certify I have read, or had read to me all the statements in this online form and all the information given is true, correct, and complete to the best of my knowledge. If this application is approved, I authorize the zakat reviewers to pay any owed vendors directly on my behalf.</label>
          </div>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-12">
        <div class="well well-sm" style="text-align:justify; background-color: darkgreen; color: white">
          <table style="width: 100%">
            <tr>
              <td style="width: 60%; text-align: right">
                <h5>
                  Please specifiy the organization that you would like to submit this online zakat application to (* required):
                </h5>
              </td>
              <td style="width: 5%; text-align: right">
                &nbsp;
              </td>
              <td style="width: 35%; text-align: left; white-space: nowrap;">
                <asp:DropDownList ID="drpOrganization" runat="server" ToolTip="Organization" CssClass="form-control" TabIndex="1" Width="350px" AutoPostBack="True"></asp:DropDownList>
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>

    <ajaxToolkit:Accordion ID="accZakat" runat="server" BorderWidth="0px" RequireOpenedPane="False" FadeTransitions="True" HeaderCssClass="accordionHeader" HeaderSelectedCssClass="accordionHeaderSelected" ContentCssClass="accordionContent" SelectedIndex="-1" BorderStyle="None" AutoSize="None" Height="625px" Enabled="false">
      <Panes>
        <ajaxToolkit:AccordionPane runat="server" ID="paneApplicant" Visible="True" BorderStyle="None" TabIndex="1">
          <Header>
            <table style="width:100%">
              <tr>
                <th style="width:25%; text-align:left; vertical-align: middle">
                  Applicant Information
                </th>
                <th style="width:50%; text-align:center; vertical-align: middle">
                  <div class="progress" style="position: relative; top: 10px;">
                    <div id="prgApplicant" runat="server" class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%; color: black">
                      <asp:Literal ID="ltlPercentApplicant" runat="server" Text="0% Complete"></asp:Literal>
                    </div>
                  </div>
                </th>
                <th style="width:25%; text-align:right; vertical-align: middle">
                  <span class="glyphicon glyphicon-triangle-bottom"></span>
                </th>
              </tr>
            </table>
          </Header>
          <Content>
            <div id="FormOrder" runat="server">
              <table border="1" style="width:100%">
                <tr>
                  <td style="width:100%">
                    <br />
                    <table border="0" style="width:100%">
                      <tr>
                        <td style="width:50%">
                          <div class="col-lg-12">
                            <div class="form-horizontal">
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-lg-2 control-label" ToolTip="Email/Username" Style="white-space: nowrap">Email:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: lowercase;" runat="server" ID="txtEmail" AutoCompleteType="Disabled" CssClass="form-control" placeholder="email@domain.com" ToolTip="Email/Username" MaxLength="60" AutoPostBack="True" TabIndex="1" ValidationGroup="Submit" />
                                  <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="A valid email/username is required." ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" CssClass="text-danger" Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                  <asp:CustomValidator ID="valDuplicateEmail" runat="server" CssClass="text-danger" ControlToValidate="txtEmail" ErrorMessage="This username/email is already registered. Login" Display="Dynamic" ValidationGroup="Submit" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The email/username is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>                            
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="col-lg-2 control-label" ToolTip="First Name" Style="white-space: nowrap">First Name:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtFirstName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="First Name" MaxLength="30" TabIndex="2" AutoPostBack="True" ValidationGroup="Submit" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" CssClass="text-danger" ErrorMessage="The first name is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtMiddleName" CssClass="col-lg-2 control-label" ToolTip="Middle Name" Style="white-space: nowrap">Middle Name:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;"  runat="server" ID="txtMiddleName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Middle Name" MaxLength="30" TabIndex="3" AutoPostBack="False" ValidationGroup="Submit" />
                                  <asp:CustomValidator ID="CustomValidator5" runat="server" CssClass="text-danger" ControlToValidate="txtMiddleName" ErrorMessage="middle" Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtLastName" CssClass="col-lg-2 control-label" ToolTip="Last Name" Style="white-space: nowrap">Last Name:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;"  runat="server" ID="txtLastName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Last Name" MaxLength="30" TabIndex="4" AutoPostBack="True" ValidationGroup="Submit" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" CssClass="text-danger" Display="Static" ErrorMessage="The last name is required." ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtSocialSecurity" CssClass="col-lg-2 control-label" ToolTip="Social Security #" Style="white-space: nowrap">SSN:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox runat="server" ID="txtSocialSecurity" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Social Security #" MaxLength="11" placeholder="123-45-6789" TabIndex="5" ValidationGroup="Submit" AutoPostBack="True" />
                                  <asp:RegularExpressionValidator ID="valSSNFormat" runat="server" ControlToValidate="txtSocialSecurity" CssClass="text-danger" ValidationExpression="^\d{3}-\d{2}-\d{4}$" ErrorMessage="Please enter a valid SSN" Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSocialSecurity" CssClass="text-danger" ErrorMessage="The SSN is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtDOB" CssClass="col-lg-2 control-label" ToolTip="Date of Birth" Style="white-space: nowrap">Date of Birth:</asp:Label>
                                <div class="col-lg-10">
                                  <table border="0" style="width: 280px">
                                    <tr>
                                      <td style="width: 90%">
                                        <asp:TextBox runat="server" ID="txtDOB" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Date of Birth" BackColor="White" placeholder="mm/dd/yyyy" TabIndex="6" AutoPostBack="True" ValidationGroup="Submit" />
                                      </td>
                                      <td style="width: 10%; text-align: center;">
                                        <a href="#" runat="server" id="lnkCalendarDOB">
                                          <span class="glyphicon glyphicon-calendar" style="font-size: 20px; color: darkgreen" tabindex="6"></span>
                                        </a>
                                      </td>
                                    </tr>
                                  </table>
                                  <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter a valid date." CssClass="text-danger" Display="Dynamic" ValidationExpression="^(0?[1-9]|1[0-2])/(0?[1-9]|1[0-9]|2[0-9]|3[01])/\d{4}$" ControlToValidate="txtDOB" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDOB" CssClass="text-danger" ErrorMessage="The date of birth is required." Display="Static" ValidationGroup="Submit" />
                                  <ajaxToolkit:CalendarExtender ID="calDOB" runat="server" TargetControlID="txtDOB" PopupButtonID="lnkCalendarDOB" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtPhone" CssClass="col-lg-2 control-label" ToolTip="Phone #" Style="white-space: nowrap">Phone #:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox runat="server" ID="txtPhone" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Phone #" MaxLength="12" placeholder="555-555-1234" TabIndex="7" AutoPostBack="True" ValidationGroup="Submit" />
                                  <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ValidationExpression="^(1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$" ErrorMessage="Please enter a valid phone number" Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ErrorMessage="The phone number is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="chkGender" CssClass="col-lg-2 control-label" ToolTip="Gender" Style="white-space: nowrap; position: relative; top: 0px;">Gender:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:RadioButtonList ID="chkGender" runat="server" RepeatDirection="Horizontal" Style="position: relative; top: 6px;" ToolTip="Gender" TabIndex="8" AutoPostBack="True" ValidationGroup="Submit">
                                    <asp:ListItem Text="Male" Value="Male">&nbsp;&nbsp;Male&nbsp;&nbsp;</asp:ListItem>
                                    <asp:ListItem Text="Female" Value="Female">&nbsp;&nbsp;Female</asp:ListItem>
                                  </asp:RadioButtonList>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="chkGender" CssClass="text-danger" Display="Static" ErrorMessage="The gender is required." ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="drpMaritalStatus" CssClass="col-lg-2 control-label" ToolTip="Marital Status" Style="white-space: nowrap; position: relative; top: 0px;">Marital Status:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:DropDownList ID="drpMaritalStatus" runat="server" ToolTip="Marital Status" CssClass="form-control" TabIndex="9" AutoPostBack="True" ValidationGroup="Submit">
                                    <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Single" Value="Single"></asp:ListItem>
                                    <asp:ListItem Text="Married" Value="Married"></asp:ListItem>
                                    <asp:ListItem Text="Divorced" Value="Divorced"></asp:ListItem>
                                  </asp:DropDownList>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="drpMaritalStatus" CssClass="text-danger" ErrorMessage="The marital status is required." InitialValue="(Select One)" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtStreet" CssClass="col-lg-2 control-label" ToolTip="Address Street" Style="white-space: nowrap">Street:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;"  runat="server" ID="txtStreet" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address Street" MaxLength="100" TabIndex="10" AutoPostBack="True" ValidationGroup="Submit" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStreet" CssClass="text-danger" ErrorMessage="The address street is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                            </div>
                          </div>
                        </td>
                        <td style="width:50%">
                          <div class="col-lg-12">
                            <div class="form-horizontal">                              
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtCity" CssClass="col-lg-2 control-label" ToolTip="Address City" Style="white-space: nowrap">City:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;"  runat="server" ID="txtCity" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address City" MaxLength="50" TabIndex="11" AutoPostBack="True" ValidationGroup="Submit" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity" CssClass="text-danger" ErrorMessage="The address city is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="drpState" CssClass="col-lg-2 control-label" ToolTip="Address State" Style="white-space: nowrap; position: relative; top: 0px;">State:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:DropDownList ID="drpState" runat="server" ToolTip="Address State" CssClass="form-control" TabIndex="12" AutoPostBack="True" ValidationGroup="Submit"></asp:DropDownList>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="drpState" CssClass="text-danger" ErrorMessage="The address state is required." InitialValue="(Select One)" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtZip" CssClass="col-lg-2 control-label" ToolTip="Address Zip" Style="white-space: nowrap">Zip Code:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox runat="server" ID="txtZip" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address Zip" MaxLength="5" TabIndex="13" AutoPostBack="True" ValidationGroup="Submit" />
                                  <asp:RegularExpressionValidator runat="server" ControlToValidate="txtZip" CssClass="text-danger" ValidationExpression="^\d{5}$" ErrorMessage="Please enter a valid zip code" Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtZip" CssClass="text-danger" ErrorMessage="The address zip code is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtBeganLiving" CssClass="col-lg-2 control-label" ToolTip="Began Living Date" Style="white-space: nowrap">Began Living:</asp:Label>
                                <div class="col-lg-10">
                                  <table border="0" style="width: 280px">
                                    <tr>
                                      <td style="width: 90%">
                                        <asp:TextBox runat="server" ID="txtBeganLiving" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Began Living Date" BackColor="White" placeholder="mm/dd/yyyy" TabIndex="14" AutoPostBack="True" ValidationGroup="Submit" />
                                      </td>
                                      <td style="width: 10%; text-align: center;">
                                        <a href="#" runat="server" id="lnkCalendarBeganLiving">
                                          <span class="glyphicon glyphicon-calendar" style="font-size: 20px; color: darkgreen" tabindex="14"></span>
                                        </a>
                                      </td>
                                    </tr>
                                  </table>
                                  <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter a valid date." CssClass="text-danger" Display="Dynamic" ValidationExpression="^(0?[1-9]|1[0-2])/(0?[1-9]|1[0-9]|2[0-9]|3[01])/\d{4}$" ControlToValidate="txtBeganLiving" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBeganLiving" CssClass="text-danger" ErrorMessage="The time resided at the home is required." Display="Static" ValidationGroup="Submit" />
                                  <ajaxToolkit:CalendarExtender ID="calBeganLiving" runat="server" TargetControlID="txtBeganLiving" PopupButtonID="lnkCalendarBeganLiving" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="drpHomeType" AutoCompleteType="Disabled" CssClass="col-lg-2 control-label" ToolTip="Home Type" Style="white-space: nowrap; position: relative; top: 0px;">Home Type:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:DropDownList ID="drpHomeType" runat="server" ToolTip="Home Type" CssClass="form-control" TabIndex="15" AutoPostBack="True" ValidationGroup="Submit">
                                    <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Own" Value="Own"></asp:ListItem>
                                    <asp:ListItem Text="Rent" Value="Rent"></asp:ListItem>
                                    <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                  </asp:DropDownList>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="drpHomeType" CssClass="text-danger" ErrorMessage="The home type is required." InitialValue="(Select One)" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtHomeType" CssClass="col-lg-2 control-label" ToolTip="Home Type" Style="white-space: nowrap">Specify:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtHomeType" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Specify Home Type" MaxLength="50" TabIndex="16" AutoPostBack="True" Enabled="False" ValidationGroup="Submit" />
                                  <asp:RequiredFieldValidator runat="server" ID="valHomeType" Enabled="false" ControlToValidate="txtHomeType" CssClass="text-danger" ErrorMessage="Please specify the other home type." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="drpNationality" CssClass="col-lg-2 control-label" ToolTip="Nationality" Style="white-space: nowrap; position: relative; top: 0px;">Nationality:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:DropDownList ID="drpNationality" runat="server" ToolTip="Nationality" CssClass="form-control" TabIndex="17" AutoPostBack="True" ValidationGroup="Submit">
                                    <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                                  </asp:DropDownList>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="drpCitizenship" CssClass="text-danger" ErrorMessage="The nationality is required." InitialValue="(Select One)" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="drpCitizenship" CssClass="col-lg-2 control-label" ToolTip="Citizenship Status" Style="white-space: nowrap; position: relative; top: 0px;">Citizenship:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:DropDownList ID="drpCitizenship" runat="server" ToolTip="Citizenship Status" CssClass="form-control" TabIndex="18" AutoPostBack="True" ValidationGroup="Submit">
                                    <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Permanent Resident" Value="Permanent Resident"></asp:ListItem>
                                    <asp:ListItem Text="Non-Citizen" Value="Non-Citizen"></asp:ListItem>
                                    <asp:ListItem Text="US Citizen" Value="US Citizen"></asp:ListItem>
                                    <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                  </asp:DropDownList>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="drpCitizenship" CssClass="text-danger" ErrorMessage="The citizenship status is required." InitialValue="(Select One)" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtMasjidName" CssClass="col-lg-2 control-label" ToolTip="Primary Masjid Name" Style="white-space: nowrap">Pr Masjid Name:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;"  runat="server" ID="txtMasjidName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Primary Masjid Name" MaxLength="30" TabIndex="19" AutoPostBack="false" ValidationGroup="Submit" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMasjidName" CssClass="text-danger" ErrorMessage="Your primary masjid name is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtMasjidPhone" CssClass="col-lg-2 control-label" ToolTip="Primary Masjid Phone #" Style="white-space: nowrap">Pr Masjid Ph #:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox runat="server" ID="txtMasjidPhone" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Primary Masjid Phone #" MaxLength="12" placeholder="555-555-1234" TabIndex="20" AutoPostBack="false" ValidationGroup="Submit" />
                                  <asp:RegularExpressionValidator runat="server" ControlToValidate="txtMasjidPhone" CssClass="text-danger" ValidationExpression="^(1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$" ErrorMessage="Please enter a valid phone number" Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMasjidPhone" CssClass="text-danger" ErrorMessage="The masjid phone number is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                            </div>
                          </div>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td>
                    <table border="1" style="width:100%; border-top-color: white; border-left-color:white; border-right-color:white; border-bottom-color:black">
                      <tr>
                        <th style="width:100%; text-align:left; vertical-align: middle; background-color: #eee">
                          Skills, Certs and Education
                          <br /><br />
                        </th>
                      </tr>
                    </table>
                    <br />
                    <table border="0" style="width:100%">
                      <tr>
                        <td style="width:50%">
                          <div class="col-lg-12">
                            <div class="form-horizontal">
                              <table border="0" style="width: 100%; white-space: nowrap">
                                <tr>
                                  <td style="width: 45%">
                                    <b>Languages:</b><br />
                                    <asp:ListBox ID="lstLanguages"  runat="server" CssClass="form-control" AutoPostBack="False" Rows="5" Width="100%" TabIndex="21" ></asp:ListBox>
                                  </td>
                                  <td style="text-align: center;width: 10%">
                                    <br /><br />
                                    <asp:LinkButton ID="btnAddLanguage" runat="server" ToolTip="Add the Language" TabIndex="22" CausesValidation="false" >
                                      <span class="fas fa-arrow-alt-circle-right" style="color: darkgreen; font-size: 25px" ></span>
                                    </asp:LinkButton>
                                    <br /><br />
                                    <asp:LinkButton ID="btnDeleteLanguage" runat="server" ToolTip="Remove the Language" TabIndex="23" CausesValidation="false" >
                                      <span class="fas fa-arrow-alt-circle-left" style="color: darkgreen; font-size: 25px" ></span>
                                    </asp:LinkButton>
                                    <br /><br />
                                  </td>
                                  <td style="width: 45%">
                                    <b>Languages Spoken:</b><br />
                                    <asp:ListBox ID="lstSpoken"  runat="server" CssClass="form-control" AutoPostBack="False" Rows="5" Width="100%" TabIndex="24" ></asp:ListBox>
                                  </td>
                                </tr>
                              </table>
                              <br />
                              <table style="width: 100%; white-space: nowrap">
                                <tr>
                                  <td style="width: 100%">
                                    <b>Enter a Skill or Certification then Add to your List:</b><br />
                                    <table border="0" style="width: 100%">
                                      <tr>
                                        <td style="width: 95%">
                                          <asp:TextBox ID="txtSkillCertification" AutoCompleteType="Disabled" runat="server" CssClass="form-control" style="max-width:100%;width:100%;text-transform: capitalize;" TabIndex="25" MaxLength="100"></asp:TextBox>
                                        </td>
                                        <td>&nbsp;</td>
                                        <td style="width: 5%; vertical-align: middle">
                                          <asp:LinkButton ID="btnAddCertification" runat="server" style="width:100%;" TabIndex="26" CausesValidation="false" ToolTip="Add Certification to List"><i class="fas fa-plus-circle" style="font-size:20px;color:darkgreen"></i></asp:LinkButton>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                                <tr>
                                  <td style="width: 100%">
                                    <br /><b>Skills and Certifications:</b><br />
                                    <table border="0" style="width: 100%">
                                      <tr>
                                        <td style="width: 95%; vertical-align: middle"">
                                          <asp:ListBox ID="lstSkillCertification" runat="server" AutoPostBack="False" Rows="4" CssClass="form-control" style="max-width:100%;width:100%" TabIndex="27" ></asp:ListBox>
                                        </td>
                                        <td>&nbsp;</td>
                                        <td style="width: 5%; vertical-align: bottom">
                                          <asp:LinkButton ID="btnRemoveCertification" runat="server" style="width:100%; position:relative; top:-5px" TabIndex="28" CausesValidation="false" ToolTip="Remove Certification from List"><i class="fas fa-minus-circle" style="font-size:20px;color:red"></i></asp:LinkButton>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                              </table>
                              <br /><br />
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="drpHighestEducation" CssClass="col-lg-4 control-label" ToolTip="Highest Education Completed" style="white-space: nowrap; position: relative; top: 0px;">Highest Education Completed:</asp:Label>
                                <div class="col-lg-8">
                                  <asp:DropDownList ID="drpHighestEducation" style="max-width: 100%;" runat="server" ToolTip="Highest Education Completed" CssClass="form-control" TabIndex="29" AutoPostBack="True" ValidationGroup="Submit">
                                    <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="High School Diploma/GED" Value="High School Diploma/GED"></asp:ListItem>
                                    <asp:ListItem Text="Associate Degree or Certificate" Value="Associate Degree or Certificate"></asp:ListItem>
                                    <asp:ListItem Text="Bachelors Degree" Value="Bachelors Degree"></asp:ListItem>
                                    <asp:ListItem Text="Masters Degree" Value="Masters Degree"></asp:ListItem>
                                    <asp:ListItem Text="Ph.D or Advanced Progressional Degree" Value="Ph.D or Advanced Progressional Degree"></asp:ListItem>
                                    <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                  </asp:DropDownList>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="drpHighestEducation" CssClass="text-danger" ErrorMessage="The highest education completed is required." InitialValue="(Select One)" ValidationGroup="Submit" />
                                </div>
                              </div>
                            </div>
                          </div>
                        </td>
                        <td style="width:50%">
                          <div class="col-lg-12">
                            <br />
                            <div class="form-horizontal">
                              <div class="form-group">
                                <asp:Label runat="server" CssClass="col-lg-2 control-label">&nbsp;</asp:Label>
                                <div class="col-lg-10">
                                  <label>
                                    <asp:CheckBox ID="chkIsInternational" TabIndex="30" runat="server" AutoPostBack="True" /><b>&nbsp;International School</b>
                                  </label>
                                  <asp:CustomValidator ID="CustomValidator3" runat="server" ErrorMessage="CustomValidator" Text="temp"></asp:CustomValidator>
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtSchoolName" CssClass="col-lg-2 control-label" ToolTip="School Name" Style="white-space: nowrap">School Name:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtSchoolName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="School Name" MaxLength="100" TabIndex="31" AutoPostBack="True" ValidationGroup="Submit" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSchoolName" CssClass="text-danger" ErrorMessage="The school name is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                  <asp:Label runat="server" AssociatedControlID="txtSchoolCity" CssClass="col-lg-2 control-label" ToolTip="Address City" Style="white-space: nowrap">School City:</asp:Label>
                                  <div class="col-lg-10">
                                    <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtSchoolCity" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address City" MaxLength="50" TabIndex="32" AutoPostBack="True" ValidationGroup="Submit" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSchoolCity" CssClass="text-danger" ErrorMessage="The school city is required." Display="Static" ValidationGroup="Submit" />
                                  </div>
                                </div>
                              <asp:Panel ID="pnlDomestic" runat="server">
                                <div class="form-group">
                                  <asp:Label runat="server" AssociatedControlID="txtSchoolStreet" CssClass="col-lg-2 control-label" ToolTip="Address Street" Style="white-space: nowrap">School Street:</asp:Label>
                                  <div class="col-lg-10">
                                    <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtSchoolStreet" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address Street" MaxLength="100" TabIndex="33" AutoPostBack="True" ValidationGroup="Submit" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSchoolStreet" CssClass="text-danger" ErrorMessage="The school street is required." Display="Static" ValidationGroup="Submit" />
                                  </div>
                                </div>
                                <div class="form-group">
                                  <asp:Label runat="server" AssociatedControlID="drpSchoolState" CssClass="col-lg-2 control-label" ToolTip="Address State" Style="white-space: nowrap; position: relative; top: 0px;">School State:</asp:Label>
                                  <div class="col-lg-10">
                                    <asp:DropDownList ID="drpSchoolState" runat="server" ToolTip="Address State" CssClass="form-control" TabIndex="34" AutoPostBack="True" ValidationGroup="Submit"></asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="drpSchoolState" CssClass="text-danger" ErrorMessage="The school state is required." InitialValue="(Select One)" ValidationGroup="Submit" />
                                  </div>
                                </div>
                                <div class="form-group">
                                  <asp:Label runat="server" AssociatedControlID="txtSchoolZip" CssClass="col-lg-2 control-label" ToolTip="Address Zip" Style="white-space: nowrap">School Zip:</asp:Label>
                                  <div class="col-lg-10">
                                    <asp:TextBox runat="server" ID="txtSchoolZip" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address Zip" MaxLength="5" TabIndex="35" AutoPostBack="True" ValidationGroup="Submit" />
                                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtSchoolZip" CssClass="text-danger" ValidationExpression="^\d{5}$" ErrorMessage="Please enter a valid zip code" Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSchoolZip" CssClass="text-danger" ErrorMessage="The school zip code is required." Display="Static" ValidationGroup="Submit" />
                                  </div>
                                </div>
                              </asp:Panel>
                              <asp:Panel ID="pnlInternational" runat="server" Visible="false">
                                <div class="form-group">
                                  <asp:Label runat="server" AssociatedControlID="drpSchoolCountry" CssClass="col-lg-2 control-label" ToolTip="Address Country" Style="white-space: nowrap; position: relative; top: 0px;">School Country:</asp:Label>
                                  <div class="col-lg-10">
                                    <asp:DropDownList ID="drpSchoolCountry" runat="server" ToolTip="Address Country" CssClass="form-control" TabIndex="36" AutoPostBack="True" ValidationGroup="Submit"></asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="drpSchoolCountry" CssClass="text-danger" ErrorMessage="The school country is required." InitialValue="(Select One)" ValidationGroup="Submit" />
                                  </div>
                                </div>
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                                <br />
                              </asp:Panel>
                            </div>
                          </div>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td>
                    <asp:Panel ID="pnlHusbandInformation" Visible="false" runat="server">
                      <table border="1" style="width:100%; border-top-color: white; border-left-color:white; border-right-color:white; border-bottom-color:black">
                        <tr>
                          <th style="width:100%; text-align:left; vertical-align: middle; background-color: #eee">
                            Husband Information - If Female and (Married or Divorced)
                            <br /><br />
                          </th>
                        </tr>
                      </table>
                      <br />
                      <table border="0" style="width:100%">
                        <tr>
                          <td style="width:50%; vertical-align: top">
                            <div class="col-lg-12">
                              <div class="form-horizontal">
                                <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtHusbandFirstName" CssClass="col-lg-2 control-label" ToolTip="First Name" Style="white-space: nowrap">First Name:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtHusbandFirstName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="First Name" MaxLength="30" TabIndex="35" AutoPostBack="True" ValidationGroup="Submit" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtHusbandFirstName" CssClass="text-danger" ErrorMessage="The husband first name is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                                <div class="form-group">
                                  <asp:Label runat="server" AssociatedControlID="txtHusbandMiddleName" CssClass="col-lg-2 control-label" ToolTip="Middle Name" Style="white-space: nowrap">Middle Name:</asp:Label>
                                  <div class="col-lg-10">
                                    <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtHusbandMiddleName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Middle Name" MaxLength="30" TabIndex="36" AutoPostBack="False" ValidationGroup="Submit" />
                                    <asp:CustomValidator ID="CustomValidator6" runat="server" CssClass="text-danger" ControlToValidate="txtHusbandMiddleName" ErrorMessage="middle" Display="Static" ValidationGroup="Submit" />
                                  </div>
                                </div>
                                <div class="form-group">
                                  <asp:Label runat="server" AssociatedControlID="txtHusbandLastName" CssClass="col-lg-2 control-label" ToolTip="Last Name" Style="white-space: nowrap">Last Name:</asp:Label>
                                  <div class="col-lg-10">
                                    <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtHusbandLastName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Last Name" MaxLength="30" TabIndex="37" AutoPostBack="True" ValidationGroup="Submit" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtHusbandLastName" CssClass="text-danger" Display="Static" ErrorMessage="The husband last name is required." ValidationGroup="Submit" />
                                  </div>
                                </div>
                                <div class="form-group">
                                  <asp:Label runat="server" AssociatedControlID="txtHusbandPhone" CssClass="col-lg-2 control-label" ToolTip="Phone #" Style="white-space: nowrap">Phone #:</asp:Label>
                                  <div class="col-lg-10">
                                    <asp:TextBox runat="server" ID="txtHusbandPhone" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Phone #" MaxLength="12" placeholder="555-555-1234" TabIndex="38" AutoPostBack="True" ValidationGroup="Submit" />
                                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtHusbandPhone" CssClass="text-danger" ValidationExpression="^(1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$" ErrorMessage="Please enter a valid phone number" Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtHusbandPhone" CssClass="text-danger" ErrorMessage="The husband phone # is required." Display="Static" ValidationGroup="Submit" />
                                  </div>
                                </div> 
                              </div>
                            </div>
                          </td>
                          <td style="width:50%; vertical-align: top; text-align: left">
                            <div class="col-lg-12">
                              <div class="form-horizontal">
                                <div class="form-group">
                                  <asp:Label runat="server" AssociatedControlID="txtHusbandEmail" CssClass="col-lg-2 control-label" ToolTip="Email" Style="white-space: nowrap">Email:</asp:Label>
                                  <div class="col-lg-10">
                                    <asp:TextBox style="text-transform: lowercase;" runat="server" ID="txtHusbandEmail" AutoCompleteType="Disabled" CssClass="form-control" placeholder="email@domain.com" ToolTip="Email" MaxLength="60" AutoPostBack="True" TabIndex="39" ValidationGroup="Submit" />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server" ErrorMessage="A valid husband email is required." ControlToValidate="txtHusbandEmail" ValidationExpression="^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" CssClass="text-danger" Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtHusbandEmail" CssClass="text-danger" ErrorMessage="The husband email is required." Display="Static" ValidationGroup="Submit" />
                                  </div>
                                </div> 
                                <div class="form-group">
                                  <asp:Label runat="server" CssClass="col-lg-2 control-label" ToolTip="" Style="white-space: nowrap; position: relative; top: 0px;">&nbsp;</asp:Label>
                                  <div class="col-lg-10">
                                    <asp:Label runat="server" AssociatedControlID="chkHusbandApplied" CssClass="control-label" ToolTip="Has the Husband Applied" Style="white-space: nowrap; position: relative; top: 0px;">Has your husband applied for zakat?</asp:Label><br />
                                  </div>
                                </div>
                                <div class="form-group">
                                  <asp:Label runat="server" CssClass="col-lg-2 control-label" ToolTip="" Style="white-space: nowrap; position: relative; top: 0px;">&nbsp;</asp:Label>
                                  <div class="col-lg-10">
                                    <asp:RadioButtonList ID="chkHusbandApplied" runat="server" RepeatDirection="Horizontal" Style="position: relative; top: 6px;" ToolTip="Hus" TabIndex="40" ValidationGroup="Submit" AutoPostBack="True">
                                      <asp:ListItem Text="Yes" Value="Yes">&nbsp;&nbsp;Yes&nbsp;&nbsp;</asp:ListItem>
                                      <asp:ListItem Text="No" Value="No">&nbsp;&nbsp;No (Fill out the field below)</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="chkHusbandApplied" CssClass="text-danger" Display="Static" ErrorMessage="Indication of whether your husband applied for zakat is required." ValidationGroup="Submit" />
                                  </div>
                                </div>
                                <div class="form-group">
                                  <asp:Label runat="server" CssClass="col-lg-2 control-label" ToolTip="" Style="white-space: nowrap; position: relative; top: 0px;">&nbsp;</asp:Label>
                                  <div class="col-lg-10">
                                    <asp:Label runat="server" AssociatedControlID="chkHusbandApplied" CssClass="control-label" ToolTip="Has the Husband Applied" Style="white-space: nowrap; position: relative; top: 0px;">Briefly explain why your husband has not filed for zakat:</asp:Label><br />
                                  </div>
                                </div>
                                <div class="form-group">
                                  <asp:Label runat="server" CssClass="col-lg-2 control-label" ToolTip="" Style="white-space: nowrap; position: relative; top: 0px;">&nbsp;</asp:Label>
                                  <div class="col-lg-10">
                                    <asp:TextBox runat="server" ID="txtHusbandExplanation" CssClass="form-control" AutoCompleteType="Disabled" ToolTip="Explanation for husband not applying" MaxLength="1000" TabIndex="41" TextMode="MultiLine" Rows="2" Width="100%" style="max-width:100%" ValidationGroup="Submit" AutoPostBack="True" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtHusbandExplanation" CssClass="text-danger" ErrorMessage="The explanation for husband not applying is required." Display="Static" ValidationGroup="Submit" />
                                  </div>
                                </div>
                              </div>
                            </div>
                          </td>
                        </tr>
                      </table>
                    </asp:Panel>
                  </td>
                </tr>
              </table>
            </div>
          </Content>
        </ajaxToolkit:AccordionPane>
        <ajaxToolkit:AccordionPane runat="server" ID="paneAssetsAndSupport" TabIndex="100">
          <Header>
            <table style="width:100%">
              <tr>
                <th style="width:25%; text-align:left; vertical-align: middle">
                  Assets and Support
                </th>
                <th style="width:50%; text-align:center; vertical-align: middle">
                  <div class="progress" style="position: relative; top: 10px;">
                    <div id="prgAssetsAndSupport" runat="server" class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="91" aria-valuemin="0" aria-valuemax="100" style="width:91%; color: black">
                      <asp:Literal ID="ltlPercentAssetsAndSupport" runat="server" Text="91% Complete"></asp:Literal>
                    </div>
                  </div>
                </th>
                <th style="width:25%; text-align:right; vertical-align: middle">
                  <span class="glyphicon glyphicon-triangle-bottom"></span>
                </th>
              </tr>
            </table>
          </Header>
          <Content>
            <table border="1" style="width:100%">
              <tr>
                <td style="width:100%; padding: 5px">
                  <br />
                  <table border="0" style="width:100%">
                    <tr>
                      <td style="width:50%">
                        <div class="col-lg-12">
                          <div class="form-horizontal">
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtValueCash" CssClass="col-lg-2 control-label" ToolTip="Cash Value Possessed" Style="white-space: nowrap">Cash Value:</asp:Label>
                              <div class="col-lg-10">
                                <table style="width:100%">
                                  <tr>
                                    <td>
                                      <asp:Label runat="server" AssociatedControlID="txtValueCash" style="white-space: nowrap; position:relative; top:-5px">$</asp:Label>
                                    </td>
                                    <td>
                                      <asp:TextBox runat="server" ID="txtValueCash" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Cash Value Possessed" MaxLength="5" TabIndex="101" AutoPostBack="True" Text="0" ValidationGroup="Submit" />
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Enter a valid currency amount." ControlToValidate="txtValueCash" ValidationExpression="^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{2})?$" ValidationGroup="Submit" Display="Dynamic" CssClass="text-danger"></asp:RegularExpressionValidator>
                                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtValueCash" CssClass="text-danger" ErrorMessage="The cash value possessed is required." Display="Static" ValidationGroup="Submit" />
                                    </td>
                                  </tr>
                                </table>                                
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtValueGold" CssClass="col-lg-2 control-label" ToolTip="Gold Value Possessed" Style="white-space: nowrap">Gold Value:</asp:Label>
                              <div class="col-lg-10">
                                <table style="width:100%">
                                  <tr>
                                    <td>
                                      <asp:Label runat="server" AssociatedControlID="txtValueGold" style="white-space: nowrap; position:relative; top:-5px">$</asp:Label>
                                    </td>
                                    <td>
                                      <asp:TextBox runat="server" ID="txtValueGold" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Gold Value Possessed" MaxLength="5" TabIndex="102" AutoPostBack="True" Text="0" ValidationGroup="Submit" />
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Enter a valid currency amount." ControlToValidate="txtValueGold" ValidationExpression="^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{2})?$" ValidationGroup="Submit" Display="Dynamic" CssClass="text-danger"></asp:RegularExpressionValidator>
                                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtValueGold" CssClass="text-danger" ErrorMessage="The gold value possessed is required." Display="Static" ValidationGroup="Submit" />
                                    </td>
                                  </tr>
                                </table>
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtValueSilver" CssClass="col-lg-2 control-label" ToolTip="Silver Value Possessed" Style="white-space: nowrap">Silver Value:</asp:Label>
                              <div class="col-lg-10">
                                <table style="width:100%">
                                  <tr>
                                    <td>
                                      <asp:Label runat="server" AssociatedControlID="txtValueSilver" style="white-space: nowrap; position:relative; top:-5px">$</asp:Label>
                                    </td>
                                    <td>
                                      <asp:TextBox runat="server" ID="txtValueSilver" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Silver Value Possessed" MaxLength="5" TabIndex="103" AutoPostBack="True" Text="0" ValidationGroup="Submit" />
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Enter a valid currency amount." ControlToValidate="txtValueSilver" ValidationExpression="^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{2})?$" ValidationGroup="Submit" Display="Dynamic" CssClass="text-danger"></asp:RegularExpressionValidator>
                                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtValueSilver" CssClass="text-danger" ErrorMessage="The silver value possessed is required." Display="Static" ValidationGroup="Submit" />
                                    </td>
                                  </tr>
                                </table>
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtValueInvestment" CssClass="col-lg-2 control-label" ToolTip="Investments Value Possessed" Style="white-space: nowrap">Investments:</asp:Label>
                              <div class="col-lg-10">
                                <table style="width:100%">
                                  <tr>
                                    <td>
                                      <asp:Label runat="server" AssociatedControlID="txtValueInvestment" style="white-space: nowrap; position:relative; top:-5px">$</asp:Label>
                                    </td>
                                    <td>
                                      <asp:TextBox runat="server" ID="txtValueInvestment" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Investments Value Possessed" MaxLength="5" TabIndex="104" AutoPostBack="True" Text="0" ValidationGroup="Submit" />
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Enter a valid currency amount." ControlToValidate="txtValueInvestment" ValidationExpression="^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{2})?$" ValidationGroup="Submit" Display="Dynamic" CssClass="text-danger"></asp:RegularExpressionValidator>
                                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtValueInvestment" CssClass="text-danger" ErrorMessage="The investments value possessed is required." Display="Static" ValidationGroup="Submit" />
                                    </td>
                                  </tr>
                                </table>
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtValueRetirement" CssClass="col-lg-2 control-label" ToolTip="Retirement Value Possessed" Style="white-space: nowrap">Retirement:</asp:Label>
                              <div class="col-lg-10">
                                <table style="width:100%">
                                  <tr>
                                    <td>
                                      <asp:Label runat="server" AssociatedControlID="txtValueRetirement" style="white-space: nowrap; position:relative; top:-5px">$</asp:Label>
                                    </td>
                                    <td>
                                      <asp:TextBox runat="server" ID="txtValueRetirement" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Retirement Value Possessed" MaxLength="5" TabIndex="105" AutoPostBack="True" Text="0" ValidationGroup="Submit" />
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ErrorMessage="Enter a valid currency amount." ControlToValidate="txtValueRetirement" ValidationExpression="^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{2})?$" ValidationGroup="Submit" Display="Dynamic" CssClass="text-danger"></asp:RegularExpressionValidator>
                                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtValueRetirement" CssClass="text-danger" ErrorMessage="The retirement value possessed is required." Display="Static" ValidationGroup="Submit" />
                                    </td>
                                  </tr>
                                </table>                                
                              </div>
                            </div>
                            <div class="form-group">
                              <br />
                              <h5 style="line-height:2; font-size:12px"><b>Are you receiving any temporary assistance?</b></h5>
                              <asp:Label runat="server" AssociatedControlID="txtValueAssistance" CssClass="col-lg-2 control-label" ToolTip="Assistance Value Received" Style="white-space: nowrap">Assistance:</asp:Label>
                              <div class="col-lg-10">
                                <table style="width:100%">
                                  <tr>
                                    <td>
                                      <asp:Label runat="server" AssociatedControlID="txtValueAssistance" style="white-space: nowrap; position:relative; top:-5px">$</asp:Label>
                                    </td>
                                    <td>
                                      <asp:TextBox runat="server" ID="txtValueAssistance" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Assistance Value Received" MaxLength="5" TabIndex="112" AutoPostBack="True" Text="0" ValidationGroup="Submit" />
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ErrorMessage="Enter a valid currency amount." ControlToValidate="txtValueAssistance" ValidationExpression="^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{2})?$" ValidationGroup="Submit" Display="Dynamic" CssClass="text-danger"></asp:RegularExpressionValidator>
                                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtValueAssistance" CssClass="text-danger" ErrorMessage="The assistance value received is required." Display="Static" ValidationGroup="Submit" />
                                    </td>
                                  </tr>
                                </table>
                              </div>
                            </div>                            
                            <div class="form-group">
                              <div class="col-lg-2" style="white-space:nowrap">
                                <asp:RadioButtonList ID="chkInsurance" runat="server" RepeatDirection="Horizontal" style="position: relative; top: 6px;cursor: pointer" ToolTip="Do you have Insurance / Medicare / Medicaid?" TabIndex="114" AutoPostBack="True" ValidationGroup="Submit">
                                  <asp:ListItem Text="Yes" Value="Yes">&nbsp;Yes&nbsp;</asp:ListItem>
                                  <asp:ListItem Text="No" Value="No">&nbsp;No&nbsp;</asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="chkInsurance" CssClass="text-danger" Display="Static" ErrorMessage="Indicating whether you have Insurance/Medicare/Medicaid is required." ValidationGroup="Submit" />
                              </div>
                              <asp:Label runat="server" AssociatedControlID="chkInsurance" CssClass="col-lg-5 control-label" Style="white-space: nowrap; position: relative; top: 3px;">Do you have Insurance / Medicare / Medicaid?</asp:Label>
                            </div>
                          </div>
                        </div>
                      </td>
                      <td style="width:50%; vertical-align:top">
                        <div class="col-lg-12">
                          <div class="form-horizontal">
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtValueLifeInsurance" CssClass="col-lg-2 control-label" ToolTip="Life Insurance Value Possessed" Style="white-space: nowrap">Life Insurance:</asp:Label>
                              <div class="col-lg-10">
                                <table style="width:100%">
                                  <tr>
                                    <td>
                                      <asp:Label runat="server" AssociatedControlID="txtValueLifeInsurance" style="white-space: nowrap; position:relative; top:-5px">$</asp:Label>
                                    </td>
                                    <td>
                                      <asp:TextBox runat="server" ID="txtValueLifeInsurance" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Life Insurance Value Possessed" MaxLength="5" TabIndex="106" AutoPostBack="True" Text="0" ValidationGroup="Submit" />
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ErrorMessage="Enter a valid currency amount." ControlToValidate="txtValueLifeInsurance" ValidationExpression="^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{2})?$" ValidationGroup="Submit" Display="Dynamic" CssClass="text-danger"></asp:RegularExpressionValidator>
                                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtValueLifeInsurance" CssClass="text-danger" ErrorMessage="The life insurance value possessed is required." Display="Static" ValidationGroup="Submit" />
                                    </td>
                                  </tr>
                                </table>
                              </div>
                            </div>                            
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtValueDebt" CssClass="col-lg-2 control-label" ToolTip="Outstanding Debts" Style="white-space: nowrap">Debt Value:</asp:Label>
                              <div class="col-lg-10">
                                <table style="width:100%">
                                  <tr>
                                    <td>
                                      <asp:Label runat="server" AssociatedControlID="txtValueDebt" style="white-space: nowrap; position:relative; top:-5px">$</asp:Label>
                                    </td>
                                    <td>
                                      <asp:TextBox runat="server" ID="txtValueDebt" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Outstanding Debts" MaxLength="5" TabIndex="107" AutoPostBack="True" Text="0" ValidationGroup="Submit" />
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" ErrorMessage="Enter a valid currency amount." ControlToValidate="txtValueDebt" ValidationExpression="^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{2})?$" ValidationGroup="Submit" Display="Dynamic" CssClass="text-danger"></asp:RegularExpressionValidator>
                                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtValueDebt" CssClass="text-danger" ErrorMessage="The debt value possessed is required." Display="Static" ValidationGroup="Submit" />
                                    </td>
                                  </tr>
                                </table>
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtValueChildSupport" CssClass="col-lg-2 control-label" ToolTip="Child Support Value Received" Style="white-space: nowrap">Child Support:</asp:Label>
                              <div class="col-lg-10">
                                <table style="width:100%">
                                  <tr>
                                    <td>
                                      <asp:Label runat="server" AssociatedControlID="txtValueChildSupport" style="white-space: nowrap; position:relative; top:-5px">$</asp:Label>
                                    </td>
                                    <td>
                                      <asp:TextBox runat="server" ID="txtValueChildSupport" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Child Support Value Received" MaxLength="5" TabIndex="108" AutoPostBack="True" Text="0" ValidationGroup="Submit" />
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ErrorMessage="Enter a valid currency amount." ControlToValidate="txtValueChildSupport" ValidationExpression="^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{2})?$" ValidationGroup="Submit" Display="Dynamic" CssClass="text-danger"></asp:RegularExpressionValidator>
                                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtValueChildSupport" CssClass="text-danger" ErrorMessage="The child support value received is required." Display="Static" ValidationGroup="Submit" />
                                    </td>
                                  </tr>
                                </table>
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="drpChildSupportFrequency" AutoCompleteType="Disabled" CssClass="col-lg-2 control-label" ToolTip="Child Support Frequency" Style="white-space: nowrap; position: relative; top: 0px;">C.S. Frequency:</asp:Label>
                              <div class="col-lg-10">
                                <table style="width:100%">
                                  <tr>
                                    <td>
                                      <asp:Label runat="server" AssociatedControlID="drpChildSupportFrequency" style="white-space: nowrap; position:relative; top:-5px">&nbsp;</asp:Label>
                                    </td>
                                    <td>
                                      <asp:DropDownList ID="drpChildSupportFrequency" runat="server" ToolTip="Child Support Frequency" CssClass="form-control" TabIndex="109" AutoPostBack="True" ValidationGroup="Submit" Enabled="False">
                                        <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Daily" Value="Daily"></asp:ListItem>
                                        <asp:ListItem Text="Weekly" Value="Weekly"></asp:ListItem>
                                        <asp:ListItem Text="Bi-Monthly" Value="Bi-Monthly"></asp:ListItem>
                                        <asp:ListItem Text="Monthly" Value="Monthly"></asp:ListItem>
                                        <asp:ListItem Text="Yearly" Value="Yearly"></asp:ListItem>
                                      </asp:DropDownList>
                                      <asp:RequiredFieldValidator ID="valChildSupportFrequency" runat="server" ControlToValidate="drpChildSupportFrequency" CssClass="text-danger" ErrorMessage="The child support frequency is required." InitialValue="(Select One)" ValidationGroup="Submit" Enabled="False" />
                                    </td>
                                  </tr>
                                </table>
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtValueFoodStamps" CssClass="col-lg-2 control-label" ToolTip="Food Stamps Value Received" Style="white-space: nowrap">Food Stamps:</asp:Label>
                              <div class="col-lg-10">
                                <table style="width:100%">
                                  <tr>
                                    <td>
                                      <asp:Label runat="server" AssociatedControlID="txtValueChildSupport" style="white-space: nowrap; position:relative; top:-5px">$</asp:Label>
                                    </td>
                                    <td>
                                      <asp:TextBox runat="server" ID="txtValueFoodStamps" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Food Stamps Value Received" MaxLength="5" TabIndex="110" AutoPostBack="True" Text="0" ValidationGroup="Submit" />
                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ErrorMessage="Enter a valid currency amount." ControlToValidate="txtValueFoodStamps" ValidationExpression="^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{2})?$" ValidationGroup="Submit" Display="Dynamic" CssClass="text-danger"></asp:RegularExpressionValidator>
                                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtValueFoodStamps" CssClass="text-danger" ErrorMessage="The food stamps value received is required." Display="Static" ValidationGroup="Submit" />
                                    </td>
                                  </tr>
                                </table>
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="drpFoodStampFrequency" AutoCompleteType="Disabled" CssClass="col-lg-2 control-label" ToolTip="Food Stamp Frequency" Style="white-space: nowrap; position: relative; top: 0px;">F.S. Frequency:</asp:Label>
                              <div class="col-lg-10">
                                <table style="width:100%">
                                  <tr>
                                    <td>
                                      <asp:Label runat="server" AssociatedControlID="drpFoodStampFrequency" style="white-space: nowrap; position:relative; top:-5px">&nbsp;</asp:Label>
                                    </td>
                                    <td>
                                      <asp:DropDownList ID="drpFoodStampFrequency" runat="server" ToolTip="Food Stamp Frequency" CssClass="form-control" TabIndex="111" AutoPostBack="True" ValidationGroup="Submit" Enabled="False">
                                        <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Daily" Value="Daily"></asp:ListItem>
                                        <asp:ListItem Text="Weekly" Value="Weekly"></asp:ListItem>
                                        <asp:ListItem Text="Bi-Monthly" Value="Bi-Monthly"></asp:ListItem>
                                        <asp:ListItem Text="Monthly" Value="Monthly"></asp:ListItem>
                                        <asp:ListItem Text="Yearly" Value="Yearly"></asp:ListItem>
                                      </asp:DropDownList>
                                      <asp:RequiredFieldValidator  ID="valFoodStampFrequency" runat="server" ControlToValidate="drpFoodStampFrequency" CssClass="text-danger" ErrorMessage="The food stamp frequency is required." InitialValue="(Select One)" ValidationGroup="Submit" Enabled="False" />
                                    </td>
                                  </tr>
                                </table>

                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtWhoAssisted" CssClass="col-lg-2 control-label" ToolTip="Assistance Received From?" Style="white-space: nowrap">Who Assisted:</asp:Label>
                              <div class="col-lg-10">
                                <table style="width:100%">
                                  <tr>
                                    <td>
                                      <asp:Label runat="server" AssociatedControlID="txtWhoAssisted" style="white-space: nowrap; position:relative; top:-5px">&nbsp;&nbsp;</asp:Label>
                                    </td>
                                    <td>
                                      <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtWhoAssisted" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Assistance Value Received" TabIndex="113" AutoPostBack="True" Enabled="false" ValidationGroup="Submit" />
                                      <asp:RequiredFieldValidator ID="valWhoAssisted" runat="server" ControlToValidate="txtWhoAssisted" CssClass="text-danger" Enabled="false" ErrorMessage="The person who assisted is required." Display="Static" ValidationGroup="Submit" />
                                    </td>
                                  </tr>
                                </table>                                
                              </div>
                            </div>
                          </div>
                        </div>
                      </td>
                    </tr>
                  </table>
                  <asp:Panel ID="pnlInsurance" runat="server" Visible="false">
                    <table border="0" style="width:100%">
                      <tr>
                        <td style="width:50%; vertical-align: middle">
                          <div class="col-lg-12">
                            <div class="form-horizontal">
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtInsuranceProvider" CssClass="col-lg-2 control-label" ToolTip="Insurance Provider" Style="white-space: nowrap; position: relative; top: 5px">Provider:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;" ID="txtInsuranceProvider" AutoCompleteType="Disabled" runat="server"  CssClass="form-control" ToolTip="Insurance Provider" AutoPostBack="True" TabIndex="115" ValidationGroup="Submit"></asp:TextBox>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtInsuranceProvider" CssClass="text-danger" ErrorMessage="The insurance provider is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtMedicare" CssClass="col-lg-2 control-label" ToolTip="Medicare #" Style="white-space: nowrap; position: relative; top: 5px">Medicare #:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox runat="server" ID="txtMedicare" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Medicare #" TabIndex="116" AutoPostBack="True" ValidationGroup="Submit" MaxLength="11" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMedicare" CssClass="text-danger" ErrorMessage="The Medicare # is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                            </div>
                          </div>                              
                        </td>
                        <td style="width:50%">
                          <div class="col-lg-12">
                            <div class="form-horizontal">
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtPolicyNumber" CssClass="col-lg-2 control-label" style="white-space: nowrap; position: relative; top: 5px">Policy #:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox runat="server" ID="txtPolicyNumber" AutoCompleteType="Disabled" MaxLength="25" CssClass="form-control" ToolTip="Polciy Number" TabIndex="117" AutoPostBack="True" ValidationGroup="Submit" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPolicyNumber" CssClass="text-danger" ErrorMessage="The policy number is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtMedicaid" CssClass="col-lg-2 control-label" ToolTip="Medicaid #" Style="white-space: nowrap; position: relative; top: 5px">Medicaid #:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox runat="server" ID="txtMedicaid" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Medicaid #" TabIndex="118" AutoPostBack="True" ValidationGroup="Submit" MaxLength="9" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMedicaid" CssClass="text-danger" ErrorMessage="The Medicaid # is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                            </div>
                          </div>
                        </td>
                      </tr>
                    </table>
                  </asp:Panel>
                </td>
              </tr>
            </table>
          </Content>
        </ajaxToolkit:AccordionPane>
        <ajaxToolkit:AccordionPane runat="server" ID="paneEmployment" TabIndex="200">
          <Header>
            <table style="width:100%">
              <tr>
                <th style="width:25%; text-align:left; vertical-align: middle">
                  Employment (or Previous Employment)
                </th>
                <th style="width:50%; text-align:center; vertical-align: middle">
                  <div class="progress" style="position: relative; top: 10px;">
                    <div id="prgEmployment" runat="server" class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="11" aria-valuemin="0" aria-valuemax="100" style="width:11%; color: black">
                      <asp:Literal ID="ltlPercentEmployment" runat="server" Text="11% Complete"></asp:Literal>
                    </div>
                  </div>
                </th>
                <th style="width:25%; text-align:right; vertical-align: middle">
                  <span class="glyphicon glyphicon-triangle-bottom"></span>
                </th>
              </tr>
            </table>
          </Header>
          <Content>
            <table border="1" style="width:100%">
              <tr>
                <td style="width:100%; padding: 5px">
                  <br />
                  <div class="col-lg-12">
                    <div class="form-horizontal">
                      <div class="form-group">
                        <asp:Label runat="server" CssClass="col-lg-1 control-label">&nbsp;</asp:Label>
                        <div class="col-lg-10">
                          <label>
                            <asp:CheckBox ID="chkNotEmployed" TabIndex="30" runat="server" AutoPostBack="True" /><b>&nbsp;I am not nor have been previously employed</b>
                          </label>
                          <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="CustomValidator" Text="temp"></asp:CustomValidator>
                        </div>
                      </div>
                    </div>
                  </div>
                  <br />
                  <asp:Panel ID="pnlEmployed" runat="server" Visible="true">
                    <table border="0" style="width:100%">
                      <tr>
                        <td style="width:50%; vertical-align:top">
                          <div class="col-lg-12">
                            <div class="form-horizontal">
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtEmployerName" CssClass="col-lg-2 control-label" ToolTip="Employer Name" Style="white-space: nowrap">Employer:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtEmployerName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Employer Name" MaxLength="100" TabIndex="201" ValidationGroup="Submit" AutoPostBack="True" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmployerName" CssClass="text-danger" Display="Static" ErrorMessage="The employer name is required." ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtEmploymentStart" CssClass="col-lg-2 control-label" ToolTip="Employment Start Date" Style="white-space: nowrap">Start Date:</asp:Label>
                                <div class="col-lg-10">
                                  <table border="0" style="width: 280px">
                                    <tr>
                                      <td style="width: 90%">
                                        <asp:TextBox runat="server" ID="txtEmploymentStart" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Employment Start Date" BackColor="White" placeholder="mm/dd/yyyy" TabIndex="202" AutoPostBack="True" ValidationGroup="Submit" />
                                      </td>
                                      <td style="width: 10%; text-align: center;">
                                        <a href="#" runat="server" id="lnkEmploymentStartDate">
                                          <span class="glyphicon glyphicon-calendar" style="font-size: 20px; color: darkgreen" tabindex="202"></span>
                                        </a>
                                      </td>
                                    </tr>
                                  </table>
                                  <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter a valid date." CssClass="text-danger" Display="Dynamic" ValidationExpression="^(0?[1-9]|1[0-2])/(0?[1-9]|1[0-9]|2[0-9]|3[01])/\d{4}$" ControlToValidate="txtEmploymentStart" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmploymentStart" CssClass="text-danger" ErrorMessage="The employment start date is required." Display="Static" ValidationGroup="Submit" />
                                  <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtEmploymentStart" PopupButtonID="lnkEmploymentStartDate" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtEmploymentEnd" CssClass="col-lg-2 control-label" ToolTip="Employment End Date" Style="white-space: nowrap">End Date:</asp:Label>
                                <div class="col-lg-10">
                                  <table border="0" style="width: 280px">
                                    <tr>
                                      <td style="width: 90%">
                                        <asp:TextBox runat="server" ID="txtEmploymentEnd" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Employment End Date" BackColor="White" placeholder="mm/dd/yyyy" TabIndex="203" AutoPostBack="True" ValidationGroup="Submit" />
                                      </td>
                                      <td style="width: 10%; text-align: center;">
                                        <a href="#" runat="server" id="lnkEmploymentEndDate">
                                          <span class="glyphicon glyphicon-calendar" style="font-size: 20px; color: darkgreen" tabindex="203"></span>
                                        </a>
                                      </td>
                                    </tr>
                                  </table>
                                  <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter a valid date." CssClass="text-danger" Display="Dynamic" ValidationExpression="^(0?[1-9]|1[0-2])/(0?[1-9]|1[0-9]|2[0-9]|3[01])/\d{4}$" ControlToValidate="txtEmploymentEnd" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmploymentEnd" CssClass="text-danger" ErrorMessage="The employment end date is required." Display="Static" ValidationGroup="Submit" Enabled="False" />
                                  <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtEmploymentEnd" PopupButtonID="lnkEmploymentEndDate" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtPosition" CssClass="col-lg-2 control-label" ToolTip="Phone #" Style="white-space: nowrap">Position:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtPosition" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Position" MaxLength="100" TabIndex="204" AutoPostBack="True" ValidationGroup="Submit" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPosition" CssClass="text-danger" ErrorMessage="The position title is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtEmployerPhone" AutoCompleteType="Disabled" CssClass="col-lg-2 control-label" ToolTip="Phone #" Style="white-space: nowrap">Phone #:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox runat="server" ID="txtEmployerPhone" CssClass="form-control" ToolTip="Phone #" MaxLength="12" placeholder="555-555-1234" TabIndex="205" AutoPostBack="True"  ValidationGroup="Submit" />
                                  <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmployerPhone" CssClass="text-danger" ValidationExpression="^(1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$" ErrorMessage="Please enter a valid phone number." Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmployerPhone" CssClass="text-danger" ErrorMessage="The employer phone number is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                            </div>
                          </div>
                        </td>
                        <td style="width:50%; vertical-align:top">
                          <div class="col-lg-12">
                            <div class="form-horizontal">
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtMonthlySalary" CssClass="col-lg-2 control-label" ToolTip="Monthly Salary" Style="white-space: nowrap">Monthly Salary:</asp:Label>
                                <div class="col-lg-10">
                                  <table>
                                    <tr>
                                      <td>
                                        <asp:Label runat="server" AssociatedControlID="txtMonthlySalary" style="white-space: nowrap; position:relative; top:-5px">$</asp:Label>
                                      </td>
                                      <td>
                                        <asp:TextBox runat="server" MaxLength="7" ID="txtMonthlySalary" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Monthly Salary" TabIndex="206" ValidationGroup="Submit" Text="0" AutoPostBack="True" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server" ErrorMessage="Enter a valid currency amount." ControlToValidate="txtMonthlySalary" ValidationExpression="^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{2})?$" ValidationGroup="Submit" Display="Dynamic" CssClass="text-danger"></asp:RegularExpressionValidator>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMonthlySalary" CssClass="text-danger" Display="Static" ErrorMessage="The monthly salary is required." ValidationGroup="Submit" />
                                      </td>
                                    </tr>
                                  </table>
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtEmployerStreet" CssClass="col-lg-2 control-label" ToolTip="Address Street" Style="white-space: nowrap">Street:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtEmployerStreet" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address Street" MaxLength="100" TabIndex="207" AutoPostBack="True" ValidationGroup="Submit" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmployerStreet" CssClass="text-danger" ErrorMessage="The address street is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtEmployerCity" CssClass="col-lg-2 control-label" ToolTip="Address City" Style="white-space: nowrap">City:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtEmployerCity" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address City" MaxLength="50" TabIndex="208" AutoPostBack="True" ValidationGroup="Submit" />
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmployerCity" CssClass="text-danger" ErrorMessage="The address city is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="drpEmployerState" CssClass="col-lg-2 control-label" ToolTip="Address State" Style="white-space: nowrap; position: relative; top: 0px;">State:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:DropDownList ID="drpEmployerState" runat="server" ToolTip="Address State" CssClass="form-control" TabIndex="209" AutoPostBack="True" ValidationGroup="Submit"></asp:DropDownList>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="drpEmployerState" CssClass="text-danger" ErrorMessage="The address state is required." InitialValue="(Select One)" ValidationGroup="Submit" />
                                </div>
                              </div>
                              <div class="form-group">
                                <asp:Label runat="server" AssociatedControlID="txtEmployerZip" CssClass="col-lg-2 control-label" ToolTip="Address Zip" Style="white-space: nowrap">Zip Code:</asp:Label>
                                <div class="col-lg-10">
                                  <asp:TextBox runat="server" ID="txtEmployerZip" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address Zip" MaxLength="5" TabIndex="210" AutoPostBack="True" ValidationGroup="Submit" />
                                  <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmployerZip" CssClass="text-danger" ValidationExpression="^\d{5}$" ErrorMessage="Please enter a valid zip code" Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmployerZip" CssClass="text-danger" ErrorMessage="The address zip code is required." Display="Static" ValidationGroup="Submit" />
                                </div>
                              </div>
                            </div>
                          </div>
                        </td>
                      </tr>
                    </table>
                  </asp:Panel>
                </td>
              </tr>
            </table>            
          </Content>
        </ajaxToolkit:AccordionPane>
        <ajaxToolkit:AccordionPane runat="server" ID="paneDependent" TabIndex="300">
          <Header>
            <table style="width:100%">
              <tr>
                <th style="width:25%; text-align:left; vertical-align: middle">
                  Dependent Information (Assistance Needed)
                </th>
                <th style="width:50%; text-align:center; vertical-align: middle">
                  <div class="progress" style="position: relative; top: 10px;">
                    <div id="Div3" runat="server" class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width:100%; color: black">
                      <asp:Literal ID="ltlPercentDependent" runat="server" Text="100% Complete"></asp:Literal>
                    </div>
                  </div>
                </th>
                <th style="width:25%; text-align:right; vertical-align: middle">
                  <span class="glyphicon glyphicon-triangle-bottom"></span>
                </th>
              </tr>
            </table>
          </Header>
          <Content>
            <table border="1" style="width:100%">
              <tr>
                <td style="width:100%; padding: 5px">
                  <br />
                  <table border="0" style="width:100%">
                    <tr>
                      <td style="width:50%; vertical-align:top">
                        <div class="col-lg-12">
                          <div class="form-horizontal">
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtDepFirstName" CssClass="col-lg-2 control-label" ToolTip="First Name" Style="white-space: nowrap">First Name:</asp:Label>
                              <div class="col-lg-10">
                                <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtDepFirstName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="First Name" MaxLength="30" TabIndex="2" AutoPostBack="false" ValidationGroup="Dependent" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDepFirstName" CssClass="text-danger" ErrorMessage="The first name is required." Display="Static" ValidationGroup="Dependent" Enabled="True" />
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtDepMiddleName" CssClass="col-lg-2 control-label" ToolTip="Middle Name" Style="white-space: nowrap">Middle Name:</asp:Label>
                              <div class="col-lg-10">
                                <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtDepMiddleName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Middle Name" MaxLength="30" TabIndex="3" AutoPostBack="false" ValidationGroup="Dependent" />
                                <asp:CustomValidator ID="CustomValidator7" runat="server" CssClass="text-danger" ControlToValidate="txtDepMiddleName" ErrorMessage="middle" Display="Static" ValidationGroup="Dependent" Enabled="True" />
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtDepLastName" CssClass="col-lg-2 control-label" ToolTip="Last Name" Style="white-space: nowrap">Last Name:</asp:Label>
                              <div class="col-lg-10">
                                <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtDepLastName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Last Name" MaxLength="30" TabIndex="4" AutoPostBack="false" ValidationGroup="Dependent" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDepLastName" CssClass="text-danger" Display="Static" ErrorMessage="The last name is required." ValidationGroup="Dependent" Enabled="True" />
                              </div>
                            </div>
                            <div class="form-group">
                              <div class="col-lg-12">
                                <b>Your Current List of Dependents Are Shown Below:</b>
                              </div>
                            </div>
                          </div>
                        </div>
                      </td>
                      <td style="width:50%; vertical-align:top">
                        <div class="col-lg-12">
                          <div class="form-horizontal">
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtDepDOB" CssClass="col-lg-2 control-label" ToolTip="Date of Birth" Style="white-space: nowrap">Date of Birth:</asp:Label>
                              <div class="col-lg-10">
                                <table border="0" style="width: 280px">
                                  <tr>
                                    <td style="width: 90%">
                                      <asp:TextBox runat="server" ID="txtDepDOB" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Date of Birth" BackColor="White" placeholder="mm/dd/yyyy" TabIndex="5" AutoPostBack="false" ValidationGroup="Dependent" />
                                    </td>
                                    <td style="width: 10%; text-align: center;">
                                      <a href="#" runat="server" id="lnkDepCalendarDOB">
                                        <span class="glyphicon glyphicon-calendar" style="font-size: 20px; color: darkgreen" tabindex="6"></span>
                                      </a>
                                    </td>
                                  </tr>
                                </table>
                                <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter a valid date." CssClass="text-danger" Display="Dynamic" ValidationExpression="^(0?[1-9]|1[0-2])/(0?[1-9]|1[0-9]|2[0-9]|3[01])/\d{4}$" ControlToValidate="txtDepDOB" ValidationGroup="Dependent" Enabled="True"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDepDOB" CssClass="text-danger" ErrorMessage="The date of birth is required." Display="Static" ValidationGroup="Dependent" Enabled="True" />
                                <ajaxToolkit:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtDepDOB" PopupButtonID="lnkDepCalendarDOB" />
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="chkDepGender" CssClass="col-lg-2 control-label" ToolTip="Gender" Style="white-space: nowrap; position: relative; top: 0px;">Gender:</asp:Label>
                              <div class="col-lg-10">
                                <asp:RadioButtonList ID="chkDepGender" runat="server" RepeatDirection="Horizontal" Style="position: relative; top: 6px;" ToolTip="Gender" TabIndex="7" AutoPostBack="false" ValidationGroup="Dependent">
                                  <asp:ListItem Text="Male" Value="Male">&nbsp;&nbsp;Male&nbsp;&nbsp;</asp:ListItem>
                                  <asp:ListItem Text="Female" Value="Female">&nbsp;&nbsp;Female</asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="chkDepGender" CssClass="text-danger" Display="Static" ErrorMessage="The gender is required." ValidationGroup="Dependent" Enabled="True" />
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="drpDepRelation" CssClass="col-lg-2 control-label" ToolTip="Relation" Style="white-space: nowrap; position: relative; top: 0px;">Relation:</asp:Label>
                              <div class="col-lg-10">
                                <asp:DropDownList ID="drpDepRelation" runat="server" ToolTip="Relation" CssClass="form-control" TabIndex="8" AutoPostBack="false" ValidationGroup="Dependent">
                                  <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                                  <asp:ListItem Text="Father" Value="Father"></asp:ListItem>
                                  <asp:ListItem Text="Mother" Value="Mother"></asp:ListItem>
                                  <asp:ListItem Text="Son" Value="Son"></asp:ListItem>
                                  <asp:ListItem Text="Daughter" Value="Daughter"></asp:ListItem>
                                  <asp:ListItem Text="Husband" Value="Husband"></asp:ListItem>
                                  <asp:ListItem Text="Wife" Value="Wife"></asp:ListItem>
                                  <asp:ListItem Text="Brother" Value="Brother"></asp:ListItem>
                                  <asp:ListItem Text="Sister" Value="Sister"></asp:ListItem>
                                  <asp:ListItem Text="Grandfather" Value="Grandfather"></asp:ListItem>
                                  <asp:ListItem Text="Grandmother" Value="Grandmother"></asp:ListItem>
                                  <asp:ListItem Text="Great Grandfather" Value="Great Grandfather"></asp:ListItem>
                                  <asp:ListItem Text="Great Grandmother" Value="Great Grandmother"></asp:ListItem>
                                  <asp:ListItem Text="Grandson" Value="Grandson"></asp:ListItem>
                                  <asp:ListItem Text="Granddaughter" Value="Granddaughter"></asp:ListItem>
                                  <asp:ListItem Text="Grandson" Value="Grandson"></asp:ListItem>
                                  <asp:ListItem Text="Uncle" Value="Uncle"></asp:ListItem>
                                  <asp:ListItem Text="Aunt" Value="Aunt"></asp:ListItem>
                                  <asp:ListItem Text="Nephew" Value="Nephew"></asp:ListItem>
                                  <asp:ListItem Text="Niece" Value="Niece"></asp:ListItem>
                                  <asp:ListItem Text="Cousin" Value="Cousin"></asp:ListItem>
                                  <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="drpDepRelation" CssClass="text-danger" ErrorMessage="The relatoinship is required." InitialValue="(Select One)" ValidationGroup="Dependent" Enabled="True" />
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" CssClass="col-lg-2 control-label">&nbsp;</asp:Label>
                              <div class="col-lg-10">
                                <asp:Button ID="btnAddDependent" runat="server" Text="Add Dependent" CssClass="btn btn-default" TabIndex="600" Width="150" ValidationGroup="Dependent" /><br />
                                <asp:CustomValidator ID="valUserRequiredDep" runat="server" CssClass="text-danger" ControlToValidate="txtDepMiddleName" ErrorMessage="You must enter your email and name before adding dependents" Display="Static" ValidationGroup="Dependent" Enabled="True" />
                              </div>
                            </div>
                          </div>
                        </div>
                      </td>
                    </tr>
                  </table>
                  <br />
                  <table class="table table-hover" border="0" style="font-size:12px">
                    <asp:Repeater ID="rptDependents" runat="server">
                      <HeaderTemplate>
                        <tr style="height: 30px; border: solid solid solid solid">
                          <th style="text-align: left; width: 25%">Name</th>
                          <th style="text-align: left; width: 20%">Date of Birth</th>
                          <th style="text-align: center; width: 15%;">Age</th>
                          <th style="text-align: center; width: 15%;">Gender</th>
                          <th style="text-align: left; width: 15%">Relationship</th>
                          <th style="text-align: center; width: 10%;">Remove</th>
                        </tr>
                      </HeaderTemplate>
                      <ItemTemplate>
                        <tr>
                          <td style="text-align: left; vertical-align: middle">
                            <%# DataBinder.Eval(Container.DataItem, "firstName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "middleName")%>&nbsp;<%# DataBinder.Eval(Container.DataItem, "lastName")%>
                          </td>
                          <td style="text-align: left; vertical-align: middle">
                            <%# FormatDateTime(DataBinder.Eval(Container.DataItem, "dob"), DateFormat.LongDate)%>
                          </td>
                          <td style="text-align: center; vertical-align: middle">
                            <%# GetAge(DataBinder.Eval(Container.DataItem, "dob"))%>
                          </td>
                          <td style="text-align: center; vertical-align: middle">
                            <%# IIf(DataBinder.Eval(Container.DataItem, "gender") = "Male", "Male", "Female")%>
                          </td>
                          <td style="text-align: left; vertical-align: middle">
                            <%# DataBinder.Eval(Container.DataItem, "relationship")%>
                          </td>
                          <td style="text-align: center; vertical-align: middle">
                            <asp:LinkButton ID="btnDeleteDependent" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "dependentId")%>' runat="server" CausesValidation="false" OnClick="btnDeleteDependent_Click" ToolTip="Remove Dependent"><span class="glyphicon glyphicon-remove" style="font-size:20px; color:red"></span></asp:LinkButton>
                          </td>
                        </tr>
                      </ItemTemplate>
                    </asp:Repeater>
                  </table>
                  <br />
                </td>
              </tr>
            </table>
          </Content>
        </ajaxToolkit:AccordionPane>
        <ajaxToolkit:AccordionPane runat="server" ID="paneReference" TabIndex="400">
          <Header>
            <table style="width:100%">
              <tr>
                <th style="width:25%; text-align:left; vertical-align: middle">
                  Reference Information
                  <span class="label label-default"><asp:Label ID="lblReferences" runat="server" Text="0"></asp:Label></span>
                  &nbsp;(2 Required)
                </th>
                <th style="width:50%; text-align:center; vertical-align: middle">
                  <div class="progress" style="position: relative; top: 10px;">
                    <div id="prgReference" runat="server" class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%; color: black">
                      <asp:Literal ID="ltlPercentReference" runat="server" Text="0% Complete"></asp:Literal>
                    </div>
                  </div>
                </th>
                <th style="width:25%; text-align:right; vertical-align: middle">
                  <span class="glyphicon glyphicon-triangle-bottom"></span>
                </th>
              </tr>
            </table>
          </Header>
          <Content>
            <table border="1" style="width:100%">
              <tr>
                <td style="width:100%">
                  <br />
                  <table border="0" style="width:100%">
                    <tr>
                      <td style="width:50%">
                        <div class="col-lg-12">
                          <div class="form-horizontal">
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtRefFirstName" CssClass="col-lg-2 control-label" ToolTip="First Name" Style="white-space: nowrap">First Name:</asp:Label>
                              <div class="col-lg-10">
                                <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtRefFirstName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="First Name" MaxLength="30" TabIndex="401" AutoPostBack="false" ValidationGroup="Reference" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtRefFirstName" CssClass="text-danger" ErrorMessage="The first name is required." Display="Static" ValidationGroup="Reference" />
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtRefMiddleName" CssClass="col-lg-2 control-label" ToolTip="Middle Name" Style="white-space: nowrap">Middle Name:</asp:Label>
                              <div class="col-lg-10">
                                <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtRefMiddleName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Middle Name" MaxLength="30" TabIndex="402" AutoPostBack="false" ValidationGroup="Reference" />
                                <asp:CustomValidator ID="CustomValidator1" runat="server" CssClass="text-danger" ControlToValidate="txtRefMiddleName" ErrorMessage="middle" Display="Static" ValidationGroup="Reference" />
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtRefLastName" CssClass="col-lg-2 control-label" ToolTip="Last Name" Style="white-space: nowrap">Last Name:</asp:Label>
                              <div class="col-lg-10">
                                <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtRefLastName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Last Name" MaxLength="30" TabIndex="403" AutoPostBack="false" ValidationGroup="Reference" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtRefLastName" CssClass="text-danger" Display="Static" ErrorMessage="The last name is required." ValidationGroup="Reference" />
                              </div>
                            </div>                            
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="drpRefRelation" CssClass="col-lg-2 control-label" ToolTip="Relation" Style="white-space: nowrap; position: relative; top: 0px;">Relationship:</asp:Label>
                              <div class="col-lg-10">
                                <asp:DropDownList ID="drpRefRelation" runat="server" ToolTip="Relation" CssClass="form-control" TabIndex="404" AutoPostBack="false" ValidationGroup="Reference">
                                  <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                                  <asp:ListItem Text="Family" Value="Family"></asp:ListItem>
                                  <asp:ListItem Text="Friend" Value="Friend"></asp:ListItem>
                                  <asp:ListItem Text="Coworker" Value="Coworker"></asp:ListItem>
                                  <asp:ListItem Text="Fellow Student" Value="Fellow Student"></asp:ListItem>
                                  <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="drpRefRelation" CssClass="text-danger" ErrorMessage="The relationship is required." InitialValue="(Select One)" ValidationGroup="Reference" />
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtRefPhone" CssClass="col-lg-2 control-label" ToolTip="Phone #" Style="white-space: nowrap">Phone #:</asp:Label>
                              <div class="col-lg-10">
                                <asp:TextBox runat="server" ID="txtRefPhone" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Phone #" MaxLength="12" placeholder="555-555-1234" TabIndex="405" AutoPostBack="false" ValidationGroup="Reference" />
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtRefPhone" CssClass="text-danger" ValidationExpression="^(1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$" ErrorMessage="Please enter a valid phone number" Display="Dynamic" ValidationGroup="Reference"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtRefPhone" CssClass="text-danger" ErrorMessage="The phone number is required." Display="Static" ValidationGroup="Reference" />
                              </div>
                            </div>                            
                            <div class="form-group">
                              <div class="col-lg-12">
                                <b>Your Current List of References Are Shown Below:</b>
                              </div>
                            </div>
                          </div>
                        </div>
                      </td>
                      <td style="width:50%">
                        <div class="col-lg-12">
                          <div class="form-horizontal">
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtKnownSince" CssClass="col-lg-2 control-label" ToolTip="Known Since" Style="white-space: nowrap">Known Since:</asp:Label>
                              <div class="col-lg-10">
                                <table border="0" style="width: 280px">
                                  <tr>
                                    <td style="width: 90%">
                                      <asp:TextBox runat="server" ID="txtKnownSince" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Known Since?" BackColor="White" placeholder="mm/dd/yyyy" TabIndex="406" AutoPostBack="false" ValidationGroup="Reference" />
                                    </td>
                                    <td style="width: 10%; text-align: center;">
                                      <a href="#" runat="server" id="lnkCalendarKnownSince">
                                        <span class="glyphicon glyphicon-calendar" style="font-size: 20px; color: darkgreen" tabindex="406"></span>
                                      </a>
                                    </td>
                                  </tr>
                                </table>
                                <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter a valid date." CssClass="text-danger" Display="Dynamic" ValidationExpression="^(0?[1-9]|1[0-2])/(0?[1-9]|1[0-9]|2[0-9]|3[01])/\d{4}$" ControlToValidate="txtKnownSince" ValidationGroup="Reference"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtKnownSince" CssClass="text-danger" ErrorMessage="The known since date is required." Display="Static" ValidationGroup="Reference" />
                                <ajaxToolkit:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="txtKnownSince" PopupButtonID="lnkCalendarKnownSince" />
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtRefStreet" CssClass="col-lg-2 control-label" ToolTip="Address Street" Style="white-space: nowrap">Street:</asp:Label>
                              <div class="col-lg-10">
                                <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtRefStreet" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address Street" MaxLength="100" TabIndex="407" AutoPostBack="false" ValidationGroup="Reference" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtRefStreet" CssClass="text-danger" ErrorMessage="The address street is required." Display="Static" ValidationGroup="Reference" />
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtRefCity" CssClass="col-lg-2 control-label" ToolTip="Address City" Style="white-space: nowrap">City:</asp:Label>
                              <div class="col-lg-10">
                                <asp:TextBox style="text-transform: capitalize;" runat="server" ID="txtRefCity" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address City" MaxLength="50" TabIndex="408" AutoPostBack="false" ValidationGroup="Reference" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtRefCity" CssClass="text-danger" ErrorMessage="The address city is required." Display="Static" ValidationGroup="Reference" />
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="drpRefState" CssClass="col-lg-2 control-label" ToolTip="Address State" Style="white-space: nowrap; position: relative; top: 0px;">State:</asp:Label>
                              <div class="col-lg-10">
                                <asp:DropDownList ID="drpRefState" runat="server" ToolTip="Address State" CssClass="form-control" TabIndex="409" AutoPostBack="false" ValidationGroup="Reference"></asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="drpRefState" CssClass="text-danger" ErrorMessage="The address state is required." InitialValue="(Select One)" ValidationGroup="Reference" />
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="txtRefZip" CssClass="col-lg-2 control-label" ToolTip="Address Zip" Style="white-space: nowrap">Zip Code:</asp:Label>
                              <div class="col-lg-10">
                                <asp:TextBox runat="server" ID="txtRefZip" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address Zip" MaxLength="5" TabIndex="410" AutoPostBack="false" ValidationGroup="Reference" />
                                <asp:RegularExpressionValidator runat="server" ControlToValidate="txtRefZip" CssClass="text-danger" ValidationExpression="^\d{5}$" ErrorMessage="Please enter a valid zip code" Display="Dynamic" ValidationGroup="Reference"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtRefZip" CssClass="text-danger" ErrorMessage="The address zip code is required." Display="Static" ValidationGroup="Reference" />
                              </div>
                            </div>
                            <div class="form-group">
                              <asp:Label runat="server" CssClass="col-lg-2 control-label">&nbsp;</asp:Label>
                              <div class="col-lg-10">
                                <asp:Button ID="btnAddReference" runat="server" Text="Add Reference" CssClass="btn btn-default" TabIndex="413" Width="150" ValidationGroup="Reference" /><br />
                                <asp:CustomValidator ID="valUserRequiredRef" runat="server" CssClass="text-danger" ControlToValidate="txtRefMiddleName" ErrorMessage="You must enter your email and name before adding references" Display="Static" ValidationGroup="Reference" Enabled="True" />
                              </div>
                            </div>
                          </div>
                        </div>
                      </td>
                    </tr>
                  </table>
                  <br />
                  <table class="table table-hover" border="0" style="font-size:12px">
                    <asp:Repeater ID="rptReferences" runat="server">
                      <HeaderTemplate>
                        <tr style="height: 30px; border: solid solid solid solid">
                          <th style="text-align: left; width: 20%">Name</th>
                          <th style="text-align: left; width: 15%">Relationship</th>
                          <th style="text-align: left; width: 15%;">Known Since</th>
                          <th style="text-align: left; width: 15%">Phone</th>
                          <th style="text-align: left; width: 25%;">Address</th>
                          <th style="text-align: center; width: 10%;">Remove</th>
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
                            <%# DataBinder.Eval(Container.DataItem, "city")%>,&nbsp;<%# DataBinder.Eval(Container.DataItem, "stateAbbr")%>
                          </td>
                          <td style="text-align: center; vertical-align: middle">
                            <asp:LinkButton ID="btnDeleteReference" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "referenceId")%>' runat="server" CausesValidation="false" OnClick="btnDeleteReference_Click" ToolTip="Remove Reference"><span class="glyphicon glyphicon-remove" style="font-size:20px; color:red"></span></asp:LinkButton>
                          </td>
                        </tr>
                      </ItemTemplate>
                    </asp:Repeater>
                  </table>
                </td>
              </tr>
            </table>
          </Content>
        </ajaxToolkit:AccordionPane>
        <ajaxToolkit:AccordionPane runat="server" ID="paneArtifacts" TabIndex="500">
          <Header>
            <table style="width:100%">
              <tr>
                <th style="width:25%; text-align:left; vertical-align: middle">
                  Artifacts
                  <span class="label label-default"><asp:Label ID="lblArtifacts" runat="server" Text="0"></asp:Label></span>
                  &nbsp;(Government ID Req'd)
                </th>
                <th style="width:50%; text-align:center; vertical-align: middle">
                  <div class="progress" style="position: relative; top: 10px;">
                    <div id="prgArtifact" runat="server" class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%; color: black">
                      <asp:Literal ID="ltlPercentArtifact" runat="server" Text="0% Complete"></asp:Literal>
                    </div>
                  </div>
                </th>
                <th style="width:25%; text-align:right; vertical-align: middle">
                  <span class="glyphicon glyphicon-triangle-bottom"></span>
                </th>
              </tr>
            </table>
          </Header>
          <Content>
            <table border="1" style="width:100%">
              <tr>
                <td style="width:100%">
                  <table border="0" style="width:100%">
                    <tr>
                      <td style="width:50%">
                        <div class="col-lg-12">
                          <div class="form-horizontal">
                            <br /><br />
                            <div class="form-group">
                              <asp:Label runat="server" AssociatedControlID="drpArtifactType" CssClass="col-lg-2 control-label" ToolTip="Artifact Type" Style="white-space: nowrap; position: relative; top: 0px;">Artifact Type:</asp:Label>
                              <div class="col-lg-10">
                                <asp:DropDownList ID="drpArtifactType" runat="server" ToolTip="Relation" CssClass="form-control" TabIndex="501" AutoPostBack="True" ValidationGroup="Artifact">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="drpArtifactType" CssClass="text-danger" ErrorMessage="The artifact type is required." InitialValue="(Select One)" ValidationGroup="Artifact" />
                              </div>
                            </div>                          
                            <div class="form-group">
                              <div class="col-lg-12">
                                <b>Your Current List of Artifacts For This Application Are Shown Below:</b>
                              </div>
                            </div>
                          </div>
                        </div>
                      </td>
                      <td style="width:50%">
                        <div class="col-lg-12">
                          <div class="form-horizontal">
                            <div class="form-group">
                              <table style="width: 100%" border="0">
                                <tr>
                                  <td style="width: 60%; vertical-align:top">
                                    <asp:FileUpload ID="fileUploadArtifact" runat="server" CssClass="col-lg-2 form-control" style="max-width:100%" Width="100%" TabIndex="502" Enabled="False" /><br />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="fileUploadArtifact" CssClass="text-danger" ErrorMessage="Select a file before uploading." ValidationGroup="Artifact" Display="Dynamic" />
                                    <asp:CustomValidator ID="valUserRequiredArtifact" runat="server" CssClass="text-danger"  ErrorMessage="You must enter your email and name before uploading." Display="Static" ValidationGroup="Reference" Enabled="True" />
                                  </td>
                                  <td style="width: 40%; vertical-align:top">
                                    <div class="col-lg-10">
                                      <asp:Button ID="btnUploadArtifact" runat="server" Text="Upload Artifact" CssClass="btn btn-default" TabIndex="503" Width="150" ValidationGroup="Artifact" />
                                    </div>
                                  </td>
                                </tr>
                              </table>
                            </div>
                          </div>
                        </div>
                      </td>
                    </tr>
                  </table>
                  <br />
                  <table class="table table-hover" border="0" style="font-size:12px">
                    <asp:Repeater ID="rptArtifacts" runat="server">
                      <HeaderTemplate>
                        <tr style="height: 30px; border: solid solid solid solid">
                          <th style="text-align: left; width: 20%">Artifact #</th>
                          <th style="text-align: left; width: 40%">Artifact Type</th>
                          <%--<th style="text-align: left; width: 20%;">Filename</th>--%>
                          <th style="text-align: left; width: 30%">Content Type</th>
                          <th style="text-align: center; width: 10%;">Remove</th>
                        </tr>
                      </HeaderTemplate>
                      <ItemTemplate>
                        <tr>
                          <td style="text-align: left; vertical-align: middle">
                            <%# getFormattedNumber(DataBinder.Eval(Container.DataItem, "artifactId"))%>
                          </td>
                          <td style="text-align: left; vertical-align: middle">
                            <%--<%# DataBinder.Eval(Container.DataItem, "ARTIFACT_TYPE.name")%>--%>
                            <asp:LinkButton ID="btnDownloadArtifact2" OnClick="btnDownloadArtifact_Click" runat="server" ToolTip="Download Artifact" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "artifactId")%>'><%# DataBinder.Eval(Container.DataItem, "ARTIFACT_TYPE.name")%>&nbsp;&nbsp;(<span class="glyphicon glyphicon-download-alt" style="font-size:15px;"></span>&nbsp;Download)</asp:LinkButton>
                          </td>
                          <%--<td style="text-align: left; vertical-align: middle">
                            <asp:LinkButton ID="btnDownloadArtifact2" OnClick="btnDownloadArtifact_Click" runat="server" ToolTip="Download Artifact" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "artifactId")%>'><%# DataBinder.Eval(Container.DataItem, "filename")%></asp:LinkButton>
                          </td>--%>
                          <td style="text-align: left; vertical-align: middle">
                            <%# DataBinder.Eval(Container.DataItem, "contentType")%>
                          </td>
                          <td style="text-align: center; vertical-align: middle">
                            <asp:LinkButton ID="btnDeleteArtifact2" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "artifactId")%>' runat="server" CausesValidation="false" OnClick="btnDeleteArtifact_Click" ToolTip="Remove Artifact"><span class="glyphicon glyphicon-remove" style="font-size:20px; color:red"></span></asp:LinkButton>
                          </td>
                        </tr>
                      </ItemTemplate>
                    </asp:Repeater>
                  </table>
                  <asp:LinkButton ID="btnDownloadArtifact" runat="server" Visible="false" Text="temp"></asp:LinkButton>
                  <asp:LinkButton ID="btnDeleteArtifact" runat="server" Visible="false" Text="temp"></asp:LinkButton>
                </td>
              </tr>
            </table>
          </Content>
        </ajaxToolkit:AccordionPane>
        <ajaxToolkit:AccordionPane runat="server" ID="paneStatement" TabIndex="600">
          <Header>
            <table style="width:100%">
              <tr>
                <th style="width:25%; text-align:left; vertical-align: middle">
                  Personal Statement
                </th>
                <th style="width:50%; text-align:center; vertical-align: middle">
                  <div class="progress" style="position: relative; top: 10px;">
                    <div id="prgStatement" runat="server" class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%; color: black">
                      <asp:Literal ID="ltlPercentStatement" runat="server" Text="0% Complete"></asp:Literal>
                    </div>
                  </div>
                </th>
                <th style="width:25%; text-align:right; vertical-align: middle">
                  <span class="glyphicon glyphicon-triangle-bottom"></span>
                </th>
              </tr>
            </table>
          </Header>
          <Content>
            <table border="1" style="width:100%">
              <tr>
                <td style="width:100%; padding: 5px">
                  <asp:Label runat="server" AssociatedControlID="txtPersonalStatement" CssClass="control-label" ToolTip="Personal Statement" style="white-space: nowrap">Briefly describe your personal and/or family needs (1000 characters max):</asp:Label>
                  <asp:TextBox runat="server" ID="txtPersonalStatement" AutoCompleteType="Disabled" MaxLength="1000" TabIndex="601" TextMode="MultiLine" Rows="5" Width="100%" style="max-width:100%" ValidationGroup="Submit" AutoPostBack="True" />
                  <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPersonalStatement" CssClass="text-danger" ErrorMessage="The personal statement is required." Display="Static" ValidationGroup="Submit" />
                </td>
              </tr>
            </table>
          </Content>
        </ajaxToolkit:AccordionPane>
      </Panes>      
    </ajaxToolkit:Accordion>
    <br />
    <div class="row">
      <div class="form-group">
        <div class="col-lg-12">
          <table style="width:100%">
            <tr>
              <td style="width:96%; text-align:right">
                <asp:CustomValidator ID="valUserRequiredSave" runat="server" CssClass="text-danger" ErrorMessage="You must enter your email, name and phone before saving the form." Display="Dynamic" ValidationGroup="Save" Enabled="True" />
                <asp:CustomValidator ID="valAcknowledgement" runat="server" CssClass="text-danger" ErrorMessage="You must acknowledge the submission statement by checking the box at the top of this form." Display="Dynamic" ValidationGroup="Submit" Enabled="True" />
                <asp:CustomValidator ID="valRequiredFields" runat="server" CssClass="text-danger" ErrorMessage="You must fill in all required fields on the form." Display="Dynamic" ValidationGroup="Submit" Enabled="True" />
                <asp:CustomValidator ID="valPhotoID" runat="server" CssClass="text-danger" ErrorMessage="You must have a photo identification before submitting" Display="Dynamic" ValidationGroup="Submit" />
              </td>
              <td style="width:1%; text-align:right">
                &nbsp;
              </td>
              <td style="width:1%; text-align:right">
                <asp:Button ID="btnSave" runat="server" Text="Save Application" CssClass="btn btn-default" ValidationGroup="Save" TabIndex="700" Width="150" Enabled="False" />
              </td>
              <td style="width:1%; text-align:right">
                &nbsp;
              </td>
              <td style="width:1%; text-align:right">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit Application" CssClass="btn btn-success" TabIndex="701" Width="150"  ValidationGroup="Submit" Enabled="False" />
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>    
  </div>
  <br />
  <br /><br />
</asp:Content>
