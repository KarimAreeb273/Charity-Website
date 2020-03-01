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
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
    Try
      Using oDB As New zakatEntities()
        valBadLogin.IsValid = True
        'validate that its a valid username/password combination
        If (From USER In oDB.USER Where USER.email = txtEmail.Text And USER.password = txtPassword.Text).Any Then
          Dim vSessionID As Int32 = Session("sUserID")
          Dim oUser As USER = (From USER In oDB.USER Where USER.email = txtEmail.Text And USER.password = txtPassword.Text).First

          'successful login so set user information
          Session("sUserId") = oUser.userId
          Session("sUserFirstName") = oUser.firstName

          'get roles from user roles and set session variables
          Session("sIsApplicant") = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = oUser.userId And USER_ROLE.ROLE.name = "Applicant").Any
          Session("sIsAdministrator") = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = oUser.userId And USER_ROLE.ROLE.name = "Administrator").Any
          Session("sIsApprover") = (From USER_ROLE In oDB.USER_ROLE Where USER_ROLE.userId = oUser.userId And (USER_ROLE.ROLE.name = "Validator" OrElse USER_ROLE.ROLE.name = "Investigator" OrElse USER_ROLE.ROLE.name = "Qualifier")).Any

          Response.Redirect("/")
        Else
          valBadLogin.IsValid = False
        End If
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

End Class