<%@ Page Title="Zakat Form" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ZakatForm.aspx.vb" Inherits="zakat.icclmd.org.ZakatForm" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container">
    <h4><b>New Zakat Application</b></h4>
    <div class="row">
      <div class="col-lg-12">
        <div class="well well-sm" style="text-align:justify">
          <h5>By filling out and submitting this online zakat form, I authorize the organziation to verify the information contained therein. I understand that I may be required to present proof of all the statements in this application upon request. I understand that a representative of the organization will verify the necessary information in order to render any assistance to me in a timely and discreet manner. I am aware that due to unforeseen circumstances, assistance I requested may be unavailable. When I submit this zakat application for review, I certify that I have read, or had read to me all the statements in this online form and all the information given is true, correct, and complete to the best of my knowledge.
          </h5>  
        </div>
      </div>
    </div>

    <style type="text/css">
      body
      {
          font-family: inherit;
          font-size: 14px;
      }
      /* Accordion */
      .accordionHeader
      {
          border: 1px solid #2F4F4F;
          color: black;
          background-color: darkgray;
          font-family: inherit;
          font-size: 14px;
          font-weight: bold;
          padding: 5px;
          margin-top: 5px;
          cursor: pointer;
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
          color: black;
          background-color: lightgray;
          font-family: inherit;
          font-size: 14px;
          font-weight: bold;
          padding: 5px;
          margin-top: 5px;
          cursor: pointer;
      }
  </style>

    <ajaxToolkit:Accordion ID="Accordion" runat="server" RequireOpenedPane="False" FadeTransitions="True" HeaderCssClass="accordionHeader" HeaderSelectedCssClass="accordionHeaderSelected" ContentCssClass="accordionContent">
      <Panes>
        <ajaxToolkit:AccordionPane runat="server" ID="paneApplicant">
          <Header>
            <table style="width:100%">
              <tr>
                <th style="width:25%; text-align:left; vertical-align: middle">
                  Applicant Information
                </th>
                <th style="width:50%; text-align:center; vertical-align: middle">
                  <div class="progress" style="position: relative; top: 10px;">
                    <div id="prgApplicant" runat="server" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%; color: black">
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

          </Content>
        </ajaxToolkit:AccordionPane>
        <ajaxToolkit:AccordionPane runat="server" ID="paneBackground">
          <Header>Background</Header>
          <Content>Background</Content>
        </ajaxToolkit:AccordionPane>
      </Panes>      
    </ajaxToolkit:Accordion>

    <br />

    <div class="panel-group" id="accordion">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapse1" tabindex="1">
              <%--<table style="width:100%">
                <tr>
                  <th style="width:25%; text-align:left; vertical-align: middle">
                    Applicant Information
                  </th>
                  <th style="width:50%; text-align:center; vertical-align: middle">
                    <div class="progress" style="position: relative; top: 10px;">
                      <div id="prgApplicant" runat="server" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%; color: black">
                        <asp:Literal ID="ltlPercentApplicant" runat="server" Text="0% Complete"></asp:Literal>
                      </div>
                    </div>
                  </th>
                  <th style="width:25%; text-align:right; vertical-align: middle">
                    <span class="glyphicon glyphicon-triangle-bottom"></span>
                  </th>
                </tr>
              </table>--%>
            </a>
          </h4>
        </div>
        <div id="collapse1" class="panel-collapse collapse">
          <div class="panel-body">
            <%--General Information Content--%>
            <div class="row">
              <div class="col-lg-6">
                <div class="form-horizontal">
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-lg-2 control-label" ToolTip="Email/Username" Style="white-space: nowrap">Email:</asp:Label>
                    <div class="col-lg-10">
                      <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="email@domain.com" AutoCompleteType="Email" ToolTip="Email/Username" MaxLength="60" AutoPostBack="True" TabIndex="1" />
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="A valid email/username is required." ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" CssClass="text-danger" Display="Dynamic"></asp:RegularExpressionValidator>
                      <asp:CustomValidator ID="valDuplicateEmail" runat="server" CssClass="text-danger" ControlToValidate="txtEmail" ErrorMessage="This username/email is already registered." Display="Dynamic" />
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The email/username is required." Display="Static" />
                    </div>
                  </div>
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtSocialSecurity" CssClass="col-lg-2 control-label" ToolTip="Social Security #" Style="white-space: nowrap">SSN:</asp:Label>
                    <div class="col-lg-10">
                      <asp:TextBox runat="server" ID="txtSocialSecurity" CssClass="form-control" ToolTip="Social Security #" MaxLength="11" placeholder="123-45-6789" TabIndex="1" AutoPostBack="True" />
                      <asp:RegularExpressionValidator runat="server" ControlToValidate="txtSocialSecurity" CssClass="text-danger" ValidationExpression="^\d{3}-\d{2}-\d{4}$" ErrorMessage="Please enter a valid SSN" Display="Dynamic"></asp:RegularExpressionValidator>
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSocialSecurity" CssClass="text-danger" ErrorMessage="The phone number is required." Display="Static" />
                      <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtSocialSecurity" Mask="999-99-9999" MaskType="None" ClearMaskOnLostFocus="False" />
                    </div>
                  </div>
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="col-lg-2 control-label" ToolTip="First Name" Style="white-space: nowrap">First Name:</asp:Label>
                    <div class="col-lg-10">
                      <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control" ToolTip="First Name" MaxLength="30" TabIndex="2" AutoPostBack="True" />
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" CssClass="text-danger" ErrorMessage="The first name is required." Display="Static" />
                    </div>
                  </div>
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtMiddleName" CssClass="col-lg-2 control-label" ToolTip="Middle Name" Style="white-space: nowrap">Middle Name:</asp:Label>
                    <div class="col-lg-10">
                      <asp:TextBox runat="server" ID="txtMiddleName" CssClass="form-control" ToolTip="Middle Name" MaxLength="30" TabIndex="3" AutoPostBack="True" />
                      <asp:CustomValidator ID="CustomValidator5" runat="server" CssClass="text-danger" ControlToValidate="txtMiddleName" ErrorMessage="middle" Display="Static" />
                      <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="txtMiddleName" CssClass="text-danger" Display="Static" ErrorMessage="The middle (or father's) name is required." />--%>
                    </div>
                  </div>
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtLastName" CssClass="col-lg-2 control-label" ToolTip="Last Name" Style="white-space: nowrap">Last Name:</asp:Label>
                    <div class="col-lg-10">
                      <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control" ToolTip="Last Name" MaxLength="30" TabIndex="4" AutoPostBack="True" />
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" CssClass="text-danger" Display="Static" ErrorMessage="The last name is required." />
                    </div>
                  </div>
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="chkGender" CssClass="col-lg-2 control-label" ToolTip="Gender" Style="white-space: nowrap; position: relative; top: 0px;">Gender:</asp:Label>
                    <div class="col-lg-10">
                      <asp:RadioButtonList ID="chkGender" runat="server" RepeatDirection="Horizontal" Style="position: relative; top: 6px;" ToolTip="Gender" TabIndex="5" AutoPostBack="True">
                        <asp:ListItem Text="Male" Value="Male">&nbsp;&nbsp;Male&nbsp;&nbsp;</asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female">&nbsp;&nbsp;Female</asp:ListItem>
                      </asp:RadioButtonList>
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="chkGender" CssClass="text-danger" Display="Static" ErrorMessage="The gender is required." />
                    </div>
                  </div>          
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtDOB" CssClass="col-lg-2 control-label" ToolTip="Date of Birth" Style="white-space: nowrap">Date of Birth:</asp:Label>
                    <div class="col-lg-10">
                      <table border="0" style="width: 280px">
                        <tr>
                          <td style="width: 90%">
                            <asp:TextBox runat="server" ID="txtDOB" CssClass="form-control" ToolTip="Date of Birth" BackColor="White" placeholder="mm/dd/yyyy" TabIndex="6" AutoPostBack="True" />
                          </td>
                          <td style="width: 10%; text-align: center;">
                            <a href="#" runat="server" id="lnkCalendarDOB">
                              <span class="glyphicon glyphicon-calendar" style="font-size: 20px; color: darkgreen" tabindex="6"></span>
                            </a>
                          </td>
                        </tr>
                      </table>
                      <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter a valid date." CssClass="text-danger" Display="Dynamic" ValidationExpression="^(0?[1-9]|1[0-2])/(0?[1-9]|1[0-9]|2[0-9]|3[01])/\d{4}$" ControlToValidate="txtDOB"></asp:RegularExpressionValidator>
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDOB" CssClass="text-danger" ErrorMessage="The date of birth is required." Display="Static" />
                      <ajaxToolkit:CalendarExtender ID="calDOB" runat="server" TargetControlID="txtDOB" PopupButtonID="lnkCalendar" />
                    </div>
                  </div>
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtPhone" CssClass="col-lg-2 control-label" ToolTip="Phone #" Style="white-space: nowrap">Phone #:</asp:Label>
                    <div class="col-lg-10">
                      <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" ToolTip="Phone #" MaxLength="14" placeholder="(555) 555-1234" TabIndex="7" AutoPostBack="True" />
                      <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ValidationExpression="^(1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$" ErrorMessage="Please enter a valid phone number" Display="Dynamic"></asp:RegularExpressionValidator>
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ErrorMessage="The phone number is required." Display="Static" />
                      <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtPhone" Mask="(999) 999-9999" MaskType="None" ClearMaskOnLostFocus="False" />
                    </div>
                  </div>
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="drpMaritalStatus" CssClass="col-lg-2 control-label" ToolTip="Marital Status" Style="white-space: nowrap; position: relative; top: 0px;">Marital Status:</asp:Label>
                    <div class="col-lg-10">
                      <asp:DropDownList ID="drpMaritalStatus" runat="server" ToolTip="Marital Status" CssClass="form-control" TabIndex="8" AutoPostBack="True">
                        <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Single" Value="Single"></asp:ListItem>
                        <asp:ListItem Text="Married" Value="Married"></asp:ListItem>
                        <%--<asp:ListItem Text="Divorced" Value="Divorced"></asp:ListItem>
                        <asp:ListItem Text="Separated" Value="Separated"></asp:ListItem>
                        <asp:ListItem Text="Widowed" Value="Widowed"></asp:ListItem>--%>
                      </asp:DropDownList>
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="drpMaritalStatus" CssClass="text-danger" ErrorMessage="The marital status is required." InitialValue="(Select One)" />
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-6">
                <div class="form-horizontal">
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtStreet" CssClass="col-lg-2 control-label" ToolTip="Address Street" Style="white-space: nowrap">Street:</asp:Label>
                    <div class="col-lg-10">
                      <asp:TextBox runat="server" ID="txtStreet" CssClass="form-control" ToolTip="Address Street" MaxLength="100" TabIndex="9" AutoPostBack="True" />
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStreet" CssClass="text-danger" ErrorMessage="The address street is required." Display="Static" />
                    </div>
                  </div>
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtCity" CssClass="col-lg-2 control-label" ToolTip="Address City" Style="white-space: nowrap">City:</asp:Label>
                    <div class="col-lg-10">
                      <asp:TextBox runat="server" ID="txtCity" CssClass="form-control" ToolTip="Address City" MaxLength="50" TabIndex="10" AutoPostBack="True" />
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity" CssClass="text-danger" ErrorMessage="The address city is required." Display="Static" />
                    </div>
                  </div>
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="drpState" CssClass="col-lg-2 control-label" ToolTip="Address State" Style="white-space: nowrap; position: relative; top: 0px;">State:</asp:Label>
                    <div class="col-lg-10">
                      <asp:DropDownList ID="drpState" runat="server" ToolTip="Address State" CssClass="form-control" TabIndex="11" AutoPostBack="True"></asp:DropDownList>
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="drpState" CssClass="text-danger" ErrorMessage="The address state is required." InitialValue="(Select One)" />
                    </div>
                  </div>
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtZip" CssClass="col-lg-2 control-label" ToolTip="Address Zip" Style="white-space: nowrap">Zip Code:</asp:Label>
                    <div class="col-lg-10">
                      <asp:TextBox runat="server" ID="txtZip" CssClass="form-control" ToolTip="Address Zip" MaxLength="5" TabIndex="12" AutoPostBack="True" />
                      <asp:RegularExpressionValidator runat="server" ControlToValidate="txtZip" CssClass="text-danger" ValidationExpression="^\d{5}$" ErrorMessage="Please enter a valid zip code" Display="Dynamic"></asp:RegularExpressionValidator>
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtZip" CssClass="text-danger" ErrorMessage="The address zip code is required." Display="Static" />
                    </div>
                  </div>
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtBeganLiving" CssClass="col-lg-2 control-label" ToolTip="Began Living Date" Style="white-space: nowrap">Began Living:</asp:Label>
                    <div class="col-lg-10">
                      <table border="0" style="width: 280px">
                        <tr>
                          <td style="width: 90%">
                            <asp:TextBox runat="server" ID="txtBeganLiving" CssClass="form-control" ToolTip="Began Living Date" BackColor="White" placeholder="mm/dd/yyyy" TabIndex="13" AutoPostBack="True" />
                          </td>
                          <td style="width: 10%; text-align: center;">
                            <a href="#" runat="server" id="lnkCalendarBeganLiving">
                              <span class="glyphicon glyphicon-calendar" style="font-size: 20px; color: darkgreen" tabindex="13"></span>
                            </a>
                          </td>
                        </tr>
                      </table>
                      <asp:RegularExpressionValidator runat="server" ErrorMessage="Enter a valid date." CssClass="text-danger" Display="Dynamic" ValidationExpression="^(0?[1-9]|1[0-2])/(0?[1-9]|1[0-9]|2[0-9]|3[01])/\d{4}$" ControlToValidate="txtBeganLiving"></asp:RegularExpressionValidator>
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="txtBeganLiving" CssClass="text-danger" ErrorMessage="The time resided at the home is required." Display="Static" />
                      <ajaxToolkit:CalendarExtender ID="calBeganLiving" runat="server" TargetControlID="txtBeganLiving" PopupButtonID="lnkCalendarBeganLiving" />
                    </div>
                  </div>

                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="drpHomeType" CssClass="col-lg-2 control-label" ToolTip="Home Type" Style="white-space: nowrap; position: relative; top: 0px;">Home Type:</asp:Label>
                    <div class="col-lg-10">
                      <asp:DropDownList ID="drpHomeType" runat="server" ToolTip="Home Type" CssClass="form-control" TabIndex="14" AutoPostBack="True">
                        <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Own" Value="Own"></asp:ListItem>
                        <asp:ListItem Text="Rent" Value="Rent"></asp:ListItem>
                        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                      </asp:DropDownList>
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="drpHomeType" CssClass="text-danger" ErrorMessage="The home type is required." InitialValue="(Select One)" />
                    </div>
                  </div>
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="txtHomeType" CssClass="col-lg-2 control-label" ToolTip="Home Type" Style="white-space: nowrap">Specify:</asp:Label>
                    <div class="col-lg-10">
                      <asp:TextBox runat="server" ID="txtHomeType" CssClass="form-control" ToolTip="Specify Home Type" MaxLength="2" TabIndex="15" AutoPostBack="True" Enabled="False" />
                      <asp:RequiredFieldValidator runat="server" ID="valHomeType" Enabled="false" ControlToValidate="txtHomeType" CssClass="text-danger" ErrorMessage="Please specify the other home type." Display="Static" />
                    </div>
                  </div>
                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="drpNationality" CssClass="col-lg-2 control-label" ToolTip="Nationality" Style="white-space: nowrap; position: relative; top: 0px;">Nationality:</asp:Label>
                    <div class="col-lg-10">
                      <asp:DropDownList ID="drpNationality" runat="server" ToolTip="Nationality" CssClass="form-control" TabIndex="16" AutoPostBack="True">
                        <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                      </asp:DropDownList>
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="drpCitizenship" CssClass="text-danger" ErrorMessage="The nationality is required." InitialValue="(Select One)" />
                    </div>
                  </div>

                  <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="drpCitizenship" CssClass="col-lg-2 control-label" ToolTip="Citizenship Status" Style="white-space: nowrap; position: relative; top: 0px;">Citizenship:</asp:Label>
                    <div class="col-lg-10">
                      <asp:DropDownList ID="drpCitizenship" runat="server" ToolTip="Citizenship Status" CssClass="form-control" TabIndex="17" AutoPostBack="True">
                        <asp:ListItem Text="(Select One)" Value="(Select One)" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Permanent Resident" Value="Permanent Resident"></asp:ListItem>
                        <asp:ListItem Text="Non-Citizen" Value="Non-Citizen"></asp:ListItem>
                        <asp:ListItem Text="US Citizen" Value="US Citizen"></asp:ListItem>
                        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                      </asp:DropDownList>
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="drpCitizenship" CssClass="text-danger" ErrorMessage="The citizenship status is required." InitialValue="(Select One)" />
                    </div>
                  </div>
                </div>
              </div>
            </div>

          </div>
        </div>
      </div>

      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapse2" tabindex="100">              
              <table style="width:100%">
                <tr>
                  <th style="width:25%; text-align:left; vertical-align: middle">
                    Background Information
                  </th>
                  <th style="width:50%; text-align:center; vertical-align: middle">
                    <div class="progress" style="position: relative; top: 10px;">
                      <div id="prgBackground" runat="server" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width:80%; color: black">
                        <asp:Literal ID="ltlPercentBackground" runat="server" Text="80% Complete"></asp:Literal>
                      </div>
                    </div>
                  </th>
                  <th style="width:25%; text-align:right; vertical-align: middle">
                    <span class="glyphicon glyphicon-triangle-bottom"></span>
                  </th>
                </tr>
              </table>
            </a>
          </h4>
        </div>
        <div id="collapse2" class="panel-collapse collapse">
          <div class="panel-body">
            Background Infoamation Content
          </div>
        </div>
      </div>

      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapse3" tabindex="200">
              <table style="width:100%">
                <tr>
                  <th style="width:25%; text-align:left; vertical-align: middle">
                    Financial Information
                  </th>
                  <th style="width:50%; text-align:center; vertical-align: middle">
                    <div class="progress" style="position: relative; top: 10px;">
                      <div id="prgFinancial" runat="server" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width:60%; color: black">
                        <asp:Literal ID="ltlPercentFinancial" runat="server" Text="60% Complete"></asp:Literal>
                      </div>
                    </div>
                  </th>
                  <th style="width:25%; text-align:right; vertical-align: middle">
                    <span class="glyphicon glyphicon-triangle-bottom"></span>
                  </th>
                </tr>
              </table>
            </a>
          </h4>
        </div>
        <div id="collapse3" class="panel-collapse collapse">
          <div class="panel-body">
            Financial and Employment Information Content
          </div>
        </div>
      </div>

      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapse4" tabindex="300">
              <table style="width:100%">
                <tr>
                  <th style="width:25%; text-align:left; vertical-align: middle">
                    Dependent Information
                  </th>
                  <th style="width:50%; text-align:center; vertical-align: middle">
                    <div class="progress" style="position: relative; top: 10px;">
                      <div id="Div3" runat="server" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width:50%; color: black">
                        <asp:Literal ID="ltlPercentDependent" runat="server" Text="50% Complete"></asp:Literal>
                      </div>
                    </div>
                  </th>
                  <th style="width:25%; text-align:right; vertical-align: middle">
                    <span class="glyphicon glyphicon-triangle-bottom"></span>
                  </th>
                </tr>
              </table>
            </a>
          </h4>
        </div>
        <div id="collapse4" class="panel-collapse collapse">
          <div class="panel-body">
            Dependent Information Content
          </div>
        </div>
      </div>

      <div class="panel panel-default">
        <div class="panel-heading">
          <h4 class="panel-title">
            <a data-toggle="collapse" data-parent="#accordion" href="#collapse5" tabindex="400">
              <table style="width:100%">
                <tr>
                  <th style="width:25%; text-align:left; vertical-align: middle">
                    Reference Information
                  </th>
                  <th style="width:50%; text-align:center; vertical-align: middle">
                    <div class="progress" style="position: relative; top: 10px;">
                      <div id="prgReference" runat="server" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="1" aria-valuemin="0" aria-valuemax="100" style="width:1%; color: black">
                        <asp:Literal ID="ltlPercentReference" runat="server" Text="1% Complete"></asp:Literal>
                      </div>
                    </div>
                  </th>
                  <th style="width:25%; text-align:right; vertical-align: middle">
                    <span class="glyphicon glyphicon-triangle-bottom"></span>
                  </th>
                </tr>
              </table>
            </a>
          </h4>
        </div>
        <div id="collapse5" class="panel-collapse collapse">
          <div class="panel-body">
            <div class="row">
              <div class="col-lg-12">
                <div class="col-lg-6">
                  <div class="form-horizontal">
                    <div class="form-group">
                      <div class="col-lg-2">&nbsp;</div>
                      <div class="col-lg-10">
                        <asp:CheckBox ID="chkReference" runat="server" TabIndex="17" AutoPostBack="True" />&nbsp;&nbsp;<asp:Label runat="server" AssociatedControlID="chkReference" Style="white-space: nowrap">I Have a Reference</asp:Label>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" CssClass="text-danger" Display="Static" ErrorMessage="You must be the head of household to complete this form."></asp:CustomValidator>
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtRefEmail" CssClass="col-lg-2 control-label" ToolTip="Reference Email" Style="white-space: nowrap">Ref. Email:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtRefEmail" CssClass="form-control" placeholder="email@domain.com" AutoCompleteType="Email" ToolTip="Reference Email Address" MaxLength="60"  TabIndex="18" />
                        <asp:CustomValidator ID="CustomValidator3" runat="server" CssClass="text-danger" ControlToValidate="txtRefEmail" ErrorMessage="This email is already registered." Display="Static" />
                      </div>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6">
                  <div class="form-horizontal">
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtRefName" CssClass="col-lg-2 control-label" ToolTip="Full Name" Style="white-space: nowrap">Ref. Name:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtRefName"  CssClass="form-control" ToolTip="Reference Full Name" MaxLength="30" TabIndex="19" />
                        <asp:CustomValidator ID="CustomValidator2" runat="server" CssClass="text-danger" Display="Static" ErrorMessage="You must be the head of household to complete this form."></asp:CustomValidator>
                      </div>
                    </div>
                    <div class="form-group">
                      <asp:Label runat="server" AssociatedControlID="txtRefPhone" CssClass="col-lg-2 control-label" ToolTip="Phone #" Style="white-space: nowrap">Ref. Phone:</asp:Label>
                      <div class="col-lg-10">
                        <asp:TextBox runat="server" ID="txtRefPhone" CssClass="form-control" ToolTip="Reference Phone #" MaxLength="14" placeholder="(555) 555-1234" TabIndex="20" />
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtRefPhone" CssClass="text-danger" ValidationExpression="^(1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$" ErrorMessage="Please enter a valid reference phone number" Display="Dynamic"></asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="CustomValidator4" runat="server" CssClass="text-danger" Display="Static" ErrorMessage="Phone"></asp:CustomValidator>
                        <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtRefPhone" Mask="(999) 999-9999" MaskType="None" ClearMaskOnLostFocus="False" />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    
    </div>
    
    <div class="row">
      <div class="form-group">
        <div class="col-lg-7">
          &nbsp;
        </div>
        <div class="col-lg-5">
          <table style="width:100%">
            <tr>
              <%--<td style="width:100%; text-align:right">
                <asp:Button ID="btnTest" runat="server" Text="Test" CssClass="btn btn-primary" TabIndex="500" Width="150" />
              </td>--%>
              <td style="width:100%; text-align:right">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit Application" CssClass="btn btn-success" TabIndex="500" Width="150" />
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
