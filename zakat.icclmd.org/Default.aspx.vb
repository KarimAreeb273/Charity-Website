Public Class _Default
  Inherits Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
    Dim vUserId As Int32 = Session("sUserId")
    If vUserId = 0 Then
      pnlAnonymous.Visible = True
      pnlLoggedIn.Visible = False
    Else
      pnlAnonymous.Visible = False
      pnlLoggedIn.Visible = True
    End If
  End Sub

  Private Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
    Using oDB As New zakatEntities()
      valBadLogin.IsValid = True
      'validate that its not already registered by a user
      If (From USER In oDB.USER Where USER.email = txtEmail.Text And USER.password = txtPassword.Text).Any Then
        'Dim vSessionID As Int64 = Session("sSessionID")
        Dim oUser As USER = (From USER In oDB.USER Where USER.email = txtEmail.Text And USER.password = txtPassword.Text).First

        'successful login so set user information
        'Session("sIsAdmin") = oUser.isAdmin
        Session("sUserId") = oUser.userId
        Session("sMemberId") = oUser.userId
        'Session("sUserFirstName") = oUser.firstName

        'authenticate the user
        ''oUser.isAuthenticated = True
        oDB.SaveChanges()

        'authenticate the user's dependencies that use the head's email
        ''Dim oDependent_List As List(Of USER) = (From USER In oDB.USER Where USER.householdHeadId = oUser.userId And USER.isUsingHeadEmail).ToList
        ''For Each item In oDependent_List
        ''  item.isAuthenticated = True
        ''Next
        ''oDB.SaveChanges()

        ''If oUser.isAdmin = True Then
        ''  'admins get redirected to members page
        ''  Response.Redirect("members")
        ''Else
        ''  'if user is not an admin redirect to profile
        ''  Response.Redirect("profile")
        ''End If
      Else
        valBadLogin.IsValid = False
      End If
    End Using
  End Sub

  Private Sub lnkProfile_Click(sender As Object, e As EventArgs) Handles lnkProfile.Click
    Session("sMemberId") = Session("sUserId")
    Response.Redirect("profile")
  End Sub

End Class