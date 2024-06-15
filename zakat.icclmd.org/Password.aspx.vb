Public Class Password
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      Dim vUserId As Int32 = Session("sUserId")
      Dim vEmail As String = LCase(Request.QueryString("e"))
      If vUserId = 0 And vEmail = "" Then
        'redirect to home
        Response.Redirect("/")
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
            Response.Redirect("/")
          End If
        End Using
      End If
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
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
      Dim vCurrentPassword As String = txtCurrentPassword.Text
      Dim vCurrentPasswordEncrypted As String = Base.encryptString(txtCurrentPassword.Text)
      Dim vNewPassword As String = txtNewPassword.Text
      Dim vNewPasswordEncrypted As String = Base.encryptString(txtNewPassword.Text)
      Dim oUser As USER
      pnlSuccess.Visible = False
      pnlFailed.Visible = False
      If vUserId <> 0 Then
        Using oDB As New zakatEntities
          'If (From USER In oDB.USER Where USER.userId = vUserId And USER.password = txtCurrentPassword.Text).Any Then
          If (From USER In oDB.USER Where USER.userId = vUserId And USER.passwordEncrypted = vCurrentPasswordEncrypted).Any Then
            oUser = (From USER In oDB.USER Where USER.userId = vUserId).First
            'oUser.password = txtNewPassword.Text
            oUser.passwordEncrypted = vNewPasswordEncrypted
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
          'If (From USER In oDB.USER Where LCase(USER.email) = vEmail And USER.password = txtCurrentPassword.Text).Any Then
          If (From USER In oDB.USER Where LCase(USER.email) = vEmail And USER.passwordEncrypted = vCurrentPasswordEncrypted).Any Then
            oUser = (From USER In oDB.USER Where LCase(USER.email) = vEmail).First
            'oUser.password = txtNewPassword.Text
            oUser.passwordEncrypted = vNewPasswordEncrypted
            oDB.SaveChanges()
            showSuccess()
          Else
            'userid/password combination does not exist
            showFailed()
          End If
        End Using
      Else
        'redirect to home
        Response.Redirect("/")
      End If
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Sub showSuccess()
    Try
      txtCurrentPassword.Text = ""
      txtNewPassword.Text = ""
      txtConfirmPassword.Text = ""
      pnlSuccess.Visible = True
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Sub showFailed()
    Try
      txtCurrentPassword.Text = ""
      txtNewPassword.Text = ""
      txtConfirmPassword.Text = ""
      pnlFailed.Visible = True
    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub
End Class