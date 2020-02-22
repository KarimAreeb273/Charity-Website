Public Class Forgot
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

  End Sub

  Private Sub btnResetPassword_Click(sender As Object, e As EventArgs) Handles btnResetPassword.Click
    Try
      Using oDB As New zakatEntities
        pnlFailed.Visible = False
        pnlSuccess.Visible = False
        If (From USER In oDB.USER Where USER.email = txtEmail.Text).Any Then
          Dim oUser As USER = (From USER In oDB.USER Where USER.email = txtEmail.Text).First
          Dim vPassword As String = Base.getPassword()
          oUser.password = vPassword
          oDB.SaveChanges()

          'create email to member that forgot password
          Dim vTo As String = txtEmail.Text
          Dim vSubject As String = "ICCL - Membership Application Password Reset"
          Dim vMsgText As New StringBuilder

          vMsgText.Append("Assalaamu Alaykum " & oUser.firstName & ",<br /><br />")
          vMsgText.Append("You recently indicated that you forgot your ICCL Membership Application account password.  As a result, we have reset your password to an auto-generated one.  ")
          vMsgText.Append("Please click or copy/paste the website link below and use the account information provided to login to your account and set your password.<br /><br />")
          vMsgText.Append("<b>Website Link:</b> <a href='https://membership.icclmd.org/password?e=" & txtEmail.Text & "'>https://membership.icclmd.org/password?e=" & txtEmail.Text & "</a><br />")
          vMsgText.Append("<b>Password:</b>  <i>" & vPassword & "</i><br /><br />")
          vMsgText.Append("If you have issues regarding your account, please don’t hesitate to contact us.<br /><br />")
          vMsgText.Append("Thank you,<br /><br />")
          vMsgText.Append("ICCL Membership Administrator<br />")
          vMsgText.Append("<a href ='mailto:membership@icclmd.org'>membership@icclmd.org</a><br />")
          vMsgText.Append("7306 Contee Road<br />")
          vMsgText.Append("Laurel, MD 20707<br />")
          vMsgText.Append("<a href='https://membership.icclmd.org'>https://membership.icclmd.org</a>")
          Dim vSend As Boolean = Base.sendEmail(vTo, vSubject, vMsgText.ToString)
          pnlSuccess.Visible = True
        Else
          pnlFailed.Visible = True
        End If
      End Using
    Catch ex As Exception
      Response.Write(ex.Message)
    End Try
  End Sub

End Class