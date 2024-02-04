<%@ Page Title="Feedback" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Feedback.aspx.vb" Inherits="zakat.icclmd.org.Feedback" %>

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
          var LabelRatingSatisfaction = $get('<%= LabelRatingSatisfaction.ClientID %>');
          LabelRatingSatisfaction.innerHTML = e.get_CallbackResult();
        });
    }
  </script>

  <h3>Feedback Survey</h3>
  <div class="row">
      <div class="col-lg-12">
          <div class="well well-sm">
              <h5>
                <b>Thanks for using ZakatNetwork! We value your feedback and would appreciate it if you take a moment to share your thoughts on your experience with our platform.</b>
              </h5>
          </div>
      </div>
  </div>

  <ol>
    <li>
      Personal Information (Optional):
         - Name: [Text Field]
         - Email Address: [Email Field]
           Phone Number: 
    </li> 
    <li>
      <p style="clear:both">
        <asp:Label ID="LabelRatingSatisfaction" runat="server">How satisfied are you with ZakatNetwork?</asp:Label>
      </p>
      <p>
        <ajaxToolkit:Rating
            ID="LabelRating1" 
            BehaviorID="RatingBehavior1"
            runat="server"                
            CurrentRating="0"                
            StarCssClass="ratingStar"
            WaitingStarCssClass="savedRatingStar"
            FilledStarCssClass="filledRatingStar"
            EmptyStarCssClass="emptyRatingStar" AutoPostBack="True">
        </ajaxToolkit:Rating>                
      </p>        
    </li>     
  </ol>
  <br />
  <br />

  <%--<ajaxToolkit:Rating ID="Rating" runat="server"
    CurrentRating="2"
    MaxRating="5"
    StarCssClass="ratingStar"
    WaitingStarCssClass="savedRatingStar"
    FilledStarCssClass="filledRatingStar"
    EmptyStarCssClass="emptyRatingStar"  /> --%>

<br />
<br />

3. What did you like most about ZakatNetwork? (Check all that apply)
   - User-Friendly Interface
   - Speed and Performance
   - Zakat Distribution Process
   - Information and Resources
   - Customer Support
   - Other (Please specify): [Text Field]

4. What aspects of ZakatNetwork do you think can be improved? (Check all that apply)
   - User Interface
   - Account Management
   - Fund distribution Process
   - Communication
   - Features and Functionality
   - Other (Please specify): [Text Field]

5. Please provide more details or suggestions for improvement: 
   - [Text Area]

6. How likely are you to recommend ZakatNetwork to others?
   - Very Likely
   - Likely
   - Neutral
   - Unlikely
   - Very Unlikely

7. Do you have any additional comments or feedback for us?
   - [Text Area]

8. Would you like us to follow up with you regarding your feedback?
   - Yes, please contact me.
   - No, I don't require follow-up.

9. Are you interested in receiving updates and news from ZakatNetwork?
   - Yes, sign me up for updates.
   - No, I'm not interested.

10. Please rate your overall experience with ZakatNetwork (1-5 stars):
   - [Rating Scale]

11. Submit Feedback
</asp:Content>
