<%@ Page Title="Survey" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Feedback.aspx.vb" Inherits="zakat.icclmd.org.Feedback" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  <br />
  <br />
  <br />

  <h3>Zakat Network Survey</h3>

  <div class="row">
    <div class="col-lg-12">
      <div class="well well-sm">
        <h5>
          <b>Thanks for using Zakat Network! We value your feedback and would appreciate it if you take a moment to share thoughts on your experience with our platform.</b>
        </h5>
      </div>
    </div>
  </div>

  <asp:Panel ID="pnlSurvey" runat="server" Visible="true">
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
              <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" CssClass="text-danger" ErrorMessage="The first name is required." Display="Static" />--%>
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtLastName" CssClass="col-lg-2 control-label" ToolTip="Last Name" Style="white-space: nowrap">Last Name:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control" ToolTip="Last Name" MaxLength="30" TabIndex="2" />
              <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" CssClass="text-danger" Display="Static" ErrorMessage="The last name is required." />--%>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-6">
        <div class="form-horizontal">
          <div class="form-group">
          <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-lg-2 control-label" ToolTip="Email/Username" Style="white-space: nowrap">Email:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="email@domain.com" AutoCompleteType="Email" ToolTip="Email/Username" MaxLength="60" TabIndex="3" />
              <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="A valid email/username is required." ControlToValidate="txtEmail" ValidationExpression="^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$" CssClass="text-danger" Display="Dynamic"></asp:RegularExpressionValidator>
              <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger" ErrorMessage="The email/username is required." Display="Static" />--%>
            </div>
          </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtPhone" CssClass="col-lg-2 control-label" ToolTip="Phone #" Style="white-space: nowrap">Phone #:</asp:Label>
            <div class="col-lg-10">
              <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" ToolTip="Phone #" MaxLength="14" placeholder="555-555-1234" TabIndex="4" />
              <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ValidationExpression="^(1\s?)?((\([0-9]{3}\))|[0-9]{3})[\s\-]?[\0-9]{3}[\s\-]?[0-9]{4}$" ErrorMessage="Please enter a valid phone number" Display="Dynamic"></asp:RegularExpressionValidator>
              <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone" CssClass="text-danger" ErrorMessage="The phone number is required." Display="Static" />--%>
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
              <asp:CheckBox ID="chkFollowUp" runat="server" Text="&nbsp;&nbsp;I Require A Follow Up Regarding My Feedback" TabIndex="5" />
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
            <asp:Label runat="server" AssociatedControlID="drpRatingSatisfaction" ID="lblRatingSatisfaction" CssClass="col-lg-2 control-label" ToolTip="Survey Question 1" Style="white-space: nowrap">1. How Satisfied Are You With Zakat Network? (1 - Very Dissatisfied, 2 - Dissatisfied, 3 - Neutral, 4 - Satisfied, 5 - Very Satisfied) </asp:Label>
            <div class="row">
              <div class="col-lg-12">
                <table>
                  <tr>
                    <td style="width:5%">&nbsp;</td>
                    <td style="width:95%">
                      <asp:DropDownList ID="drpRatingSatisfaction" runat="server" ToolTip="Rate Satisfaction" CssClass="form-control" TabIndex="6" ValidationGroup="Feedback" Width="450px">
                        <asp:ListItem Text="(Please Rate Satisfaction)" Value="0" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="1 Stars - *" Value="1"></asp:ListItem>
                        <asp:ListItem Text="2 Stars - * *" Value="2"></asp:ListItem>
                        <asp:ListItem Text="3 Stars - * * *" Value="3"></asp:ListItem>
                        <asp:ListItem Text="4 Stars - * * * *" Value="4"></asp:ListItem>
                        <asp:ListItem Text="5 Stars - * * * * *" Value="5"></asp:ListItem>
                      </asp:DropDownList>
                      <asp:RequiredFieldValidator runat="server" ID="valRatingSatisfaction" ControlToValidate="drpRatingSatisfaction" CssClass="text-danger" ErrorMessage="Satisfaction rating is required." InitialValue="0" ValidationGroup="Feedback" />
                    </td>
                  </tr>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <%--Survey Question 2--%>
    <div class="row">
      <div class="col-lg-12">
        <div class="form-horizontal">
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="drpRatingRecommendation" ID="lblRatingRecommendation" CssClass="col-lg-2 control-label" ToolTip="Survey Question 2" Style="white-space: nowrap">2. How Likely Are You To Recommend Zakat Network To Others? (1 - Very Unlikely, 2 - Unlikely, 3 - Neutral, 4 - Likely, 5 - Very Likely)</asp:Label>            
            <div class="row">
            <div class="col-lg-12">
              <table>
                <tr>
                  <td style="width:5%">&nbsp;</td>
                  <td style="width:95%">
                    <asp:DropDownList ID="drpRatingRecommendation" runat="server" ToolTip="Rate Recommendation" CssClass="form-control" TabIndex="7" ValidationGroup="Feedback" Width="450px">
                      <asp:ListItem Text="(Please Rate Recommendation)" Value="0" Selected="True"></asp:ListItem>
                      <asp:ListItem Text="1 Stars - *" Value="1"></asp:ListItem>
                      <asp:ListItem Text="2 Stars - * *" Value="2"></asp:ListItem>
                      <asp:ListItem Text="3 Stars - * * *" Value="3"></asp:ListItem>
                      <asp:ListItem Text="4 Stars - * * * *" Value="4"></asp:ListItem>
                      <asp:ListItem Text="5 Stars - * * * * *" Value="5"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator runat="server" ID="valRatingRecommendation" ControlToValidate="drpRatingRecommendation" CssClass="text-danger" ErrorMessage="Recommendation rating is required." InitialValue="0" ValidationGroup="Feedback" />
                  </td>
                </tr>
              </table>
            </div>
          </div>
          </div>
        </div>
      </div>
    </div>

    <%--Survey Question 3--%>
    <div class="row">
      <div class="col-lg-12">
        <div class="form-horizontal">
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="drpRatingExperience" ID="lblRatingExperience" CssClass="col-lg-2 control-label" ToolTip="Survey Question 3" Style="white-space: nowrap">3. Please Rate Your Overall Experience With Zakat Network? (1 - Very Poor, 2 - Poor, 3 - Neutral, 4 - Positive, 5 - Very Positive)</asp:Label>            
            <div class="row">
            <div class="col-lg-12">
              <table>
                <tr>
                  <td style="width:5%">&nbsp;</td>
                  <td style="width:95%">
                    <asp:DropDownList ID="drpRatingExperience" runat="server" ToolTip="Rate Experience" CssClass="form-control" TabIndex="8" ValidationGroup="Feedback" Width="450px">
                      <asp:ListItem Text="(Please Rate Experience)" Value="0" Selected="True"></asp:ListItem>
                      <asp:ListItem Text="1 Stars - *" Value="1"></asp:ListItem>
                      <asp:ListItem Text="2 Stars - * *" Value="2"></asp:ListItem>
                      <asp:ListItem Text="3 Stars - * * *" Value="3"></asp:ListItem>
                      <asp:ListItem Text="4 Stars - * * * *" Value="4"></asp:ListItem>
                      <asp:ListItem Text="5 Stars - * * * * *" Value="5"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator runat="server" ID="valRatingExperience" ControlToValidate="drpRatingExperience" CssClass="text-danger" ErrorMessage="Experience rating is required." InitialValue="0" ValidationGroup="Feedback" />
                  </td>
                </tr>
              </table>
            </div>
          </div>
          </div>
        </div>
      </div>
    </div>

    <%--Survey Question 4--%>
    <div class="row">
      <div class="col-lg-12">
        <div class="form-horizontal">
          <div class="form-group">
            <b><asp:Label runat="server" AssociatedControlID="chkMostLiked" ID="lblMostLiked" CssClass="col-lg-2 control-label" ToolTip="Survey Question 4" Style="white-space: nowrap">4. What Did You Like Most About Zakat Network? (Check all that apply)</asp:Label></b>
          </div>
          <div class="form-group">
            <table>
              <tr>
                <td style="width:5%">&nbsp;</td>
                <td style="width:95%">
                  <asp:CheckBoxList ID="chkMostLiked" runat="server" TabIndex="9">
                    <asp:ListItem>&nbsp;&nbsp;User-Friendly Interface</asp:ListItem>
                    <asp:ListItem>&nbsp;&nbsp;Speed and Performance</asp:ListItem>
                    <asp:ListItem>&nbsp;&nbsp;Zakat Distribution Process</asp:ListItem>
                    <asp:ListItem>&nbsp;&nbsp;Information and Resources</asp:ListItem>
                    <asp:ListItem>&nbsp;&nbsp;Customer Support</asp:ListItem>
                  </asp:CheckBoxList>
                  <asp:CheckBox ID="chkOtherMostLiked" runat="server" Text="&nbsp;&nbsp;Other (Please specify):" AutoPostBack="True" TabIndex="10" />
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
                            <asp:TextBox runat="server" ID="txtOtherMostLiked" CssClass="form-control" ToolTip="Other Most Liked" MaxLength="50" TabIndex="11" Width="450px" BackColor="#f5f5f5" ReadOnly="true" AutoCompleteType="Disabled" ValidationGroup="Feedback" AutoPostBack="True" />
                            <asp:CustomValidator ID="valOtherMostLiked" runat="server" CssClass="text-danger" ErrorMessage="An 'Other Most Liked Value' is required when Other is checked." Display="Static" ValidationGroup="Feedback" Style="white-space: nowrap"></asp:CustomValidator>
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
            <b><asp:Label runat="server" AssociatedControlID="chkMostToImprove" ID="lblMostToImprove" CssClass="col-lg-2 control-label" ToolTip="Survey Question 4" Style="white-space: nowrap">5. What Aspects Of Zakat Network Do You Think Can Be Improved? (Check all that apply)</asp:Label></b>
          </div>
          <div class="form-group">
            <table>
              <tr>
                <td style="width:5%">&nbsp;</td>
                <td style="width:95%">
                  <asp:CheckBoxList ID="chkMostToImprove" runat="server" TabIndex="12">
                    <asp:ListItem>&nbsp;&nbsp;User Interface</asp:ListItem>
                    <asp:ListItem>&nbsp;&nbsp;Account Management</asp:ListItem>
                    <asp:ListItem>&nbsp;&nbsp;Fund Distribution Process</asp:ListItem>
                    <asp:ListItem>&nbsp;&nbsp;Communication</asp:ListItem>
                    <asp:ListItem>&nbsp;&nbsp;Customer Support</asp:ListItem>
                  </asp:CheckBoxList>
                  <asp:CheckBox ID="chkOtherMostToImprove" runat="server" Text="&nbsp;&nbsp;Other (Please specify):" AutoPostBack="True" TabIndex="13" />
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
                            <asp:TextBox runat="server" ID="txtOtherMostToImprove" CssClass="form-control" ToolTip="Other Most Liked" MaxLength="50" TabIndex="14" Width="450px" BackColor="#f5f5f5" ReadOnly="true" AutoCompleteType="Disabled" ValidationGroup="Feedback" AutoPostBack="True" />
                            <asp:CustomValidator ID="valOtherMostLikeToImprove" runat="server" CssClass="text-danger" ErrorMessage="An 'Other Liked To Improve Value' is required when Other is checked." Display="Static" ValidationGroup="Feedback" Style="white-space: nowrap"></asp:CustomValidator>
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
            <b><asp:Label runat="server" AssociatedControlID="txtSuggestionsForImprovement" ID="lblSuggestionsForImprovement" CssClass="col-lg-2 control-label" ToolTip="Survey Question 6" Style="white-space: nowrap">6. Please Provide More Details Or Suggestions For Improvement (or N/A for none):</asp:Label></b>
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
                            <asp:TextBox runat="server" ID="txtSuggestionsForImprovement" CssClass="form-control" ToolTip="Suggestions For Improvement" MaxLength="1000" TabIndex="15" Width="450px"  TextMode="MultiLine" Rows="6" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSuggestionsForImprovement" CssClass="text-danger" ErrorMessage="Detailed suggestions for improvement are required." Display="Static" ValidationGroup="Feedback" Style="white-space: nowrap" />
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
            <b><asp:Label runat="server" AssociatedControlID="txtAdditionalComments" ID="lbl" CssClass="col-lg-2 control-label" ToolTip="Survey Question 7" Style="white-space: nowrap">7. Do You Have Any Additional Comments Or Feedback For Us (or N/A for none)?</asp:Label></b>
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
                            <asp:TextBox runat="server" ID="txtAdditionalComments" CssClass="form-control" ToolTip="Additional Comments" MaxLength="1000" TabIndex="16" Width="450px"  TextMode="MultiLine" Rows="6" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAdditionalComments" CssClass="text-danger" ErrorMessage="Additional comments or feedback is required." Display="Static" ValidationGroup="Feedback" Style="white-space: nowrap" />
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

    <%--Submit Button--%>
    <div class="row">
        <div class="col-lg-12">
          <div class="form-horizontal">
            <div class="form-group">
              <table>
                <tr>
                  <td style="width:5%">&nbsp;</td>
                  <td style="width:95%">
                    &nbsp;&nbsp;&nbsp;<asp:Button ID="btnConfirm" runat="server" Text="Submit Survey" CssClass="btn btn-default" Width="150" ValidationGroup="Feedback" TabIndex="17" />
                  </td>
                </tr>
              </table>
            </div>
          </div>
        </div>
      </div>

    <%--Survey Question 8--%>
    <div style="opacity:0; position:relative; height:0; width: 0; display: hidden">
      <ajaxToolkit:Rating
        ID="LabelRating8" 
        BehaviorID="RatingBehavior1"
        runat="server"                
        CurrentRating="0"                
        StarCssClass="ratingStar"
        WaitingStarCssClass="savedRatingStar"
        FilledStarCssClass="filledRatingStar"
        EmptyStarCssClass="emptyRatingStar">
      </ajaxToolkit:Rating>   
    </div>
  </asp:Panel>

  <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
    TargetControlId="btnConfirm"
    PopupControlID="pnlConfirmation"
    BackgroundCssClass="modalBackground"
    DropShadow="True"
    CancelControlID="btnNo"
    OkControlID="btnYes"></ajaxToolkit:ModalPopupExtender>
  <asp:Panel ID="pnlConfirmation" runat="server" Visible="false">
    <br /><br />
    <table style="width: 100%">
      <tr style="font-size: 30px">
        <td style="width: 15%">
          &nbsp;
        </td>
        <td style="width: 70%;">
          <div class="modal-header" style="background-color: black; color:white;">
            <asp:Button ID="btnX" runat="server" Text="&times;" CssClass="close" data-dismiss="modal" />
            <h4 class="modal-title">&nbsp;Zakat Network Survey</h4>
          </div>
        </td>
        <td style="width: 15%">
          &nbsp;
        </td>
      </tr>
      <tr style="font-size: 16px">
        <td style="width: 15%">
          &nbsp;
        </td>
        <td style="width: 70%;">
          <div class="modal-body">
            <p><b>Please confirm  you want to submit your survey data based on the current feedback provided?</b></p>
          </div>
        </td>
        <td style="width: 15%">
          &nbsp;
        </td>
      </tr>
      <tr style="font-size: 16px">
        <td style="width: 15%">
          &nbsp;
        </td>
        <td style="width: 70%;">
          <div class="modal-footer">
            <asp:Button ID="btnCancel" runat="server" Text="No" CssClass="btn btn-danger" style="width: 100px" />
            <asp:Button ID="btnSubmit" runat="server" Text="Yes" CssClass="btn btn-primary" style="width: 100px" />
          </div>
        </td>
        <td style="width: 15%">
          &nbsp;
        </td>
      </tr>
    </table>

    <%--Modal Popup Confirmation--%>
    <div class="modal fade" id="myModal" role="dialog">
      <div class="modal-dialog">
    
        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header" style="background-color: black; color:white;">
            <button type="button" class="close" data-dismiss="modal" style="color:white;">&times;</button>
            <h4 class="modal-title">Zakat Network Survey</h4>
          </div>
          <div class="modal-body">
            <p><b>Please confirm you want to submit your survey data based on the current feedback provided?</b></p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal" style="width: 100px">No</button>
            <%--<asp:Button ID="btnSubmit" runat="server" Text="Yes" CssClass="btn btn-primary" style="width: 100px" />--%>
            <%--<asp:Button runat="server" ID="btnSubmit" class="btn btn-primary" style="width: 100px">Yes</asp:Button>--%>
          </div>
        </div>
      
      </div>
    </div>
  </asp:Panel>
</asp:Content>
