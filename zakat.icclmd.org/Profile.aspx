<%@ Page Title="Profile" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Profile.aspx.vb" Inherits="zakat.icclmd.org.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <h4><b>Online Zakat Profile</b></h4>
    <hr />
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
                        <asp:TextBox runat="server" ID="txtEmail" AutoCompleteType="Disabled" CssClass="form-control" placeholder="email@domain.com" ToolTip="Email/Username" MaxLength="60" AutoPostBack="False" TabIndex="1" ValidationGroup="Submit" />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="A valid email/username is required." ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" CssClass="text-danger" Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="valDuplicateEmail" runat="server" CssClass="text-danger" ControlToValidate="txtEmail" ErrorMessage="This username/email is already registered. Login" Display="Dynamic" ValidationGroup="Submit" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The email/username is required." Display="Static" ValidationGroup="Submit" />
                      </div>
                    </div>                            
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="col-lg-2 control-label" ToolTip="First Name" Style="white-space: nowrap">First Name:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtFirstName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="First Name" MaxLength="30" TabIndex="2" AutoPostBack="False" ValidationGroup="Submit" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" CssClass="text-danger" ErrorMessage="The first name is required." Display="Static" ValidationGroup="Submit" />
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtMiddleName" CssClass="col-lg-2 control-label" ToolTip="Middle Name" Style="white-space: nowrap">Middle Name:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtMiddleName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Middle Name" MaxLength="30" TabIndex="3" AutoPostBack="False" ValidationGroup="Submit" />
                        <asp:CustomValidator ID="CustomValidator5" runat="server" CssClass="text-danger" ControlToValidate="txtMiddleName" ErrorMessage="middle" Display="Static" ValidationGroup="Submit" />
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtLastName" CssClass="col-lg-2 control-label" ToolTip="Last Name" Style="white-space: nowrap">Last Name:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtLastName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Last Name" MaxLength="30" TabIndex="4" AutoPostBack="False" ValidationGroup="Submit" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" CssClass="text-danger" Display="Static" ErrorMessage="The last name is required." ValidationGroup="Submit" />
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtSocialSecurity" CssClass="col-lg-2 control-label" ToolTip="Social Security #" Style="white-space: nowrap">SSN:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtSocialSecurity" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Social Security #" MaxLength="11" placeholder="123-45-6789" TabIndex="5" ValidationGroup="Submit" AutoPostBack="False" />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtSocialSecurity" CssClass="text-danger" ValidationExpression="^\d{3}-\d{2}-\d{4}$" ErrorMessage="Please enter a valid SSN" Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSocialSecurity" CssClass="text-danger" ErrorMessage="The SSN is required." Display="Static" ValidationGroup="Submit" />
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtDOB" CssClass="col-lg-2 control-label" ToolTip="Date of Birth" Style="white-space: nowrap">Date of Birth:</asp:Label>
                      <div class="col-lg-10">
                        <table border="0" style="width: 280px">
                          <tr>
                            <td style="width: 90%">
                              <asp:TextBox runat="server" ID="txtDOB" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Date of Birth" BackColor="White" placeholder="mm/dd/yyyy" TabIndex="6" AutoPostBack="False" ValidationGroup="Submit" />
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
                        <asp:TextBox runat="server" ID="txtPhone" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Phone #" MaxLength="12" placeholder="555-555-1234" TabIndex="7" AutoPostBack="False" ValidationGroup="Submit" />
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
                  </div>
                </div>
              </td>
              <td style="width:50%">
                <div class="col-lg-12">
                  <div class="form-horizontal">
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtStreet" CssClass="col-lg-2 control-label" ToolTip="Address Street" Style="white-space: nowrap">Street:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtStreet" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address Street" MaxLength="100" TabIndex="10" AutoPostBack="False" ValidationGroup="Submit" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStreet" CssClass="text-danger" ErrorMessage="The address street is required." Display="Static" ValidationGroup="Submit" />
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtCity" CssClass="col-lg-2 control-label" ToolTip="Address City" Style="white-space: nowrap">City:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtCity" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address City" MaxLength="50" TabIndex="11" AutoPostBack="False" ValidationGroup="Submit" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity" CssClass="text-danger" ErrorMessage="The address city is required." Display="Static" ValidationGroup="Submit" />
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="drpState" CssClass="col-lg-2 control-label" ToolTip="Address State" Style="white-space: nowrap; position: relative; top: 0px;">State:</asp:Label>
                      <div class="col-lg-10">
                        <asp:DropDownList ID="drpState" runat="server" ToolTip="Address State" CssClass="form-control" TabIndex="12" AutoPostBack="False" ValidationGroup="Submit"></asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="drpState" CssClass="text-danger" ErrorMessage="The address state is required." InitialValue="(Select One)" ValidationGroup="Submit" />
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtZip" CssClass="col-lg-2 control-label" ToolTip="Address Zip" Style="white-space: nowrap">Zip Code:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtZip" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address Zip" MaxLength="5" TabIndex="13" AutoPostBack="False" ValidationGroup="Submit" />
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
                              <asp:TextBox runat="server" ID="txtBeganLiving" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Began Living Date" BackColor="White" placeholder="mm/dd/yyyy" TabIndex="14" AutoPostBack="False" ValidationGroup="Submit" />
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
                        <asp:DropDownList ID="drpHomeType" runat="server" ToolTip="Home Type" CssClass="form-control" TabIndex="15" AutoPostBack="False" ValidationGroup="Submit">
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
                        <asp:TextBox runat="server" ID="txtHomeType" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Specify Home Type" MaxLength="50" TabIndex="16" AutoPostBack="False" Enabled="False" ValidationGroup="Submit" />
                        <asp:RequiredFieldValidator runat="server" ID="valHomeType" Enabled="false" ControlToValidate="txtHomeType" CssClass="text-danger" ErrorMessage="Please specify the other home type." Display="Static" ValidationGroup="Submit" />
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="drpNationality" CssClass="col-lg-2 control-label" ToolTip="Nationality" Style="white-space: nowrap; position: relative; top: 0px;">Nationality:</asp:Label>
                      <div class="col-lg-10">
                        <asp:DropDownList ID="drpNationality" runat="server" ToolTip="Nationality" CssClass="form-control" TabIndex="17" AutoPostBack="False" ValidationGroup="Submit">
                          <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="drpCitizenship" CssClass="text-danger" ErrorMessage="The nationality is required." InitialValue="(Select One)" ValidationGroup="Submit" />
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="drpCitizenship" CssClass="col-lg-2 control-label" ToolTip="Citizenship Status" Style="white-space: nowrap; position: relative; top: 0px;">Citizenship:</asp:Label>
                      <div class="col-lg-10">
                        <asp:DropDownList ID="drpCitizenship" runat="server" ToolTip="Citizenship Status" CssClass="form-control" TabIndex="18" AutoPostBack="False" ValidationGroup="Submit">
                          <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                          <asp:ListItem Text="Permanent Resident" Value="Permanent Resident"></asp:ListItem>
                          <asp:ListItem Text="Non-Citizen" Value="Non-Citizen"></asp:ListItem>
                          <asp:ListItem Text="US Citizen" Value="US Citizen"></asp:ListItem>
                          <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="drpCitizenship" CssClass="text-danger" ErrorMessage="The citizenship status is required." InitialValue="(Select One)" ValidationGroup="Submit" />
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
                          <asp:ListBox ID="lstLanguages"  runat="server" CssClass="form-control" AutoPostBack="False" Rows="3" Width="100%" TabIndex="19" ></asp:ListBox>
                        </td>
                        <td style="text-align: center;width: 10%">
                          <br /><br />
                          <asp:LinkButton ID="btnAddLanguage" runat="server" ToolTip="Add the Language" TabIndex="20" CausesValidation="false" >
                            <span class="fas fa-arrow-alt-circle-right" style="color: darkgreen; font-size: 25px" ></span>
                          </asp:LinkButton>
                          <br /><br />
                          <asp:LinkButton ID="btnDeleteLanguage" runat="server" ToolTip="Remove the Language" TabIndex="21" CausesValidation="false" >
                            <span class="fas fa-arrow-alt-circle-left" style="color: darkgreen; font-size: 25px" ></span>
                          </asp:LinkButton>
                          <br /><br />
                        </td>
                        <td style="width: 45%">
                          <b>Languages Spoken:</b><br />
                          <asp:ListBox ID="lstSpoken"  runat="server" CssClass="form-control" AutoPostBack="False" Rows="3" Width="100%" TabIndex="22" ></asp:ListBox>
                        </td>
                      </tr>
                    </table>
                    <table style="width: 100%; white-space: nowrap">
                      <tr>
                        <td style="width: 100%">
                          <b>Enter a Skill or Certification then Add to your List:</b><br />
                          <table border="0" style="width: 100%">
                            <tr>
                              <td style="width: 95%">
                                <asp:TextBox ID="txtSkillCertification" AutoCompleteType="Disabled" runat="server" CssClass="form-control" style="max-width:100%;width:100%" TabIndex="23" MaxLength="100"></asp:TextBox>
                              </td>
                              <td>&nbsp;</td>
                              <td style="width: 5%; vertical-align: middle">
                                <asp:LinkButton ID="btnAddCertification" runat="server" style="width:100%;" TabIndex="23" CausesValidation="false" ToolTip="Add Certification to List"><i class="fas fa-plus-circle" style="font-size:20px;color:darkgreen"></i></asp:LinkButton>
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
                                <asp:ListBox ID="lstSkillCertification" runat="server" AutoPostBack="False" Rows="3" CssClass="form-control" style="max-width:100%;width:100%" TabIndex="24" ></asp:ListBox>
                              </td>
                              <td>&nbsp;</td>
                              <td style="width: 5%; vertical-align: bottom">
                                <asp:LinkButton ID="btnRemoveCertification" runat="server" style="width:100%; position:relative; top:-5px" TabIndex="24" CausesValidation="false" ToolTip="Remove Certification from List"><i class="fas fa-minus-circle" style="font-size:20px;color:red"></i></asp:LinkButton>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                    <br />
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="drpHighestEducation" CssClass="col-lg-4 control-label" ToolTip="Highest Education Completed" style="white-space: nowrap; position: relative; top: 0px;">Highest Education:</asp:Label>
                      <div class="col-lg-8">
                        <asp:DropDownList ID="drpHighestEducation" style="max-width: 100%;" runat="server" ToolTip="Highest Education Completed" CssClass="form-control" TabIndex="25" AutoPostBack="False" ValidationGroup="Submit">
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
                      <asp:Label runat="server" AssociatedControlID="txtSchoolName" CssClass="col-lg-2 control-label" ToolTip="School Name" Style="white-space: nowrap">School Name:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtSchoolName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="School Name" MaxLength="100" TabIndex="26" AutoPostBack="False" ValidationGroup="Submit" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSchoolName" CssClass="text-danger" ErrorMessage="The school name is required." Display="Static" ValidationGroup="Submit" />
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtSchoolStreet" CssClass="col-lg-2 control-label" ToolTip="Address Street" Style="white-space: nowrap">School Street:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtSchoolStreet" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address Street" MaxLength="100" TabIndex="27" AutoPostBack="False" ValidationGroup="Submit" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSchoolStreet" CssClass="text-danger" ErrorMessage="The school street is required." Display="Static" ValidationGroup="Submit" />
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtSchoolCity" CssClass="col-lg-2 control-label" ToolTip="Address City" Style="white-space: nowrap">School City:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtSchoolCity" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address City" MaxLength="50" TabIndex="28" AutoPostBack="False" ValidationGroup="Submit" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSchoolCity" CssClass="text-danger" ErrorMessage="The school city is required." Display="Static" ValidationGroup="Submit" />
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="drpSchoolState" CssClass="col-lg-2 control-label" ToolTip="Address State" Style="white-space: nowrap; position: relative; top: 0px;">School State:</asp:Label>
                      <div class="col-lg-10">
                        <asp:DropDownList ID="drpSchoolState" runat="server" ToolTip="Address State" CssClass="form-control" TabIndex="29" AutoPostBack="False" ValidationGroup="Submit"></asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="drpSchoolState" CssClass="text-danger" ErrorMessage="The school state is required." InitialValue="(Select One)" ValidationGroup="Submit" />
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtSchoolZip" CssClass="col-lg-2 control-label" ToolTip="Address Zip" Style="white-space: nowrap">School Zip:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtSchoolZip" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Address Zip" MaxLength="5" TabIndex="30" AutoPostBack="False" ValidationGroup="Submit" />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtSchoolZip" CssClass="text-danger" ValidationExpression="^\d{5}$" ErrorMessage="Please enter a valid zip code" Display="Dynamic" ValidationGroup="Submit"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSchoolZip" CssClass="text-danger" ErrorMessage="The school zip code is required." Display="Static" ValidationGroup="Submit" />
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
                        <asp:TextBox runat="server" ID="txtHusbandFirstName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="First Name" MaxLength="30" TabIndex="31" AutoPostBack="False" ValidationGroup="Submit" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtHusbandFirstName" CssClass="text-danger" ErrorMessage="The husband first name is required." Display="Static" ValidationGroup="Submit" />
                      </div>
                    </div>
                      <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtHusbandMiddleName" CssClass="col-lg-2 control-label" ToolTip="Middle Name" Style="white-space: nowrap">Middle Name:</asp:Label>
                        <div class="col-lg-10">
                          <asp:TextBox runat="server" ID="txtHusbandMiddleName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Middle Name" MaxLength="30" TabIndex="32" AutoPostBack="False" ValidationGroup="Submit" />
                          <asp:CustomValidator ID="CustomValidator6" runat="server" CssClass="text-danger" ControlToValidate="txtHusbandMiddleName" ErrorMessage="middle" Display="Static" ValidationGroup="Submit" />
                        </div>
                      </div>
                      <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtHusbandLastName" CssClass="col-lg-2 control-label" ToolTip="Last Name" Style="white-space: nowrap">Last Name:</asp:Label>
                        <div class="col-lg-10">
                          <asp:TextBox runat="server" ID="txtHusbandLastName" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Last Name" MaxLength="30" TabIndex="33" AutoPostBack="False" ValidationGroup="Submit" />
                          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtHusbandLastName" CssClass="text-danger" Display="Static" ErrorMessage="The husband last name is required." ValidationGroup="Submit" />
                        </div>
                      </div>
                      <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="txtHusbandPhone" CssClass="col-lg-2 control-label" ToolTip="Phone #" Style="white-space: nowrap">Phone #:</asp:Label>
                        <div class="col-lg-10">
                          <asp:TextBox runat="server" ID="txtHusbandPhone" AutoCompleteType="Disabled" CssClass="form-control" ToolTip="Phone #" MaxLength="12" placeholder="555-555-1234" TabIndex="34" AutoPostBack="False" ValidationGroup="Submit" />
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
                          <asp:TextBox runat="server" ID="txtHusbandEmail" AutoCompleteType="Disabled" CssClass="form-control" placeholder="email@domain.com" ToolTip="Email" MaxLength="60" AutoPostBack="False" TabIndex="35" ValidationGroup="Submit" />
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
                          <asp:RadioButtonList ID="chkHusbandApplied" runat="server" RepeatDirection="Horizontal" Style="position: relative; top: 6px;" ToolTip="Hus" TabIndex="36" ValidationGroup="Submit" AutoPostBack="False">
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
                          <asp:TextBox runat="server" ID="txtHusbandExplanation" CssClass="form-control" AutoCompleteType="Disabled" ToolTip="Explanation for husband not applying" MaxLength="1000" TabIndex="37" TextMode="MultiLine" Rows="2" Width="100%" style="max-width:100%" ValidationGroup="Submit" AutoPostBack="False" />
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
  <br />
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
                <asp:Button ID="btnSave" runat="server" Text="Save Profile" CssClass="btn btn-success" ValidationGroup="Save" TabIndex="600" Width="150" />
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  <br /><br />
</asp:Content>
