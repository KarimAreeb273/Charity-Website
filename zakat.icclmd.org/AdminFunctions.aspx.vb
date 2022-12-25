﻿Public Class AdminFunctions
  Inherits System.Web.UI.Page

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Try
      'go home if no session/user
      Dim vUserId As Int32 = Session("sUserId")
      Dim vIsAdministrator As Boolean = Session("sIsAdministrator")
      If vUserId = 0 OrElse (Not vIsAdministrator) Then Response.Redirect("/")

    Catch ex As Exception
      Response.Write(ex.Message)
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
    '  Response.Write(ex.Message)
    'End Try
  End Sub
End Class