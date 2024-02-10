<%@ Page Title="Feedback" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Feedback.aspx.vb" Inherits="zakat.icclmd.org.Feedback" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

  <br />
  <br />
  <br />
  
  <style type="text/css">
    /* Rating */
    .ratingStar {
        font-size: 0pt;
        width: 64px;
        height: 59px;
        margin: 5px;
        padding: 5px;
        cursor: pointer;
        display: block;
        background-repeat: no-repeat;
    }

    .filledRatingStar {
        background-image: url(./Images/FilledStar.png);
    }

    .emptyRatingStar {
        background-image: url(./Images/EmptyStar.png);
    }

    .savedRatingStar {
        background-image: url(./Images/SavedStar.png);
    }
  </style>

  <script type="text/javascript">
    function pageLoad() {
      $find('RatingBehavior1').add_endClientCallback(function (sender, e) {
          // Show the result of the Rating1_Changed ajax postback.
        var LabelRatingSatisfaction = $get('<%= lblRatingSatisfaction.ClientID %>');
        LabelRatingSatisfaction.innerHTML = e.get_CallbackResult();
      });
    }
  </script>

  <script type="text/javascript">
    function pageLoad() {
      $find('RatingBehavior1').add_endClientCallback(function (sender, e) {
        // Show the result of the Rating2_Changed ajax postback.
        var LabelRatingReceommendation = $get('<%= lblRatingReceommendation.ClientID %>');
        LabelRatingReceommendation.innerHTML = e.get_CallbackResult();
      });
    }
  </script>

  <script type="text/javascript">
    function pageLoad() {
      $find('RatingBehavior1').add_endClientCallback(function (sender, e) {
        // Show the result of the Rating2_Changed ajax postback.
        var LabelRatingExperience = $get('<%= lblRatingExperience.ClientID %>');
        LabelRatingExperience.innerHTML = e.get_CallbackResult();
    });
    }
  </script>

  <h3>Feedback Survey</h3>
  <div class="row">
    <div class="col-lg-12">
      <div class="well well-sm">
        <h5>
          <b>Thanks for using ZakatNetwork! We value your feedback and would appreciate it if you take a moment to share thoughts on your experience with our platform.</b>
        </h5>
      </div>
    </div>
  </div>

  <%--Optional Header--%>
  <div class="row">
    <div class="form-group">
      <div class="col-lg-1">&nbsp;</div>
      <div class="col-lg-10">
        <b>Optional Survey Information:</b>
      </div>
    </div>
  </div>
  <br />
  
  <%--Optional Information--%>
  <div class="row">
    <div class="col-lg-6">
      <div class="form-horizontal">
        <div class="form-group">
          <asp:Label runat="server" AssociatedControlID="txtFirstName" CssClass="col-lg-2 control-label" ToolTip="First Name" Style="white-space: nowrap">First Name:</asp:Label>
          <div class="col-lg-10">
            <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control" ToolTip="First Name" MaxLength="30" TabIndex="1" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" CssClass="text-danger" ErrorMessage="The first name is required." Display="Static" />
          </div>
        </div>
        <div class="form-group">
          <asp:Label runat="server" AssociatedControlID="txtLastName" CssClass="col-lg-2 control-label" ToolTip="Last Name" Style="white-space: nowrap">Last Name:</asp:Label>
          <div class="col-lg-10">
            <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control" ToolTip="Last Name" MaxLength="30" TabIndex="2" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" CssClass="text-danger" Display="Static" ErrorMessage="The last name is required." />
          </div>
        </div>
      </div>
    </div>
    <div class="col-lg-6">
      <div class="form-horizontal">
        <div class="form-group">
        <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-lg-2 control-label" ToolTip="Email/Username" Style="white-space: nowrap">Email:</asp:Label>
          <div class="col-lg-10">
            <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="email@domain.com" AutoCompleteType="Email" ToolTip="Email/Username" MaxLength="60" AutoPostBack="True" TabIndex="3" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="A valid email/username is required." ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" CssClass="text-danger" Display="Dynamic"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The email/username is required." Display="Static" />
          </div>
        </div>
        <div class="form-group">
          <asp:Label runat="server" AssociatedControlID="txtPhone" CssClass="col-lg-2 control-label" ToolTip="Phone #" Style="white-space: nowrap">Phone #:</asp:Label>
          <div class="col-lg-10">
            <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" ToolTip="Phone #" MaxLength="14" placeholder="555-555-1234" TabIndex="4" />
            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ValidationExpression="^(1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$" ErrorMessage="Please enter a valid phone number" Display="Dynamic"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ErrorMessage="The phone number is required." Display="Static" />
            <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtPhone" Mask="999-999-9999" MaskType="None" ClearMaskOnLostFocus="False" />
          </div>
        </div>
      </div>
    </div>
    <div class="col-lg-6">
      <div class="form-horizontal">
        <div class="form-group">
        <asp:Label runat="server" CssClass="col-lg-2 control-label" ToolTip="Email/Username" Style="white-space: nowrap"></asp:Label>
          <div class="col-lg-10">
            <asp:CheckBox ID="chkFollowUp" runat="server" Text="&nbsp;&nbsp;I Require A Follow Up Regarding My Feedback" />
          </div>
        </div>
        <div class="form-group">
          <asp:Label runat="server" AssociatedControlID="" CssClass="col-lg-2 control-label" ToolTip="" Style="white-space: nowrap"></asp:Label>
          <div class="col-lg-10">
            &nbsp;
          </div>
        </div>
      </div>
    </div>
  </div>

  <%--Survey Header--%>
  <div class="row">
    <div class="form-group">
      <div class="col-lg-0">&nbsp;</div>
      <div class="col-lg-12">
        <b>Survey Information:</b>
      </div>
    </div>
  </div>
  <br />

  <%--Survey Question 1--%>
  <div class="row">
    <div class="col-lg-12">
      <div class="form-horizontal">
        <div class="form-group">
          <p style="clear:both">
            <b><asp:Label runat="server" AssociatedControlID="LabelRating1" ID="lblRatingSatisfaction" CssClass="col-lg-2 control-label" ToolTip="Survey Question 1" Style="white-space: nowrap">1. How Satisfied Are You With ZakatNetwork? (1 - Very Dissatisfied, 2 - Dissatisfied, 3 - Neutral, 4 - Satisfied, 5 - Very Satisfied) </asp:Label></b>
          </p>          
        </div>
        <div class="form-group">
          <p>
            <ajaxToolkit:Rating
                ID="LabelRating1" 
                BehaviorID="RatingBehavior1"
                runat="server"                
                CurrentRating="0"                
                StarCssClass="ratingStar"
                WaitingStarCssClass="savedRatingStar"
                FilledStarCssClass="filledRatingStar"
                EmptyStarCssClass="emptyRatingStar">
            </ajaxToolkit:Rating>                
          </p>
        </div>
      </div>
    </div>
  </div>

  <%--Survey Question 2--%>
  <div class="row">
    <div class="col-lg-12">
      <div class="form-horizontal">
        <div class="form-group">
          <%--<p style="clear:both">--%>
            <b><asp:Label runat="server" AssociatedControlID="LabelRating2" ID="lblRatingReceommendation" CssClass="col-lg-2 control-label" ToolTip="Survey Question 2" Style="white-space: nowrap">2. How Likely Are You To Recommend ZakatNetwork To Others? (1 - Very Unlikely, 2 - Unlikely, 3 - Neutral, 4 - Likely, 5 - Very Likely) </asp:Label></b>
          <%--</p>  --%>        
        </div>
        <div class="form-group">
          <p>
            <ajaxToolkit:Rating
                ID="LabelRating2" 
                BehaviorID="RatingBehavior1"
                runat="server"                
                CurrentRating="0"                
                StarCssClass="ratingStar"
                WaitingStarCssClass="savedRatingStar"
                FilledStarCssClass="filledRatingStar"
                EmptyStarCssClass="emptyRatingStar">
            </ajaxToolkit:Rating>                
          </p>
        </div>
      </div>
    </div>
  </div>

  <%--Survey Question 3--%>
  <div class="row">
    <div class="col-lg-12">
      <div class="form-horizontal">
        <div class="form-group">
          <p style="clear:both">
            <b><asp:Label runat="server" AssociatedControlID="LabelRating3" ID="lblRatingExperience" CssClass="col-lg-2 control-label" ToolTip="Survey Question 4" Style="white-space: nowrap">3. Please Rate Your Overall Experience With ZakatNetwork? (1 - Very Poor, 2 - Poor, 3 - Neutral, 4 - Positive, 5 - Very Positive) </asp:Label></b>
          </p>          
        </div>
        <div class="form-group">
          <p>
            <ajaxToolkit:Rating
                ID="LabelRating3" 
                BehaviorID="RatingBehavior1"
                runat="server"                
                CurrentRating="0"                
                StarCssClass="ratingStar"
                WaitingStarCssClass="savedRatingStar"
                FilledStarCssClass="filledRatingStar"
                EmptyStarCssClass="emptyRatingStar">
            </ajaxToolkit:Rating>                
          </p>
        </div>
      </div>
    </div>
  </div>

  <%--Survey Question 4--%>
  <div class="row">
    <div class="col-lg-12">
      <div class="form-horizontal">
        <div class="form-group">
          <b><asp:Label runat="server" AssociatedControlID="chkMostLiked" ID="lblMostLiked" CssClass="col-lg-2 control-label" ToolTip="Survey Question 4" Style="white-space: nowrap">4. What Did You Like Most About ZakatNetwork? (Check all that apply)</asp:Label></b>
        </div>
        <div class="form-group">
          <table>
            <tr>
              <td style="width:5%">&nbsp;</td>
              <td style="width:95%">
                <asp:CheckBoxList ID="chkMostLiked" runat="server">
                  <asp:ListItem>&nbsp;&nbsp;User-Friendly Interface</asp:ListItem>
                  <asp:ListItem>&nbsp;&nbsp;Speed and Performance</asp:ListItem>
                  <asp:ListItem>&nbsp;&nbsp;Zakat Distribution Process</asp:ListItem>
                  <asp:ListItem>&nbsp;&nbsp;Information and Resources</asp:ListItem>
                  <asp:ListItem>&nbsp;&nbsp;Customer Support</asp:ListItem>
                </asp:CheckBoxList>
                <asp:CheckBox ID="chkOtherMostLiked" runat="server" Text="&nbsp;&nbsp;Other (Please specify):" AutoPostBack="True" />
              </td>
            </tr>
            <tr>
              <td style="width:5%">&nbsp;</td>
              <td style="width:95%">
                <div class="row">
                  <div class="col-lg-6">
                    <div class="form-vertical">
                      <div class="form-group">
                        <div class="col-lg-10">
                          <asp:TextBox runat="server" ID="txtOtherMostLiked" CssClass="form-control" ToolTip="Other Most Liked" MaxLength="50" TabIndex="14" Width="450px" BackColor="#f5f5f5" ReadOnly="true"  />
                          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOtherMostLiked" CssClass="text-danger" ErrorMessage="The other most liked is required when Other is checked." Display="Static" ValidationGroup="Feedback" />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>

  <%--Survey Question 5--%>
  <div class="row">
    <div class="col-lg-12">
      <div class="form-horizontal">
        <div class="form-group">
          <b><asp:Label runat="server" AssociatedControlID="chkMostToImprove" ID="lblMostToImprove" CssClass="col-lg-2 control-label" ToolTip="Survey Question 4" Style="white-space: nowrap">5. What Aspects Of ZakatNetwork Do You Think Can Be Improved? (Check all that apply)</asp:Label></b>
        </div>
        <div class="form-group">
          <table>
            <tr>
              <td style="width:5%">&nbsp;</td>
              <td style="width:95%">
                <asp:CheckBoxList ID="chkMostToImprove" runat="server">
                  <asp:ListItem>&nbsp;&nbsp;User Interface</asp:ListItem>
                  <asp:ListItem>&nbsp;&nbsp;Account Management</asp:ListItem>
                  <asp:ListItem>&nbsp;&nbsp;Fund Distribution Process</asp:ListItem>
                  <asp:ListItem>&nbsp;&nbsp;Communication</asp:ListItem>
                  <asp:ListItem>&nbsp;&nbsp;Customer Support</asp:ListItem>
                </asp:CheckBoxList>
                <asp:CheckBox ID="chkOtherMostToImprove" runat="server" Text="&nbsp;&nbsp;Other (Please specify):" AutoPostBack="True" />
              </td>
            </tr>
            <tr>
              <td style="width:5%">&nbsp;</td>
              <td style="width:95%">
                <div class="row">
                  <div class="col-lg-6">
                    <div class="form-vertical">
                      <div class="form-group">
                        <div class="col-lg-10">
                          <asp:TextBox runat="server" ID="txtOtherMostToImprove" CssClass="form-control" ToolTip="Other Most Liked" MaxLength="50" TabIndex="14" Width="450px" BackColor="#f5f5f5" ReadOnly="true"  />
                          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOtherMostToImprove" CssClass="text-danger" ErrorMessage="The other most to improve is required when Other is checked." Display="Static" ValidationGroup="Feedback" />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>

  <%--Survey Question 6--%>
  <div class="row">
    <div class="col-lg-12">
      <div class="form-horizontal">
        <div class="form-group">
          <b><asp:Label runat="server" AssociatedControlID="txtCommentsForImprovement" ID="lblCommentsForImprovement" CssClass="col-lg-2 control-label" ToolTip="Survey Question 6" Style="white-space: nowrap">6. Please Provide More Details Or Suggestions For Improvement:</asp:Label></b>
        </div>
        <div class="form-group">
          <table>
            <tr>
              <td style="width:5%">&nbsp;</td>
              <td style="width:95%">
                <div class="row">
                  <div class="col-lg-6">
                    <div class="form-vertical">
                      <div class="form-group">
                        <div class="col-lg-10">
                          <asp:TextBox runat="server" ID="txtCommentsForImprovement" CssClass="form-control" ToolTip="Comments For Improvement" MaxLength="1000" TabIndex="14" Width="450px"  TextMode="MultiLine" Rows="10" />
                          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOtherMostToImprove" CssClass="text-danger" ErrorMessage="The other most to improve is required when Other is checked." Display="Static" ValidationGroup="Feedback" />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>

  <%--Survey Question 7--%>
  <div class="row">
    <div class="col-lg-12">
      <div class="form-horizontal">
        <div class="form-group">
          <b><asp:Label runat="server" AssociatedControlID="txtCommentsForImprovement" ID="lbl" CssClass="col-lg-2 control-label" ToolTip="Survey Question 7" Style="white-space: nowrap">7. Do You Have Any Additional Comments Or Feedback For Us?</asp:Label></b>
        </div>
        <div class="form-group">
          <table>
            <tr>
              <td style="width:5%">&nbsp;</td>
              <td style="width:95%">
                <div class="row">
                  <div class="col-lg-6">
                    <div class="form-vertical">
                      <div class="form-group">
                        <div class="col-lg-10">
                          <asp:TextBox runat="server" ID="txtAdditionalComments" CssClass="form-control" ToolTip="Additional Comments" MaxLength="1000" TabIndex="14" Width="450px"  TextMode="MultiLine" Rows="10" />
                          <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOtherMostToImprove" CssClass="text-danger" ErrorMessage="The other most to improve is required when Other is checked." Display="Static" ValidationGroup="Feedback" />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-lg-12">
      <div class="form-horizontal">
        <div class="form-group">
          <table>
            <tr>
              <td style="width:5%">&nbsp;</td>
              <td style="width:95%">
                &nbsp;&nbsp;&nbsp;<asp:Button ID="btnSubmit" runat="server" Text="Submit Feedback" CssClass="btn btn-default" TabIndex="100" Width="150" ValidationGroup="Feedback" />
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>

  <br />
  <br />
  <br />
  <br />
  <br />
</asp:Content>
