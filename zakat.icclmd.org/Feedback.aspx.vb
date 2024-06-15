Imports System.Drawing
Imports System.Globalization
Imports System.Net.NetworkInformation
Imports AjaxControlToolkit

Public Class Feedback
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      If Not IsPostBack Then
        txtFirstName.Text = ""
        txtLastName.Text = ""
        txtEmail.Text = ""
        txtPhone.Text = ""
        valOtherMostLiked.IsValid = True
        valOtherMostLikeToImprove.IsValid = True
      End If
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub chkOtherMostLiked_CheckedChanged(sender As Object, e As EventArgs) Handles chkOtherMostLiked.CheckedChanged
    Try
      If sender.checked Then
        txtOtherMostLiked.BackColor = Drawing.Color.White
        txtOtherMostLiked.ReadOnly = False
        If chkOtherMostLiked.Checked And txtOtherMostLiked.Text = "" Then valOtherMostLiked.IsValid = False
      Else
        txtOtherMostLiked.Text = ""
        txtOtherMostLiked.BackColor = ColorTranslator.FromHtml("#f5f5f5")
        txtOtherMostLiked.ReadOnly = True
      End If
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub chkOtherMostToImprove_CheckedChanged(sender As Object, e As EventArgs) Handles chkOtherMostToImprove.CheckedChanged
    Try
      If sender.checked Then
        txtOtherMostToImprove.BackColor = Drawing.Color.White
        txtOtherMostToImprove.ReadOnly = False
        If chkOtherMostToImprove.Checked And txtOtherMostToImprove.Text = "" Then valOtherMostLikeToImprove.IsValid = False
      Else
        txtOtherMostToImprove.Text = ""
        txtOtherMostToImprove.BackColor = ColorTranslator.FromHtml("#f5f5f5")
        txtOtherMostToImprove.ReadOnly = True
      End If
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
    Try
      Using oDB As New zakatEntities
        Dim oSurvey As New SURVEY
        Dim vPhone As String = Base.GetFormattedPhone(txtPhone.Text, Base.enumFormatPhone.Strip)

        'check custom validations:
        If chkOtherMostLiked.Checked And txtOtherMostLiked.Text = "" Then valOtherMostLiked.IsValid = False
        If chkOtherMostToImprove.Checked And txtOtherMostToImprove.Text = "" Then valOtherMostLikeToImprove.IsValid = False

        'update information about the member - save to db
        With oSurvey
          .email = txtEmail.Text
          .firstName = txtFirstName.Text
          .lastName = txtLastName.Text
          .phone = vPhone
          .isFollowUp = IIf(chkFollowUp.Checked, True, False)
          .question1Stars = drpRatingSatisfaction.SelectedValue
          .question2Stars = drpRatingRecommendation.SelectedValue
          .question3Stars = drpRatingExperience.SelectedValue
          'iterate thru question 4 checkbox list
          Dim i = 0
          For Each item In chkMostLiked.Items
            Select Case i
              Case 0
                .question4Option1 = IIf(item.Selected, True, False)
              Case 1
                .question4Option2 = IIf(item.Selected, True, False)
              Case 2
                .question4Option3 = IIf(item.Selected, True, False)
              Case 3
                .question4Option4 = IIf(item.Selected, True, False)
              Case 4
                .question4Option5 = IIf(item.Selected, True, False)
            End Select
            i = i + 1
          Next
          .question4Option6 = IIf(chkOtherMostLiked.Checked, True, False)
          .question4Option6Value = IIf(txtOtherMostLiked.Text <> "", txtOtherMostLiked.Text, "")
          'iterate thru question 5 checkbox list
          i = 0
          For Each item In chkMostToImprove.Items
            Select Case i
              Case 0
                .question5Option1 = IIf(item.Selected, True, False)
              Case 1
                .question5Option2 = IIf(item.Selected, True, False)
              Case 2
                .question5Option3 = IIf(item.Selected, True, False)
              Case 3
                .question5Option4 = IIf(item.Selected, True, False)
              Case 4
                .question5Option5 = IIf(item.Selected, True, False)
            End Select
            i = i + 1
          Next
          .question5Option6 = IIf(chkOtherMostToImprove.Checked, True, False)
          .question5Option6Value = IIf(txtOtherMostToImprove.Text <> "", txtOtherMostToImprove.Text, "")
          .question6 = txtSuggestionsForImprovement.Text
          .question7 = txtAdditionalComments.Text
          .createdOn = Date.Now
        End With

        ' add the survey record
        oDB.SURVEY.Add(oSurvey)
        oDB.SaveChanges()
      End Using

      If chkFollowUp.Checked Then
        'send email to the zakat admin regarding the survey
        'Base.SendEmail()
      End If

      Response.Redirect("\")
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub txtOtherMostToImprove_TextChanged(sender As Object, e As EventArgs) Handles txtOtherMostToImprove.TextChanged
    If sender.Text <> "" Then valOtherMostLikeToImprove.IsValid = True
  End Sub

  Private Sub txtOtherMostLiked_TextChanged(sender As Object, e As EventArgs) Handles txtOtherMostLiked.TextChanged
    If sender.Text <> "" Then valOtherMostLiked.IsValid = True
  End Sub

  Private Sub btnConfirm_Click(sender As Object, e As EventArgs) Handles btnConfirm.Click
    Try
      pnlSurvey.Visible = False
      pnlConfirmation.Visible = True
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click, btnX.Click
    Try
      pnlSurvey.Visible = True
      pnlConfirmation.Visible = False
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub
End Class