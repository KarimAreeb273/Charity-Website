Public Class AdminFunctions
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      Dim vIsAdministrator As Boolean = Session("sIsAdministrator")
      If vUserId = 0 OrElse (Not vIsAdministrator) Then Response.Redirect("/", False)

    Catch ex As Exception
      Dim eURL As String = "You have just encountered an error. Please contact <font color=blue> <u>zakat@icclmd.org</u> </font> regarding the error you just received. The error you just received is shown below: <br /><br />" + ex.Message
      Response.Redirect("ModalPopup.html?returnURL=" + Replace(Request.FilePath, "/", "") + "&eURL=" + eURL)
    End Try
  End Sub

  Private Sub btnEncryptUserPasswords_Click(sender As Object, e As EventArgs) Handles btnEncryptUserPasswords.Click
    'Try
    '  Using oDB As New zakatEntities
    '    'get all the votes casted if any have been casted
    '    If (From USER In oDB.USER).Any Then
    '      Dim oUser As List(Of USER) = (From USER In oDB.USER).ToList
    '      Dim vPasswordEncrypted As String
    '      'encrypt each password and store it in the encrypted password field.  Also make the password field blank
    '      For Each item In oUser
    '        Dim oUserEncrypted As USER = (From USER In oDB.USER Where USER.userId = item.userId).First
    '        vPasswordEncrypted = Base.encryptString(item.password.ToString)
    '        With oUserEncrypted
    '          .passwordEncrypted = vPasswordEncrypted
    '          '.password = ""
    '        End With
    '        oDB.SaveChanges()
    '      Next
    '    End If
    '  End Using
    '  lblMessage.Text = "Password Action Complete"
    'Catch ex As Exception
    '  Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
    '  Response.Write(ex.Message)
    'End Try
  End Sub

  Private Sub btnEncryptUserSSNs_Click(sender As Object, e As EventArgs) Handles btnEncryptUserSSNs.Click
    'Try
    '  Using oDB As New zakatEntities
    '    'get all the votes casted if any have been casted
    '    If (From USER In oDB.USER Where USER.socialSecurityNumber <> Nothing).Any Then
    '      Dim oUser As List(Of USER) = (From USER In oDB.USER Where USER.socialSecurityNumber <> Nothing).ToList
    '      Dim vUserSSNEncrypted As String
    '      'encrypt each SSN and store it in the encrypted SSN field.  Also make the SSN field blank
    '      For Each item In oUser
    '        Dim oUserSSNEncrypted As USER = (From USER In oDB.USER Where USER.userId = item.userId).First
    '        vUserSSNEncrypted = Base.encryptString(item.socialSecurityNumber.ToString)
    '        With oUserSSNEncrypted
    '          .socialSecurityNumberEncrypted = vUserSSNEncrypted
    '          '.socialSecurityNumber = ""
    '        End With
    '        oDB.SaveChanges()
    '      Next
    '    End If
    '  End Using
    '  lblMessage.Text = "SSN Action Complete"
    'Catch ex As Exception
    '  Response.Write("You have just encountered an error.  Please contact <a href='mailto:zakat@icclmd.org?subject=Error Encountered on http://zakat.icclmd.org&body=The following error was encountered on http://zakat.icclmd.org: <replace with entire error content>'>zakat@icclmd.org</a> and copy/paste the entire error content shown below in the email.<br /><br />")
    '  Response.Write(ex.Message)
    'End Try
  End Sub
End Class