Public Class _Default
  Inherits Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
    Try
      If Not IsPostBack Then
        Dim vUserID As Int32 = Session("sUserId")
        Dim vIsAnonymous As Boolean = Session("sIsAnonymous")
        Dim vIsApplicant As Boolean = Session("sIsApplicant")
        Dim vIsAdministrator As Boolean = Session("sIsAdministrator")
        Dim vIsApprover As Boolean = Session("sIsApprover")

        'show panel Anonymous vs. User vs. Admin vs. Approver
        If vUserID Then
          'LoggedIn
          If vIsApplicant Then
            pnlApplicant.Visible = True
            pnlAdministrator.Visible = False
            pnlApprover.Visible = False
            pnlAnonymous.Visible = False
          ElseIf vIsAdministrator Then
            pnlApplicant.Visible = False
            pnlAdministrator.Visible = True
            pnlApprover.Visible = False
            pnlAnonymous.Visible = False
          ElseIf vIsApprover Then
            pnlApplicant.Visible = False
            pnlAdministrator.Visible = False
            pnlApprover.Visible = True
            pnlAnonymous.Visible = False
          End If
        Else
          'Anonymous
          pnlApplicant.Visible = False
          pnlAdministrator.Visible = False
          pnlApprover.Visible = False
          pnlAnonymous.Visible = True
        End If
      End If
      lblAverageDuration.Text = getAverageDuration()

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Function getAverageDuration() As String
    Try
      Using oDB As New zakatEntities()
        If (From APPLICATION In oDB.APPLICATION Where APPLICATION.submittedOn IsNot Nothing And APPLICATION.qualified2On IsNot Nothing).Any Then
          Dim vTotalDuration As Decimal
          Dim vTotalAverageDuration As Decimal
          Dim oApplication As List(Of APPLICATION) = (From APPLICATION In oDB.APPLICATION Where APPLICATION.submittedOn IsNot Nothing And APPLICATION.qualified2On IsNot Nothing).ToList()
          For Each item In oApplication
            vTotalDuration = vTotalDuration + DateDiff(DateInterval.Day, CDate(item.submittedOn), CDate(item.qualified2On))
          Next
          If oApplication.Count = 0 Then
            Return "N/A"
          Else
            'calculate total average duration as the all applications time between when submitted and the second qualified divided by the count of total applications
            vTotalAverageDuration = vTotalDuration / oApplication.Count
            Return FormatNumber(vTotalAverageDuration, 1).ToString + " Day(s)"
          End If
        End If
        Return "N/A"
      End Using
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Function

  Private Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
    Try
      Using oDB As New zakatEntities()
        valBadLogin.IsValid = True
        Dim vUsername As String = txtEmail.Text
        Dim vPassword As String = txtPassword.Text
        Dim vPasswordEncrypted As String = Base.encryptString(txtPassword.Text)
        'validate that its a valid username/password combination
        'If (From USER In oDB.USER Where USER.email = vUsername And USER.password = vPassword).Any Then
        If (From USER In oDB.USER Where USER.email = vUsername AndAlso USER.passwordEncrypted = vPasswordEncrypted).Any Then
          'Dim oUser As USER = (From USER In oDB.USER Where USER.email = vUsername And USER.password = vPassword).First
          Dim oUser As USER = (From USER In oDB.USER Where USER.email = vUsername AndAlso USER.passwordEncrypted = vPasswordEncrypted).First
          Dim vSessionID As Int32 = Session("sUserID")

          'successful login so set user information
          Session("sUserId") = oUser.userId
          Session("sUserFirstName") = oUser.firstName

          'get roles from user roles and set session variables
          Session("sIsApplicant") = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = oUser.userId And USER_ROLE.ROLE.name = "Applicant").Any
          Session("sIsAdministrator") = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = oUser.userId And USER_ROLE.ROLE.name = "Administrator").Any
          Session("sIsApprover") = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = oUser.userId And (USER_ROLE.ROLE.name = "Validator" OrElse USER_ROLE.ROLE.name = "Investigator" OrElse USER_ROLE.ROLE.name = "Qualifier" OrElse USER_ROLE.ROLE.name = "Financier")).Any

          Session("hasSearched") = False
          Response.Redirect("/", False)
        Else
          Session("hasSearched") = False
          valBadLogin.IsValid = False
        End If
      End Using
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

End Class