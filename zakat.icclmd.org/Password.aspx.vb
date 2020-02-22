Public Class Password
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      Dim vUserId As Int32 = Session("sUserId")
      Dim vEmail As String = LCase(Request.QueryString("e"))
      If vUserId = 0 And vEmail = "" Then
        'redirect to home
        Response.Redirect("default")
      End If

      If vUserId <> 0 Then
        'change paassword using user id
        Using oDB As New zakatEntities
          Dim oUser As USER = (From USER In oDB.USER Where USER.userId = vUserId).First
          txtEmail.Text = oUser.email
        End Using
      ElseIf vEmail <> "" Then
        'change password using email
        Using oDB As New zakatEntities
          'ensure email is in the system or redirect home
          If (From USER In oDB.USER Where LCase(USER.email) = vEmail).Any Then
            Dim oUser As USER = (From USER In oDB.USER Where LCase(USER.email) = vEmail).First
            txtEmail.Text = oUser.email
          Else
            'redirect to home
            Response.Redirect("default")
          End If
        End Using
      End If
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Private Sub btnChangePassword_Click(sender As Object, e As EventArgs) Handles btnChangePassword.Click
    Try
      Dim vUserId As Int32 = Session("sUserId")
      Dim vEmail As String = LCase(Request.QueryString("e"))
      If Len(txtNewPassword.Text) < 8 Then
        valMinChars.IsValid = False
        Exit Sub
      End If
      Dim oUser As USER
      pnlSuccess.Visible = False
      pnlFailed.Visible = False
      If vUserId <> 0 Then
        'change paassword using user id
        Using oDB As New zakatEntities
          If (From USER In oDB.USER Where USER.userId = vUserId And USER.password = txtCurrentPassword.Text).Any Then
            'userid/password combination exists
            oUser = (From USER In oDB.USER Where USER.userId = vUserId).First
            oUser.password = txtNewPassword.Text
            ''oUser.isAuthenticated = True
            oDB.SaveChanges()
            showSuccess()
          Else
            'userid/password combination does not exist
            showFailed()
          End If
        End Using
      ElseIf vEmail <> "" Then
        'change password using email
        Using oDB As New zakatEntities
          If (From USER In oDB.USER Where LCase(USER.email) = vEmail And USER.password = txtCurrentPassword.Text).Any Then
            'userid/password combination exists
            oUser = (From USER In oDB.USER Where LCase(USER.email) = vEmail).First
            oUser.password = txtNewPassword.Text
            ''oUser.isAuthenticated = True
            oDB.SaveChanges()
            showSuccess()
          Else
            'userid/password combination does not exist
            showFailed()
          End If
        End Using
      Else
        'redirect to home
        Response.Redirect("default")
      End If
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

  Sub showSuccess()
    txtCurrentPassword.Text = ""
    txtNewPassword.Text = ""
    txtConfirmPassword.Text = ""
    pnlSuccess.Visible = True
  End Sub

  Sub showFailed()
    txtCurrentPassword.Text = ""
    txtNewPassword.Text = ""
    txtConfirmPassword.Text = ""
    pnlFailed.Visible = True
  End Sub

End Class